//
//  Created by Hien on 11/12/2021.
//

import Foundation
class GetBlock {
    let methodStr : String = "chain_get_block"
    public static func getBlock(from:[String:Any]) throws -> GetBlockResult {
        let getBlockResult : GetBlockResult = GetBlockResult();
        do {
            if let id = from["id"] as? Int {
               
            } else {
                
            }
            if let jsonCPR = from["jsonrpc"] as? String {
              
            } else {
              
            }
            if let result = from["result"] as? [String:Any] {
                if let apiVersion = result["api_version"] as? String {
                  
                    getBlockResult.apiVersion = apiVersion
                } else {
                   
                }
                if let block = result["block"] as? [String:Any] {
                    let getBlock:Block = Block();
                    getBlockResult.block = getBlock;
                    if let hash = block["hash"] as? String {
                        getBlock.hash = hash;
                    }
                    //getting block header
                    if let blockHeader = block["header"] as? [String:Any] {//10 items
                        let getBlockHeader : BlockHeader = BlockHeader();
                        getBlockResult.block.header = getBlockHeader;
                        if let accumulatedSeed = blockHeader["accumulated_seed"] as? String {//1
                            getBlockHeader.accumulatedSeed = accumulatedSeed;
                        }
                        if let bodyHash = blockHeader["body_hash"] as? String {//2
                            getBlockHeader.bodyHash = bodyHash;
                        }
                        if let eraId = blockHeader["era_id"] as? UInt64 {//3
                            getBlockHeader.eraID = eraId;
                        }
                        if let Height = blockHeader["height"] as? UInt64 {//4
                            getBlockHeader.height = Height;
                        }
                        if let parentHash = blockHeader["parent_hash"] as? String {//5
                            getBlockHeader.parentHash = parentHash
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
                        }
                        if let timeStamp = blockHeader["timestamp"] as? String {//9
                            getBlockHeader.timeStamp = timeStamp
                        }
                        //getting era_end // 2 items
                        if let eraEnd = blockHeader["era_end"] as? [String:Any] {//2 items
                            let getEraEnd:EraEnd = EraEnd();
                            getBlockHeader.eraEnd = getEraEnd;
                            //item 1: era_report
                            if let eraReport = eraEnd["era_report"] as? [String:Any] {//3 items
                                let getEraReport:EraReport = EraReport();
                                getEraEnd.eraReport = getEraReport;
                                //getting equivocators
                                if let equivocators = eraReport["equivocators"] as? [String] { // a list of equivocators
                                    let totalEquivocator = equivocators.count;
                                    print("total equivocator:\(totalEquivocator)")
                                    for equivocator in equivocators {
                                        getEraReport.equivocators.append(equivocator)
                                        print("getEraReport:\(getEraReport)")
                                    }
                                }
                                //getting inactive_validators
                                if let inactiveValidators = eraReport["inactive_validators"] as? [String] { // a list of inactive_validators
                                    let totalInactiveValidators = inactiveValidators.count;
                                    print("total inactiveValidators:\(totalInactiveValidators)")
                                    for inactiveValidator in inactiveValidators {
                                        getEraReport.inactiveValidators.append(inactiveValidator)
                                    }
                                }
                                //getting reward
                                if let rewards = eraReport["rewards"] as? [AnyObject] { // a list of equivocators
                                    let totalRewards = rewards.count;
                                    print("total rewards:\(totalRewards)")
                                    for reward in rewards {
                                        if let amount = reward["amount"] as? UInt64 {
                                            if let validator = reward["validator"] as? String {
                                                let rewardItem : RewardItem = RewardItem();
                                                rewardItem.amount = amount;
                                                rewardItem.validator = validator;
                                                getEraReport.rewards.append(rewardItem);
                                            }
                                        }
                                    }
                                }
                                
                            }
                            
                            //item 2: next_era_validator_weights
                            if let nextEraValidatorWeights = eraEnd["next_era_validator_weights"] as? [AnyObject] {
                                //var
                                for _ in nextEraValidatorWeights {
                                    
                                }
                            }
                        }
                    }
                    //getting block body
                    if let blockBody = block["body"] as? [String:Any] {
                        let getBlockBody:BlockBody = BlockBody();
                        getBlock.body = getBlockBody;
                        //getting deploy hash list
                        if let deployHashes = blockBody["deploy_hashes"] as? [String]{
                            let totalDeployHash = deployHashes.count;
                            for deployHash in deployHashes {
                                getBlockBody.deployHash.append(deployHash)
                            }
                        }
                        //getting transfer hash list
                        if let transferHashes = blockBody["deploy_hashes"] as? [AnyObject]{
                            let totalTransferHash = transferHashes.count;
                            for transferHash in transferHashes {
                               
                                getBlockBody.transferHash.append(transferHash as! String)
                            }
                        }
                        //getting proposer
                        if let proposer = blockBody["proposer"] as? String {
                            getBlockBody.proposer = proposer;
                        }
                    }
                    //getting proof
                    if let proofs = block["proofs"] as? [AnyObject] {
                        let totalProof = proofs.count;
                        for proof in proofs {
                            let oneProof:ProofItem = ProofItem();
                            if let publicKey = proof["public_key"] as? String {
                                if let signature = proof["signature"] as? String {
                                    oneProof.publicKey = publicKey;
                                    oneProof.signature = signature;
                                    getBlock.proofs.append(oneProof);
                                }
                            }
                        }
                        
                    }
                }
            }
            else {
                throw CasperMethodError.parseError
           }
        } catch {
        }
        return getBlockResult;
    }
}
