import Foundation
import XCTest
/**
 HttpHandler Class for handling sending request for RPC methods and retrieving data back
 */

class HttpHandler:XCTestCase {
    ///Method URL for calling RPC method, can be local, test net or main net
    static var methodURL:String = "https://node-clarity-testnet.make.services/rpc";
    ///RPC method, which can be chain_get_state_root_hash or info_get_peers or info_get_deploy ....
    public var methodCall:CasperMethodCall = .chainGetStateRootHash;
    
    public func putDeploy(method:CasperMethodCall,params:Data,httpMethod:String="POST",deployHash:String="") throws {
        guard let url = URL(string: HttpHandler.methodURL) else {
            throw CasperMethodError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = params
        let expectation = self.expectation(description: "Getting json data from casper")
        let task = URLSession.shared.dataTask(with: request)  { data, response, error in
            guard let data = data, error == nil else {
                NSLog(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options:[])
            if let responseJSON = responseJSON as? [String: Any] {
                if let errorDeploy = responseJSON["error"] as? [String:Any] {
                    var code:Int!
                    var message:String!
                    if let code1 = errorDeploy["code"] as? Int {
                        code = code1
                    }
                    if let message1 = errorDeploy["message"] as? String {
                        message = message1
                    }
                    NSLog("Error put deploy, with Error code:\(code!) and message:")
                    NSLog(message)
                } else {
                    do {
                        let deploy_hash = try DeployUtil.getDeployResult(from: responseJSON)
                        XCTAssert(deployHash == deploy_hash)
                        NSLog("Put deploy successful with deploy_hash:\(deploy_hash)");
                    } catch {
                        NSLog("Error put deploy")
                    }
                }
            }
            expectation.fulfill()
        }
        task.resume()
        self.waitForExpectations(timeout: 500, handler: nil)
    }
    /**
     This function handle the request with specific RPC call and given parameter for each method
        - Parameter :
                - method: The RPC method to be called, such as chain_get_state_root_hash or info_get_peers or info_get_deploy ... as declared in enumeration type CasperMethodCall
                - params: The parameter for the RPC method call. The parameter data is changed through a function for each RPC method call, for example with chain_get_block_transfers RPC method, the raw parameter is the BlockIdentifier. The BlockIdentifier is changed through a function like this:
                let blockIdentifier : BlockIdentifier = .Height(1000)
                let jsonData = JsonConversion.fromBlockIdentifierToJsonData(input:blockIdentifier,method: .chainGetBlockTransfer)
                Then the jsonData can be passed to the HttpHandler class to call for chain_get_block_transfers RPC method like this:
                try httpHandler.handleRequest(method: methodCall, params: jsonData)
                -httpMethod: can be PUT, POST, GET, the default value is POST
        - Throws: CasperMethodCallError.CasperError with code and message according to the error returned by the Casper system
        - Returns: GetBlockResult object
        */

    public func handleRequest(method:CasperMethodCall,params:Data,httpMethod:String="POST") throws {
        guard let url = URL(string: HttpHandler.methodURL) else {
            throw CasperMethodError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = params
        let expectation = self.expectation(description: "Getting json data from casper")
        let task = URLSession.shared.dataTask(with: request)  { data, response, error in
            guard let data = data, error == nil else {
                NSLog(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options:[])
            if let responseJSON = responseJSON as? [String: Any] {
                if self.methodCall == .chainGetStateRootHash {
                    do {
                        let stateRootHash = try GetStateRootHash.getStateRootHash(from: responseJSON);
                         XCTAssertEqual(stateRootHash.count,64,"Error data back, state_root_hash should be 64 length string")
                        NSLog("StateRootHash: %@\n", stateRootHash)
                    }
                    catch {
                        NSLog("Error:\(error)")
                    }
                 } else if self.methodCall == .infoGetPeer {
                    do {
                        let getPeer:GetPeersResult = try GetPeers.getPeers(from: responseJSON)
                        //This is for testing result back, comment this if you don't want to make test
                        XCTAssert(!getPeer.getPeerMap().getPeerEntryList().isEmpty)
                        NSLog("Total peers:\(getPeer.getPeerMap().getPeerEntryList().count)\n")
                        if let firstPeer = getPeer.getPeerMap().getPeerEntryList().first {
                            XCTAssert(!firstPeer.getAddress().isEmpty)
                            XCTAssert(!firstPeer.getNodeId().isEmpty)
                            NSLog("First peerAddress:\(firstPeer.getAddress())\n")
                            NSLog("First peerID:\(firstPeer.getNodeId())\n")
                        }
                   } catch {
                       
                   }
                } else if self.methodCall == .infoGetDeploy {
                    do {
                        let getDeployResult : GetDeployResult = try GetDeploy.getDeploy(from: responseJSON)
                        XCTAssert(getDeployResult.deploy.hash.count==64)
                        XCTAssert(getDeployResult.deploy.header.body_hash.count == 64)
                        NSLog("Total deploy approvals:\(getDeployResult.deploy.approvals.count)")
                        NSLog("Payment:\(getDeployResult.deploy.payment!)")
                        NSLog("Session:\(getDeployResult.deploy.session!)")
                        NSLog("Total JsonExecutionResult:\(getDeployResult.execution_results.count)")
                        if(getDeployResult.execution_results.count>0) {
                            NSLog("ExecutionResult block_hash:\(getDeployResult.execution_results.first!.block_hash)")
                            NSLog("ExecutionResult:\(getDeployResult.execution_results.first!.result)")
                            switch getDeployResult.execution_results.first!.result {
                            case .Success(effect: let retEffect, transfers: let retTransfers, cost: let retCost):
                                NSLog("ExecutionResult Success with cost:\(retCost.valueInStr)")
                                NSLog("ExecutionResult total Transfer:\(retTransfers.count)")
                                NSLog("ExecutionResult Effect, total Transform:\(retEffect.transforms.count)")
                                NSLog("ExecutionResult Effect, total Operation:\(retEffect.operations.count)")
                                if retEffect.transforms.count > 0  {
                                    let firstTranformEntry:TransformEntry = retEffect.transforms.first!
                                    NSLog("First TransformEntry key:\(firstTranformEntry.key)")
                                }
                                break
                            case .Failure(effect: let retEffect, transfers: let retTransfers, cost: let retCost, error_message: let retErrorMessage):
                                NSLog("ExecutionResult Failure with cost:\(retCost.valueInStr) and error message:\(retErrorMessage)")
                                NSLog("ExecutionResult total Transfer:\(retTransfers.count)")
                                NSLog("ExecutionResult Effect, total Transform:\(retEffect.transforms.count)")
                                NSLog("ExecutionResult Effect, total Operation:\(retEffect.operations.count)")
                                if retEffect.transforms.count > 0  {
                                    let firstTranformEntry:TransformEntry = retEffect.transforms.first!
                                    NSLog("First TransformEntry key:\(firstTranformEntry.key)")
                                }
                                break;
                            default:
                                break;
                            }
                        }
                    }
                    catch {
                        NSLog("Error:\(error)")
                   }
                } else if self.methodCall == .infoGetStatus {
                    do {
                        let getStatusResult:GetStatusResult = try GetStatus.getStatus(from:responseJSON)
                        XCTAssert(getStatusResult.starting_state_root_hash.count == 64)
                        XCTAssert(!getStatusResult.peers.getPeerEntryList().isEmpty)
                        let firstPeer = getStatusResult.peers.getPeerEntryList().first
                        XCTAssert(!firstPeer!.getAddress().isEmpty)
                        XCTAssert(!firstPeer!.getNodeId().isEmpty)
                        NSLog("Total peers:\(getStatusResult.peers.getPeerEntryList().count)\n")
                        NSLog("First peerAddress:\(firstPeer!.getAddress())\n")
                        NSLog("First peerID:\(firstPeer!.getNodeId())\n")
                    } catch {
                        NSLog("Error:\(error)")
                    }
                }  else if self.methodCall == .chainGetBlockTransfer {
                    do {
                        let getBlockTransferResult:GetBlockTransfersResult = try GetBlockTransfers.getResult(from: responseJSON)
                        NSLog("In chain_get_block_transfers, block_hash:\(getBlockTransferResult.block_hash)")
                        XCTAssert(getBlockTransferResult.block_hash.count == 64)
                        if getBlockTransferResult.transfers != nil {
                            NSLog("Total Transfer:\(getBlockTransferResult.transfers!.count)")
                            if getBlockTransferResult.transfers!.count > 0 {
                                let firstTransfer = getBlockTransferResult.transfers!.first!
                                NSLog("First transfer deploy_hash:\(firstTransfer.deploy_hash!)")
                                NSLog("First transfer from:\(firstTransfer.from!)")
                                NSLog("First transfer source:\(firstTransfer.source.value!)")
                                NSLog("First transfer target:\(firstTransfer.target.value!)")
                                NSLog("First transfer gas:\(firstTransfer.gas.valueInStr)")
                                NSLog("First transfer id:\(firstTransfer.id!)")
                            }
                        }
                    } catch {
                        NSLog("Error:\(error)")
                    }
                } else if self.methodCall == .chainGetBlock {
                    do {
                        let getBlockResult:GetBlockResult = try GetBlock.getBlock(from: responseJSON)
                        //check for block
                        XCTAssert(getBlockResult.block.hash.count == 64)
                        //check for block header
                        XCTAssert(getBlockResult.block.header.body_hash.count == 64)
                        XCTAssert(getBlockResult.block.header.state_root_hash.count == 64)
                        XCTAssert(getBlockResult.block.header.height > 0)
                        //check for block body
                        XCTAssert(getBlockResult.block.body.proposer.value.count == 66)
                        NSLog("Block body total deploy hash:\(getBlockResult.block.body.deployHash.count)")
                        NSLog("Block body total transfer hash:\(getBlockResult.block.body.transferHash.count)")
                        NSLog("Block body proposer:\(getBlockResult.block.body.proposer.value)")
                        if getBlockResult.block.body.deployHash.count > 0 {
                            XCTAssert(getBlockResult.block.body.deployHash.first!.value!.count == 64)
                            NSLog("Block body first deploy hash:\(getBlockResult.block.body.deployHash.first!.value!)")
                        }
                        if getBlockResult.block.body.transferHash.count > 0 {
                            XCTAssert(getBlockResult.block.body.transferHash.first!.value!.count == 64)
                            NSLog("Block body first transfer hash:\(getBlockResult.block.body.transferHash.first!.value!)")
                        }
                        //check for block proofs
                        NSLog("Block total proof:\(getBlockResult.block.proofs.count)")
                        if getBlockResult.block.proofs.count > 0 {
                            let firstProof:JsonProof = getBlockResult.block.proofs.first!
                            XCTAssert(firstProof.publicKey.value.count == 66)
                            XCTAssert(firstProof.signature.count>0)
                            NSLog("Block first proof public key:\(firstProof.publicKey.value)")
                            NSLog("Block first proof signature:\(firstProof.signature)")
                        }
                    } catch {
                        NSLog("Error:\(error)")
                    }
                } else if self.methodCall == .chainGetEraInfoBySwitchBlock {
                    do {
                        let eraResult:GetEraInfoResult = try GetEraInfoBySwitchBlock.getResult(from: responseJSON)
                        if eraResult.era_summary != nil {
                            XCTAssert(eraResult.era_summary!.state_root_hash.count == 64)
                            XCTAssert(eraResult.era_summary!.block_hash.count == 64)
                            NSLog("Era state root hash:\(eraResult.era_summary!.state_root_hash)")
                            NSLog("Era block hash:\(eraResult.era_summary!.block_hash)")
                            NSLog("Era merkle_proof length:\(eraResult.era_summary!.merkle_proof.count)")
                            NSLog("Era stored_value:\(eraResult.era_summary!.stored_value)")
                            self.XCTAssertForStoredValue(methodCall: "chain_get_era_info_by_switch_block", value: eraResult.era_summary!.stored_value)
                            XCTAssert(eraResult.era_summary!.merkle_proof.count > 1000)
                        }
                    } catch {
                        NSLog("Error:\(error)")
                    }
                } else if self.methodCall == .stateGetItem {
                    do {
                        let getStateItemResult: GetItemResult =  try GetItem.getItem(from:responseJSON)
                        self.XCTAssertForStoredValue(methodCall: "state_get_item", value: getStateItemResult.stored_value)
                        NSLog("StateGetItem merkle_proof length:\(getStateItemResult.merkle_proof.count)")
                        XCTAssert(getStateItemResult.merkle_proof!.count>1000)
                    } catch {
                        NSLog("Error:\(error)")
                    }
                } else if self.methodCall == .stateGetDictionaryItem {
                    do {
                        let getDictionaryItemResult : GetDictionaryItemResult = try GetDictionaryItemResult.getResult(from: responseJSON)
                        self.XCTAssertForStoredValue(methodCall: "state_get_dictionary_item", value: getDictionaryItemResult.stored_value)
                        NSLog("GetDictionaryItem merkle_proof length:\(getDictionaryItemResult.merkle_proof.count)")
                        XCTAssert(getDictionaryItemResult.merkle_proof.count>1000)
                        NSLog("GetDictionaryItemResult dictionary_key:\(getDictionaryItemResult.dictionary_key!)")
                    }
                    catch {
                        NSLog("Error:\(error)")
                    }
                }  else if self.methodCall == .stateGetBalance {
                    do {
                        let getBalanceResult:GetBalanceResult = try GetBalance.getStateBalanceFromJson(from: responseJSON)
                        NSLog("GetBalanceResult, balance_value: \(getBalanceResult.balance_value.valueInStr)")
                        NSLog("GetBalanceResult, merkle_proof length:\(getBalanceResult.merkle_proof.count)")
                        XCTAssert(getBalanceResult.merkle_proof.count > 1000)
                    } catch {
                        NSLog("Error got:\(error)")
                    }
                } else if self.methodCall == .stateGetAuctionInfo {
                    do {
                        let getAuctionInfo:GetAuctionInfoResult = try GetAuctionInfo.getAuctionInfo(from: responseJSON)
                        NSLog("AuctionState state_root_hash:\(getAuctionInfo.auction_state.state_root_hash)")
                        NSLog("AuctionState block_height:\(getAuctionInfo.auction_state.block_height)")
                        NSLog("AuctionState total era_validator:\(getAuctionInfo.auction_state.bids.count)")
                        if getAuctionInfo.auction_state.bids.count > 0 {
                            let firstBid:JsonBids = getAuctionInfo.auction_state.bids.first!
                            NSLog("AuctionState first bid public_key:\(firstBid.public_key.value)")
                            NSLog("AuctionState first bid staked_amount: \(firstBid.bid.staked_amount.valueInStr)")
                            NSLog("AuctionState first bid bonding_purse: \(firstBid.bid.bonding_purse.value!)")
                            NSLog("AuctionState first bid delegation_rate: \(firstBid.bid.delegation_rate)")
                            NSLog("AuctionState first bid inactive: \(firstBid.bid.inactive)")
                            NSLog("AuctionState first bid total delegator: \(firstBid.bid.delegators.count)")
                            if (firstBid.bid.delegators.count > 0) {
                                NSLog("Information for first bid first delegator")
                                let firstDelegator : JsonDelegator = firstBid.bid.delegators.first!
                                NSLog("First delegator bonding_purse:\(firstDelegator.bonding_purse.value!)")
                                NSLog("First delegator delegatee:\(firstDelegator.delegatee.value)")
                                NSLog("First delegator public_key:\(firstDelegator.public_key.value)")
                                NSLog("First delegator staked_amount:\(firstDelegator.staked_amount.valueInStr)")
                            }
                        }
                        
                    } catch  {
                        NSLog("Error :\(error)")
                    }
                }
            }
            expectation.fulfill()
        }
        task.resume()
        self.waitForExpectations(timeout: 500, handler: nil)
    }
    /**
        This function facilitate the test of StoredValue only
        - Parameter :
            - methodCall: The RPC method call, such as chain_get_state_root_hash or info_get_peers or info_get_deploy ..., just for Log the information which method is called.
            - value: of type StoredValue, used for XCTAssert the correctness of the result
        - Returns: none
        */

    public func XCTAssertForStoredValue(methodCall:String,value:StoredValue) {
        switch value {
        case .CLValue(let cLValue):
            NSLog("In \(methodCall), stored_value is CLValue")
            NSLog("In \(methodCall), CLValue of stored_value, bytes:\(cLValue.bytes)")
            NSLog("In \(methodCall), CLValue of stored_value,cl_type:\(cLValue.cl_type)")
            NSLog("In \(methodCall), CLValue of stored_value,parsed:\(cLValue.parsed)")
            break
        case .Account(let account):
            NSLog("In \(methodCall), stored_value is Account")
            NSLog("Account hash:\(account.account_hash.value!)")
            NSLog("Action threshold delployment:\(account.action_thresholds.deployment!)")
            NSLog("Action threshold key_management:\(account.action_thresholds.key_management!)")
            NSLog("Total associate key:\(account.associated_keys.count)")
            if account.associated_keys.count > 0 {
                let firstAK:AssociatedKey = account.associated_keys.first!
                NSLog("First associate_key account_hash:\(firstAK.account_hash.value!)")
                NSLog("First associate_key weight:\(firstAK.weight!)")
            }
            NSLog("Main purse:\(account.main_purse.value!)")
            NSLog("Total named_key:\(account.named_keys.count)")
            if account.named_keys.count > 0 {
                let firstKey = account.named_keys.first!
                NSLog("First named_key name:\(firstKey.name)")
                NSLog("First named_key key:\(firstKey.key)")
            }
            break
        case .ContractWasm(let string):
            NSLog("In \(methodCall), stored_value is ContractWasm with value:\(string)")
            break
        case .Contract(let contract):
            NSLog("In \(methodCall), stored_value is Contract")
            NSLog("Contract contract_package_hash:\(contract.contract_package_hash!)")
            NSLog("Contract contract_wasm_hash:\(contract.contract_wasm_hash!)")
            NSLog("Contract total named_key:\(contract.named_keys.count)")
            if contract.named_keys.count > 0 {
                let firstNK:NamedKey = contract.named_keys.first!
                NSLog("Contract first name_key name:\(firstNK.name)")
                NSLog("Contract first name_key key:\(firstNK.key)")
            }
            NSLog("Contract total entry_points:\(contract.entry_points.count)")
            if contract.entry_points.count > 0 {
                let firstEP:EntryPoint = contract.entry_points.first!
                NSLog("First entry_point name:\(firstEP.name!)")
                NSLog("First entry_point entry_point_type:\(firstEP.entry_point_type!)")
                NSLog("First entry_point ret:\(firstEP.ret!)")
                NSLog("First entry_point total args:\(firstEP.args.count)")
            }
            break
        case .ContractPackage(let contractPackage):
            NSLog("In \(methodCall), stored_value is ContractPackage")
            NSLog("ContractPackage access_key:\(contractPackage.access_key.value!)")
            NSLog("Total versions:\(contractPackage.versions.count)")
            NSLog("Total disabled_versions:\(contractPackage.disabled_versions.count)")
            NSLog("Total groups:\(contractPackage.groups.count)")
            break
        case .Transfer(let transfer):
            NSLog("In \(methodCall), stored_value is Transfer")
            NSLog("Transfer amount:\(transfer.amount.valueInStr)")
            NSLog("Transfer deploy_hash:\(transfer.deploy_hash!)")
            NSLog("Transfer from:\(transfer.from!)")
            NSLog("Transfer source:\(transfer.source.value!)")
            NSLog("Transfer target:\(transfer.target!)")
            break
        case .DeployInfo(let deployInfo):
            NSLog("In \(methodCall), stored_value is DeployInfo")
            NSLog("Deploy deploy_hash:\(deployInfo.deploy_hash)")
            NSLog("Deploy total transfer:\(deployInfo.transfers.count)")
            NSLog("Deploy from:\(deployInfo.from)")
            NSLog("Deploy source:\(deployInfo.source.value!)")
            NSLog("Deploy gas:\(deployInfo.gas.valueInStr)")
            break
        case .EraInfo(let eraInfo):
            NSLog("In \(methodCall), stored_value is EraInfo")
            NSLog("In \(methodCall), total seigniorage_allocations:\(eraInfo.listSeigniorageAllocation.count)")
            if eraInfo.listSeigniorageAllocation.count > 0 {
                let firstSA:SeigniorageAllocation = eraInfo.listSeigniorageAllocation.first!
                switch firstSA {
                case .Validator(let validator):
                    //XCTAssert(validator.validator_public_key.value.count == 66)
                    NSLog("Validator public key:\(validator.validator_public_key!)")
                    NSLog("Validator amount:\(validator.amount.valueInStr)")
                case .Delegator(let delegator):
                    XCTAssert(delegator.validator_public_key.value.count == 66)
                    XCTAssert(delegator.delegator_public_key.value.count == 66)
                    NSLog("Delegator amount:\(delegator.amount.valueInStr)")
                    NSLog("Delegator delegator_public_key:\(delegator.delegator_public_key.value)")
                    NSLog("Delegator validator_public_key:\(delegator.validator_public_key.value)")
                }
            }
        case .Bid(let bid):
            NSLog("In \(methodCall), stored_value is Bid")
            NSLog("validator_public_key:\(bid.validator_public_key.value)")
            NSLog("bonding_purse:\(bid.bonding_purse.value!)")
            NSLog("staked_amount:\(bid.staked_amount!)")
            NSLog("Total delegator:\(bid.delegators.count)")
            break
        case .Withdraw(let array):
            NSLog("In \(methodCall), stored_value is Withdraw")
            NSLog("Total UnbondingPurse:\(array.count)")
            if array.count > 0 {
                let firstUP : UnbondingPurse = array.first!
                NSLog("Withdraw first  UnbondingPurse, bonding_purse:\(firstUP.bonding_purse.value!)")
                NSLog("Withdraw first  UnbondingPurse, amount:\(firstUP.amount.valueInStr)")
                NSLog("Withdraw first  UnbondingPurse, era_of_creation:\(firstUP.era_of_creation)")
                NSLog("Withdraw first  UnbondingPurse, unbonder_public_key:\(firstUP.unbonder_public_key.value)")
                NSLog("Withdraw first  UnbondingPurse, validator_public_key:\(firstUP.validator_public_key.value)")
            }
            break
        case .None:
            NSLog("In \(methodCall), stored_value is None")
        }
    }
}
