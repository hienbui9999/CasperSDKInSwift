//
//  GetBlock.swift
//  SampleRPCCall1
//
//  Created by Hien on 11/12/2021.
//
//https://docs.rs/casper-node/latest/casper_node/rpcs/chain/struct.GetBlock.html
//DATA BACK
/*
 
 */

import Foundation
class GetBlock {
    //use this link for test https://testnet.cspr.live/block/96cc35D79bA8c9961A7E7573FFAc9eA5ABdeB167500206B7fe67D7BB843325cD
    
    let methodStr : String = "chain_get_block"
    public func getBlock(params:Any) async throws -> GetBlockResult {
        var getBlockResult : GetBlockResult = GetBlockResult();
        do {
            let json = try await HttpHandler.handleRequest(method: methodStr, params: params)
            print("json back:\(json)")
            if let id = json["id"] as? Int {
                print("id back:\(id)")
            } else {
                print("cant get id")
            }
            if let jsonCPR = json["jsonrpc"] as? String {
                print("jsonCPR:\(jsonCPR)")
            } else {
                print("can get json CPR")
            }
            if let result = json["result"] as? [String:Any] {
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
/*
 Data back
 
 ["jsonrpc": 2.0, "result": {
     "api_version" = "1.4.3";
     block =     {
         body =         {
             "deploy_hashes" =             (
                 1dd9D8BB08676751AbEd8fa9cdabD8aB18413E16aa64a61D6058Ee9896dC8f5b
             );
             proposer = 01D949A3a1963DB686607a00862f79B76CEB185FC134d0AeEDb686F1C151f4ae54;
             "transfer_hashes" =             (
             );
         };
         hash = f575666F156346402E8F865468329575da8396A0F84654337F9e2FD12d740B36;
         header =         {
             "accumulated_seed" = f3712f4FE4af5705de18227D594b7096ae64b12947097Ef772EDF4F1d0C942f1;
             "body_hash" = dE744E615B5f0FbB6691a54Ef7836e9bd1dF93aC8DDDDF2c5f04B7546d4C1415;
             "era_end" = "<null>";
             "era_id" = 2950;
             height = 366634;
             "parent_hash" = C078B02114E5cF4ca628F13FC14FbE4991ebdEA0851349D091f08796CeBCcf84;
             "protocol_version" = "1.4.3";
             "random_bit" = 1;
             "state_root_hash" = e40feD6eCcC9c21FD65dEB6a0155802B566D7b5DA8d441d188f18932Ee8fa83C;
             timestamp = "2021-12-11T11:07:18.400Z";
         };
         proofs =         (
                         {
                 "public_key" = 0101a458aa2b551C5a49E56326f9BB298bb308E1bAbC875647AE0290c42f13FeAc;
                 signature = 01Fe40957abFf56bBEd3e6B433DE43E4CebADB13aA9C8b2669014aa50C0F7bE7FFe6fEa7301425d4A4cDE51Ad5CA809E5fE09D8e8fb4E50e34704363d721B1D10a;
             },
                         {
                 "public_key" = 0102112A711eb3beE9043ebf036FbDfd4482f0e37d1A65627E09922943713973f8;
                 signature = 0121f88660dB74a0265dB648fd6dc87db658149A90148Dc3EafD59E9A5aD1c918F1c8e29AE6acDc8Cb10E396c895f62afEd0cc84c4C88dfE2f17B1C968D83Bf00A;
             },
                      
                         {
                 "public_key" = 01f340df2c32F25391e8F7924A99E93caB3A6F230ff7aF1CaCbfC070772cbeBD94;
                 signature = 01F2083606a748076fBE5Eb617f9a0629d74CA8f0E804349A5A9B9266e6b5D7AbC98Ebc74cD8Db878E82c8fcf560c228667C752769F58dcca9dC1AAB885bf46206;
             }
         );
     };
 }, "id": 1]

 */
