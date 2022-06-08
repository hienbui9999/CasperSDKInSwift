import Foundation
import XCTest
/**
 HttpHandler Class for handling sending request for RPC methods and retrieving data back
 */

class HttpHandler: XCTestCase {
    /// Method URL for calling RPC method, can be local, test net or main net
    static var methodURL: String = "https: // node-clarity-testnet.make.services/rpc"
    /// RPC method, which can be chain_get_state_root_hash or info_get_peers or info_get_deploy ....
    public var methodCall: CasperMethodCall = .chainGetStateRootHash
    public var isSuccess:Bool = true
    public func putDeploy(method: CasperMethodCall, params: Data, httpMethod: String="POST", deployHash: String="") throws {
        guard let url = URL(string: HttpHandler.methodURL) else {
            throw CasperMethodError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = params
        let expectation = self.expectation(description: "Getting json data from casper")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                NSLog(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                if let errorDeploy = responseJSON["error"] as? [String: Any] {
                    var code: Int!
                    var message: String!
                    if let code1 = errorDeploy["code"] as? Int {
                        code = code1
                    }
                    if let message1 = errorDeploy["message"] as? String {
                        message = message1
                    }
                    //NSLog("Error put deploy, with Error code: \(code!) and message: ")
                    //NSLog(message)
                    if(message == "invalid deploy: the approval at index 0 is invalid: asymmetric key error: failed to verify secp256k1 signature: signature error") {
                        self.isSuccess = false
                    }
                } else {
                    do {
                        //NSLog("Put secp256k1 successfully after \(Utils.putDeployCounter) efforts")
                        let deployHash1 = try DeployUtil.getDeployResult(from: responseJSON)
                        XCTAssert(deployHash == deployHash1)
                        NSLog("Put deploy successful with deploy_hash: \(deployHash1)")
                    } catch {
                        NSLog("Error put deploy")
                    }
                }
            }
            expectation.fulfill()
        }
        task.resume()
        self.waitForExpectations(timeout: 500, handler: nil)
        if(self.isSuccess == false) {
            Utils.putDeploy()
        }
    }
    /**
     This function handle the request with specific RPC call and given parameter for each method
        - Parameter:
                - method: The RPC method to be called, such as chain_get_state_root_hash or info_get_peers or info_get_deploy ... as declared in enumeration type CasperMethodCall
                - params: The parameter for the RPC method call. The parameter data is changed through a function for each RPC method call, for example with chain_get_block_transfers RPC method, the raw parameter is the BlockIdentifier. The BlockIdentifier is changed through a function like this:
                let blockIdentifier: BlockIdentifier = .Height(1000)
                let jsonData = JsonConversion.fromBlockIdentifierToJsonData(input: blockIdentifier, method: .chainGetBlockTransfer)
                Then the jsonData can be passed to the HttpHandler class to call for chain_get_block_transfers RPC method like this:
                try httpHandler.handleRequest(method: methodCall, params: jsonData)
                -httpMethod: can be PUT, POST, GET, the default value is POST
        - Throws: CasperMethodCallError.CasperError with code and message according to the error returned by the Casper system
        - Returns: GetBlockResult object
        */

    public func handleRequest(method: CasperMethodCall, params: Data, httpMethod: String="POST") throws {
        guard let url = URL(string: HttpHandler.methodURL) else {
            throw CasperMethodError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = params
        let expectation = self.expectation(description: "Getting json data from casper")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                NSLog(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                if self.methodCall == .chainGetStateRootHash {
                    do {
                        let stateRootHash = try GetStateRootHash.getStateRootHash(from: responseJSON)
                         XCTAssertEqual(stateRootHash.count, 64, "Error data back, state_root_hash should be 64 length string")
                        NSLog("StateRootHash: %@\n", stateRootHash)
                    }
                    catch {
                        NSLog("Error: \(error)")
                    }
                 } else if self.methodCall == .infoGetPeer {
                    do {
                        let getPeer: GetPeersResult = try GetPeers.getPeers(from: responseJSON)
                        // This is for testing result back, comment this if you don't want to make test
                        XCTAssert(!getPeer.getPeerMap().getPeerEntryList().isEmpty)
                        NSLog("Total peers: \(getPeer.getPeerMap().getPeerEntryList().count)\n")
                        if let firstPeer = getPeer.getPeerMap().getPeerEntryList().first {
                            XCTAssert(!firstPeer.getAddress().isEmpty)
                            XCTAssert(!firstPeer.getNodeId().isEmpty)
                            NSLog("First peerAddress: \(firstPeer.getAddress())\n")
                            NSLog("First peerID: \(firstPeer.getNodeId())\n")
                        }
                   } catch {
                   }
                } else if self.methodCall == .infoGetDeploy {
                    do {
                        let getDeployResult: GetDeployResult = try GetDeploy.getDeploy(from: responseJSON)
                        XCTAssert(getDeployResult.deploy.hash.count==64)
                        XCTAssert(getDeployResult.deploy.header.bodyHash.count == 64)
                        NSLog("Total deploy approvals: \(getDeployResult.deploy.approvals.count)")
                        NSLog("Payment: \(getDeployResult.deploy.payment!)")
                        NSLog("Session: \(getDeployResult.deploy.session!)")
                        NSLog("Total JsonExecutionResult: \(getDeployResult.executionResults.count)")
                        if getDeployResult.executionResults.count > 0 {
                            NSLog("ExecutionResult block_hash: \(getDeployResult.executionResults.first!.blockHash)")
                            NSLog("ExecutionResult: \(getDeployResult.executionResults.first!.result)")
                            switch getDeployResult.executionResults.first!.result {
                            case .success(effect: let retEffect, transfers: let retTransfers, cost: let retCost):
                                NSLog("ExecutionResult Success with cost: \(retCost.valueInStr)")
                                NSLog("ExecutionResult total Transfer: \(retTransfers.count)")
                                NSLog("ExecutionResult Effect, total Transform: \(retEffect.transforms.count)")
                                NSLog("ExecutionResult Effect, total Operation: \(retEffect.operations.count)")
                                if retEffect.transforms.count > 0 {
                                    let firstTranformEntry: TransformEntry = retEffect.transforms.first!
                                    NSLog("First TransformEntry key: \(firstTranformEntry.key)")
                                }
                                break
                            case .failure(effect: let retEffect, transfers: let retTransfers, cost: let retCost, error_message: let retErrorMessage):
                                NSLog("ExecutionResult Failure with cost: \(retCost.valueInStr) and error message: \(retErrorMessage)")
                                NSLog("ExecutionResult total Transfer: \(retTransfers.count)")
                                NSLog("ExecutionResult Effect, total Transform: \(retEffect.transforms.count)")
                                NSLog("ExecutionResult Effect, total Operation: \(retEffect.operations.count)")
                                if retEffect.transforms.count > 0 {
                                    let firstTranformEntry: TransformEntry = retEffect.transforms.first!
                                    NSLog("First TransformEntry key: \(firstTranformEntry.key)")
                                }
                                break
                            default:
                                break
                            }
                        }
                    }
                    catch {
                        NSLog("Error: \(error)")
                   }
                } else if self.methodCall == .infoGetStatus {
                    do {
                        let getStatusResult: GetStatusResult = try GetStatus.getStatus(from: responseJSON)
                        XCTAssert(getStatusResult.startingStateRootHash.count == 64)
                        XCTAssert(!getStatusResult.peers.getPeerEntryList().isEmpty)
                        let firstPeer = getStatusResult.peers.getPeerEntryList().first
                        XCTAssert(!firstPeer!.getAddress().isEmpty)
                        XCTAssert(!firstPeer!.getNodeId().isEmpty)
                        NSLog("Total peers: \(getStatusResult.peers.getPeerEntryList().count)\n")
                        NSLog("First peerAddress: \(firstPeer!.getAddress())\n")
                        NSLog("First peerID: \(firstPeer!.getNodeId())\n")
                    } catch {
                        NSLog("Error: \(error)")
                    }
                }  else if self.methodCall == .chainGetBlockTransfer {
                    do {
                        let getBlockTransferResult: GetBlockTransfersResult = try GetBlockTransfers.getResult(from: responseJSON)
                        NSLog("In chain_get_block_transfers, block_hash: \(getBlockTransferResult.blockHash)")
                        XCTAssert(getBlockTransferResult.blockHash.count == 64)
                        if getBlockTransferResult.transfers != nil {
                            NSLog("Total Transfer: \(getBlockTransferResult.transfers!.count)")
                            if getBlockTransferResult.transfers!.count > 0 {
                                let firstTransfer = getBlockTransferResult.transfers!.first!
                                NSLog("First transfer deploy_hash: \(firstTransfer.deployHash!)")
                                NSLog("First transfer from: \(firstTransfer.from!)")
                                NSLog("First transfer source: \(firstTransfer.source.value!)")
                                NSLog("First transfer target: \(firstTransfer.target.value!)")
                                NSLog("First transfer gas: \(firstTransfer.gas.valueInStr)")
                                NSLog("First transfer id: \(firstTransfer.id!)")
                            }
                        }
                    } catch {
                        NSLog("Error: \(error)")
                    }
                } else if self.methodCall == .chainGetBlock {
                    do {
                        let getBlockResult: GetBlockResult = try GetBlock.getBlock(from: responseJSON)
                        // check for block
                        XCTAssert(getBlockResult.block.hash.count == 64)
                        // check for block header
                        XCTAssert(getBlockResult.block.header.bodyHash.count == 64)
                        XCTAssert(getBlockResult.block.header.stateRootHash.count == 64)
                        XCTAssert(getBlockResult.block.header.height > 0)
                        // check for block body
                        XCTAssert(getBlockResult.block.body.proposer.value.count == 66)
                        NSLog("Block body total deploy hash: \(getBlockResult.block.body.deployHash.count)")
                        NSLog("Block body total transfer hash: \(getBlockResult.block.body.transferHash.count)")
                        NSLog("Block body proposer: \(getBlockResult.block.body.proposer.value)")
                        if getBlockResult.block.body.deployHash.count > 0 {
                            XCTAssert(getBlockResult.block.body.deployHash.first!.value!.count == 64)
                            NSLog("Block body first deploy hash: \(getBlockResult.block.body.deployHash.first!.value!)")
                        }
                        if getBlockResult.block.body.transferHash.count > 0 {
                            XCTAssert(getBlockResult.block.body.transferHash.first!.value!.count == 64)
                            NSLog("Block body first transfer hash: \(getBlockResult.block.body.transferHash.first!.value!)")
                        }
                        // check for block proofs
                        NSLog("Block total proof: \(getBlockResult.block.proofs.count)")
                        if getBlockResult.block.proofs.count > 0 {
                            let firstProof: JsonProof = getBlockResult.block.proofs.first!
                            XCTAssert(firstProof.publicKey.value.count == 66)
                            XCTAssert(firstProof.signature.count>0)
                            NSLog("Block first proof public key: \(firstProof.publicKey.value)")
                            NSLog("Block first proof signature: \(firstProof.signature)")
                        }
                    } catch {
                        NSLog("Error: \(error)")
                    }
                } else if self.methodCall == .chainGetEraInfoBySwitchBlock {
                    do {
                        let eraResult: GetEraInfoResult = try GetEraInfoBySwitchBlock.getResult(from: responseJSON)
                        if eraResult.eraSummary != nil {
                            XCTAssert(eraResult.eraSummary!.stateRootHash.count == 64)
                            XCTAssert(eraResult.eraSummary!.blockHash.count == 64)
                            NSLog("Era state root hash: \(eraResult.eraSummary!.stateRootHash)")
                            NSLog("Era block hash: \(eraResult.eraSummary!.blockHash)")
                            NSLog("Era merkle_proof length: \(eraResult.eraSummary!.merkleProof.count)")
                            NSLog("Era stored_value: \(eraResult.eraSummary!.storedValue)")
                            self.XCTAssertForStoredValue(methodCall: "chain_get_era_info_by_switch_block", value: eraResult.eraSummary!.storedValue)
                            XCTAssert(eraResult.eraSummary!.merkleProof.count > 1000)
                        }
                    } catch {
                        NSLog("Error: \(error)")
                    }
                } else if self.methodCall == .stateGetItem {
                    do {
                        let getStateItemResult: GetItemResult =  try GetItem.getItem(from: responseJSON)
                        self.XCTAssertForStoredValue(methodCall: "state_get_item", value: getStateItemResult.storedValue)
                        NSLog("StateGetItem merkle_proof length: \(getStateItemResult.merkleProof.count)")
                        XCTAssert(getStateItemResult.merkleProof!.count>1000)
                    } catch {
                        NSLog("Error: \(error)")
                    }
                } else if self.methodCall == .stateGetDictionaryItem {
                    do {
                        let getDictionaryItemResult: GetDictionaryItemResult = try GetDictionaryItemResult.getResult(from: responseJSON)
                        self.XCTAssertForStoredValue(methodCall: "state_get_dictionary_item", value: getDictionaryItemResult.storedValue)
                        NSLog("GetDictionaryItem merkle_proof length: \(getDictionaryItemResult.merkleProof.count)")
                        XCTAssert(getDictionaryItemResult.merkleProof.count>1000)
                        NSLog("GetDictionaryItemResult dictionary_key: \(getDictionaryItemResult.dictionaryKey!)")
                    }
                    catch {
                        NSLog("Error: \(error)")
                    }
                }  else if self.methodCall == .stateGetBalance {
                    do {
                        let getBalanceResult: GetBalanceResult = try GetBalance.getStateBalanceFromJson(from: responseJSON)
                        NSLog("GetBalanceResult, balance_value: \(getBalanceResult.balanceValue.valueInStr)")
                        NSLog("GetBalanceResult, merkle_proof length: \(getBalanceResult.merkleProof.count)")
                        XCTAssert(getBalanceResult.merkleProof.count > 1000)
                    } catch {
                        NSLog("Error got: \(error)")
                    }
                } else if self.methodCall == .stateGetAuctionInfo {
                    do {
                        let getAuctionInfo: GetAuctionInfoResult = try GetAuctionInfo.getAuctionInfo(from: responseJSON)
                        NSLog("AuctionState state_root_hash: \(getAuctionInfo.auctionState.stateRootHash)")
                        NSLog("AuctionState block_height: \(getAuctionInfo.auctionState.blockHeight)")
                        NSLog("AuctionState total era_validator: \(getAuctionInfo.auctionState.bids.count)")
                        if getAuctionInfo.auctionState.bids.count > 0 {
                            let firstBid: JsonBids = getAuctionInfo.auctionState.bids.first!
                            NSLog("AuctionState first bid public_key: \(firstBid.publicKey.value)")
                            NSLog("AuctionState first bid staked_amount: \(firstBid.bid.stakedAmount.valueInStr)")
                            NSLog("AuctionState first bid bonding_purse: \(firstBid.bid.bondingPurse.value!)")
                            NSLog("AuctionState first bid delegation_rate: \(firstBid.bid.delegationRate)")
                            NSLog("AuctionState first bid inactive: \(firstBid.bid.inactive)")
                            NSLog("AuctionState first bid total delegator: \(firstBid.bid.delegators.count)")
                            if firstBid.bid.delegators.count > 0 {
                                NSLog("Information for first bid first delegator")
                                let firstDelegator: JsonDelegator = firstBid.bid.delegators.first!
                                NSLog("First delegator bonding_purse: \(firstDelegator.bondingPurse.value!)")
                                NSLog("First delegator delegatee: \(firstDelegator.delegatee.value)")
                                NSLog("First delegator public_key: \(firstDelegator.publicKey.value)")
                                NSLog("First delegator staked_amount: \(firstDelegator.stakedAmount.valueInStr)")
                            }
                        }
                    } catch  {
                        NSLog("Error: \(error)")
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
        - Parameter:
            - methodCall: The RPC method call, such as chain_get_state_root_hash or info_get_peers or info_get_deploy ..., just for Log the information which method is called.
            - value: of type StoredValue, used for XCTAssert the correctness of the result
        - Returns: none
        */

    public func XCTAssertForStoredValue(methodCall: String, value: StoredValue) {
        switch value {
        case .cLValue(let cLValue):
            NSLog("In \(methodCall), stored_value is CLValue")
            NSLog("In \(methodCall), CLValue of stored_value, bytes: \(cLValue.bytes)")
            NSLog("In \(methodCall), CLValue of stored_value, cl_type: \(cLValue.clType)")
            NSLog("In \(methodCall), CLValue of stored_value, parsed: \(cLValue.parsed)")
            break
        case .account(let account):
            NSLog("In \(methodCall), stored_value is Account")
            NSLog("Account hash: \(account.accountHash.value!)")
            NSLog("Action threshold delployment: \(account.actionThresholds.deployment!)")
            NSLog("Action threshold key_management: \(account.actionThresholds.keyManagement!)")
            NSLog("Total associate key: \(account.associatedKeys.count)")
            if account.associatedKeys.count > 0 {
                let firstAK: AssociatedKey = account.associatedKeys.first!
                NSLog("First associate_key account_hash: \(firstAK.accountHash.value!)")
                NSLog("First associate_key weight: \(firstAK.weight!)")
            }
            NSLog("Main purse: \(account.mainPurse.value!)")
            NSLog("Total named_key: \(account.namedKeys.count)")
            if account.namedKeys.count > 0 {
                let firstKey = account.namedKeys.first!
                NSLog("First named_key name: \(firstKey.name)")
                NSLog("First named_key key: \(firstKey.key)")
            }
            break
        case .contractWasm(let string):
            NSLog("In \(methodCall), stored_value is ContractWasm with value: \(string)")
            break
        case .contract(let contract):
            NSLog("In \(methodCall), stored_value is Contract")
            NSLog("Contract contract_package_hash: \(contract.contractPackageHash!)")
            NSLog("Contract contract_wasm_hash: \(contract.contractWasmHash!)")
            NSLog("Contract total named_key: \(contract.namedKeys.count)")
            if contract.namedKeys.count > 0 {
                let firstNK: NamedKey = contract.namedKeys.first!
                NSLog("Contract first name_key name: \(firstNK.name)")
                NSLog("Contract first name_key key: \(firstNK.key)")
            }
            NSLog("Contract total entry_points: \(contract.entryPoints.count)")
            if contract.entryPoints.count > 0 {
                let firstEP: EntryPoint = contract.entryPoints.first!
                NSLog("First entry_point name: \(firstEP.name!)")
                NSLog("First entry_point entry_point_type: \(firstEP.entryPointType!)")
                NSLog("First entry_point ret: \(firstEP.ret!)")
                NSLog("First entry_point total args: \(firstEP.args.count)")
            }
            break
        case .contractPackage(let contractPackage):
            NSLog("In \(methodCall), stored_value is ContractPackage")
            NSLog("ContractPackage access_key: \(contractPackage.accessKey.value!)")
            NSLog("Total versions: \(contractPackage.versions.count)")
            NSLog("Total disabled_versions: \(contractPackage.disabledVersions.count)")
            NSLog("Total groups: \(contractPackage.groups.count)")
            break
        case .transfer(let transfer):
            NSLog("In \(methodCall), stored_value is Transfer")
            NSLog("Transfer amount: \(transfer.amount.valueInStr)")
            NSLog("Transfer deploy_hash: \(transfer.deployHash!)")
            NSLog("Transfer from: \(transfer.from!)")
            NSLog("Transfer source: \(transfer.source.value!)")
            NSLog("Transfer target: \(transfer.target!)")
            break
        case .deployInfo(let deployInfo):
            NSLog("In \(methodCall), stored_value is DeployInfo")
            NSLog("Deploy deploy_hash: \(deployInfo.deployHash)")
            NSLog("Deploy total transfer: \(deployInfo.transfers.count)")
            NSLog("Deploy from: \(deployInfo.from)")
            NSLog("Deploy source: \(deployInfo.source.value!)")
            NSLog("Deploy gas: \(deployInfo.gas.valueInStr)")
            break
        case .eraInfo(let eraInfo):
            NSLog("In \(methodCall), stored_value is EraInfo")
            NSLog("In \(methodCall), total seigniorage_allocations: \(eraInfo.listSeigniorageAllocation.count)")
            if eraInfo.listSeigniorageAllocation.count > 0 {
                let firstSA: SeigniorageAllocation = eraInfo.listSeigniorageAllocation.first!
                switch firstSA {
                case .validator(let validator):
                    // XCTAssert(validator.validator_public_key.value.count == 66)
                    NSLog("Validator public key: \(validator.validatorPublicKey!)")
                    NSLog("Validator amount: \(validator.amount.valueInStr)")
                case .delegator(let delegator):
                    XCTAssert(delegator.validatorPublicKey.value.count == 66)
                    XCTAssert(delegator.delegatorPublicKey.value.count == 66)
                    NSLog("Delegator amount: \(delegator.amount.valueInStr)")
                    NSLog("Delegator delegator_public_key: \(delegator.delegatorPublicKey.value)")
                    NSLog("Delegator validator_public_key: \(delegator.validatorPublicKey.value)")
                }
            }
        case .bid(let bid):
            NSLog("In \(methodCall), stored_value is Bid")
            NSLog("validator_public_key: \(bid.validatorPublicKey.value)")
            NSLog("bonding_purse: \(bid.bondingPurse.value!)")
            NSLog("staked_amount: \(bid.stakedAmount!)")
            NSLog("Total delegator: \(bid.delegators.count)")
            break
        case .withdraw(let array):
            NSLog("In \(methodCall), stored_value is Withdraw")
            NSLog("Total UnbondingPurse: \(array.count)")
            if array.count > 0 {
                let firstUP: UnbondingPurse = array.first!
                NSLog("Withdraw first  UnbondingPurse, bonding_purse: \(firstUP.bondingPurse.value!)")
                NSLog("Withdraw first  UnbondingPurse, amount: \(firstUP.amount.valueInStr)")
                NSLog("Withdraw first  UnbondingPurse, era_of_creation: \(firstUP.eraOfCreation)")
                NSLog("Withdraw first  UnbondingPurse, unbonder_public_key: \(firstUP.unbonderPublicKey.value)")
                NSLog("Withdraw first  UnbondingPurse, validator_public_key: \(firstUP.validatorPublicKey.value)")
            }
            break
        case .none:
            NSLog("In \(methodCall), stored_value is None")
        }
    }

}
