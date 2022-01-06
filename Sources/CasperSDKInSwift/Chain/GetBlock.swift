//
//  Created by Hien on 11/12/2021.
//
//https://docs.rs/casper-node/latest/casper_node/rpcs/chain/struct.GetBlock.html

import Foundation
class GetBlock {
    //use this link for test https://testnet.cspr.live/block/96cc35D79bA8c9961A7E7573FFAc9eA5ABdeB167500206B7fe67D7BB843325cD
    
    let methodStr : String = "chain_get_block"
    public static func getBlock(from:[String:Any]) throws -> GetBlockResult {
        var getBlockResult : GetBlockResult = GetBlockResult();
        do {
            if let id = from["id"] as? Int {
                print("id back:\(id)")
            } else {
                print("cant get id")
            }
            if let jsonCPR = from["jsonrpc"] as? String {
                print("jsonCPR:\(jsonCPR)")
            } else {
                print("can get json CPR")
            }
            if let result = from["result"] as? [String:Any] {
                if let apiVersion = result["api_version"] as? String {
                    print("api_version back:\(apiVersion)")
                    getBlockResult.apiVersion = apiVersion
                } else {
                    print("cant get api_version")
                }
                if let block = result["block"] as? [String:Any] {
                    var getBlock:Block = Block();
                    getBlockResult.block = getBlock;
                    
                    //GET BLOCK HASH
                    if let hash = block["hash"] as? String {
                        getBlock.hash = hash;
                        print("BlockHash:\(hash)")
                    }//END OF GETTING BLOCK HASH
                    //START GETTING HEADER
                    if let blockHeader = block["header"] as? [String:Any] {//10 items
                        var getBlockHeader : BlockHeader = BlockHeader();
                        getBlockResult.block.header = getBlockHeader;
                        if let accumulatedSeed = blockHeader["accumulated_seed"] as? String {//1
                            getBlockHeader.accumulatedSeed = accumulatedSeed;
                            print("accumulatedSeed:\(accumulatedSeed)")
                        }
                        if let bodyHash = blockHeader["body_hash"] as? String {//2
                            getBlockHeader.bodyHash = bodyHash;
                            print("bodyHash:\(bodyHash)")
                        }
                        if let eraId = blockHeader["era_id"] as? UInt64 {//3
                            getBlockHeader.eraID = eraId;
                            print("eraID:\(eraId)")
                        }
                        if let Height = blockHeader["height"] as? UInt64 {//4
                            getBlockHeader.height = Height;
                            print("Height:\(Height)")
                        }
                        if let parentHash = blockHeader["parent_hash"] as? String {//5
                            getBlockHeader.parentHash = parentHash
                            print("parentHash:\(parentHash)")
                        }
                        if let protocolVersion = blockHeader["protocol_version"] as? String {//6
                            let pVersion:ProtocolVersion = ProtocolVersion();
                            pVersion.setProtolString(str: protocolVersion)
                            getBlockHeader.protocolVersion = pVersion;
                        }
                        if let randomBit = blockHeader["random_bit"] as? Bool {//7
                            getBlockHeader.randomBit = randomBit;
                        }
                        if let stateRootHash = blockHeader["state_root_hash"] as? String {//8
                            getBlockHeader.stateRootHash = stateRootHash;
                            print("StateRootHash:\(stateRootHash)")
                        }
                        if let timeStamp = blockHeader["timestamp"] as? String {//9
                            getBlockHeader.timeStamp = timeStamp
                        }
                        //era_end // 2 items
                        if let eraEnd = blockHeader["era_end"] as? [String:Any] {//2 items
                            var getEraEnd:EraEnd = EraEnd();
                            getBlockHeader.eraEnd = getEraEnd;
                            //item 1: era_report
                            if let eraReport = eraEnd["era_report"] as? [String:Any] {//3 items
                                var getEraReport:EraReport = EraReport();
                                getEraEnd.eraReport = getEraReport;
                                //equivocators
                                if let equivocators = eraReport["equivocators"] as? [String] { // a list of equivocators
                                    let totalEquivocator = equivocators.count;
                                    print("total equivocator:\(totalEquivocator)")
                                    for equivocator in equivocators {
                                        getEraReport.equivocators.append(equivocator)
                                        print("getEraReport:\(getEraReport)")
                                    }
                                }
                                //inactive_validators
                                if let inactiveValidators = eraReport["inactive_validators"] as? [String] { // a list of inactive_validators
                                    let totalInactiveValidators = inactiveValidators.count;
                                    print("total inactiveValidators:\(totalInactiveValidators)")
                                    for inactiveValidator in inactiveValidators {
                                        getEraReport.inactiveValidators.append(inactiveValidator)
                                    }
                                }
                                //reward
                                
                                if let rewards = eraReport["rewards"] as? [AnyObject] { // a list of equivocators
                                    let totalRewards = rewards.count;
                                    print("total rewards:\(totalRewards)")
                                    for reward in rewards {
                                        if let amount = reward["amount"] as? UInt64 {
                                            if let validator = reward["validator"] as? String {
                                                var rewardItem : RewardItem = RewardItem();
                                                rewardItem.amount = amount;
                                                rewardItem.validator = validator;
                                                getEraReport.rewards.append(rewardItem);
                                            }
                                        }
                                        //getEraReport.rewards.append(reward);
                                    }
                                }
                                
                            }//end of  get era report
                            
                            //item 2: next_era_validator_weights
                            if let nextEraValidatorWeights = eraEnd["next_era_validator_weights"] as? [AnyObject] {
                                //var
                                for nevw in nextEraValidatorWeights {
                                    
                                }
                            }
                        }//end of get era end
                    }
                    //END OF GETTING HEADER
                    //START GETTING BLOCK BODY
                    if let blockBody = block["body"] as? [String:Any] {
                        var getBlockBody:BlockBody = BlockBody();
                        getBlock.body = getBlockBody;
                        //GET DEPLOY HASH LIST
                        if let deployHashes = blockBody["deploy_hashes"] as? [String]{
                            let totalDeployHash = deployHashes.count;
                            print("total Deploy Hash:\(totalDeployHash)")
                            for deployHash in deployHashes {
                                print("deployHash:\(deployHash)")
                                getBlockBody.deployHash.append(deployHash as! String)
                            }
                        }
                        //GET TRANSFER HASH LIST
                        if let transferHashes = blockBody["deploy_hashes"] as? [AnyObject]{
                            let totalTransferHash = transferHashes.count;
                            print("total Transfer Hash:\(totalTransferHash)")
                            for transferHash in transferHashes {
                                print("transferHash:\(transferHash)")
                                getBlockBody.transferHash.append(transferHash as! String)
                            }
                        }
                        //GET PROPOSER
                        if let proposer = blockBody["proposer"] as? String {
                            getBlockBody.proposer = proposer;
                            print("block body proposer:\(proposer)")
                        }
                    }//END OF GETTTING BLOCK BODY
                    //START GETTING PROOFS
                    if let proofs = block["proofs"] as? [AnyObject] {
                        let totalProof = proofs.count;
                        print("Total proof:\(totalProof)")
                       // var counter:Int = 0;
                        for proof in proofs {
                            let oneProof:ProofItem = ProofItem();
                            if let publicKey = proof["public_key"] as? String {
                                if let signature = proof["signature"] as? String {
                                   // counter += 1;
                                    oneProof.publicKey = publicKey;
                                    oneProof.signature = signature;
                                    getBlock.proofs.append(oneProof);
                                  //  print("Counter \(counter), Add one Proof, publicKey:\(publicKey), signature:\(signature)")
                                }
                            }
                        }
                        
                    }
                    //END OF GETTING PROOFS
                }
            }
        } catch {
            print("error get block : \(error)")
        }
        return getBlockResult;
    }
}
