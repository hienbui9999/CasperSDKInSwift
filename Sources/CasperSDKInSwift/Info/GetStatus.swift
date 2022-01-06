
//  Created by Hien on 09/12/2021.
//
//https://docs.rs/casper-node/latest/casper_node/rpcs/info/struct.GetStatus.html
import Foundation
struct GetStatus {
    let methodStr : String = "info_get_status"
    public func getStatus(json:[String:Any])  throws ->GetStatusResult {
        let getStatusResult:GetStatusResult = GetStatusResult();
        do {
            if let result = json["result"] as? [String:Any] {
                if let apiVersion = result["api_version"] as? String {
                    print("api_version back:\(apiVersion)")
                    getStatusResult.apiVersion = apiVersion
                } else {
                    print("cant get api_version")
                }
                if let buildVersion = result["build_version"] as? String {
                    print("build_version back:\(buildVersion)")
                    getStatusResult.buildVersionName = buildVersion
                } else {
                    print("cant get build_version")
                }
                if let chainSepecName = result["chainspec_name"] as? String {
                    print("chainSpecName back:\(chainSepecName)")
                    getStatusResult.chainSpecName = chainSepecName
                } else {
                    print("cant get build_version")
                }
                //GET LAST ADDED BLOCK INFO
                if let lastAddedBlockInfo = result["last_added_block_info"] as? AnyObject {
                    if let creatorHash = lastAddedBlockInfo["creator"] as? String {
                        print("creator:\(creatorHash)")
                        getStatusResult.lastAddedBlockInfo.creatorHash=creatorHash
                    } else {
                        print("Can not get creator")
                    }
                    if let eraId = lastAddedBlockInfo["era_id"] as? UInt64 {
                        print("eraId:\(eraId)")
                        getStatusResult.lastAddedBlockInfo.eraId = eraId;
                    }
                    if let creatorHash = lastAddedBlockInfo["hash"] as? String {
                        print("creatorHash:\(creatorHash)")
                        getStatusResult.lastAddedBlockInfo.creatorHash = creatorHash;
                    }
                    if let height = lastAddedBlockInfo["height"] as? UInt64 {
                        print("blockHeight:\(height)")
                        getStatusResult.lastAddedBlockInfo.height = height;
                    }
                    if let stateRootHash = lastAddedBlockInfo["state_root_hash"] as? String {
                        print("staterootHash:\(stateRootHash)")
                        getStatusResult.lastAddedBlockInfo.stateRootHash = stateRootHash;
                    }
                    if let timeStamp = lastAddedBlockInfo["timestamp"] as? String {
                        print("timeStamp:\(timeStamp)")
                        getStatusResult.lastAddedBlockInfo.timeStamp = timeStamp;
                    }
                } else {
                    print("Can not get lastAddedBlock")
                }
            //END OF GET LAST ADDED BLOCK INFO
                if let nextUpgradeResult = result["next_upgrade"]  as? [String:Any] {
                    var nextUpgrade:NextUpgrade = NextUpgrade();
                    if let activationPoint = nextUpgradeResult["activation_point"] as? Int {
                        nextUpgrade.activationPoint = activationPoint;
                    }
                    if let protocolVersionStr = nextUpgradeResult["protocol_version"] as? String {
                        let protocolVersion : ProtocolVersion = ProtocolVersion();
                        protocolVersion.setProtolString(str: protocolVersionStr)
                        nextUpgrade.protocolVersion = protocolVersion;
                    }
                    getStatusResult.nextUpgrade = nextUpgrade;
                } else {
                    print("CAN NOT GET next_upgrade")
                }
                if let publicSigningKey = result["our_public_signing_key"] as? String {
                    print("OurPublicSigningKey:\(publicSigningKey)")
                    getStatusResult.ourPublicSigningKey = publicSigningKey;
                }
            //GET PEERS
                if let peers = result["peers"] as? [AnyObject] {
                    print("Total peer back:\(peers.count)")
                    var counter = 0;
                    var peerMap:PeerMap = PeerMap();
                    for peer in peers {
                        counter += 1;
                        if let node_id = peer["node_id"] as? String {
                          //  print("counter:\(counter), node_id:\(node_id)")
                            if let address = peer["address"] as? String {
                               // print("counter:\(counter),address:\(address)")
                                var onePeerEntry : PeerEntry = PeerEntry();
                                onePeerEntry.address = address;
                                onePeerEntry.nodeID = node_id;
                                peerMap.peerEntryList.append(onePeerEntry);
                            } else {
                                print("Can not get address")
                            }
                        } else {
                            print("can not get node_id")
                        }
                        
                    }//end of for loop to get peer list
                    getStatusResult.peers = peerMap;
                    print("total peer back:\(getStatusResult.peers.peerEntryList.count)")
                }//end of getting information for peers
                if let roundLength = result["round_length"] as? String {
                    print("roundLegth:\(roundLength)")
                    getStatusResult.roundLength = roundLength;
                }
                if let startingStateRootHash = result["starting_state_root_hash"] as? String {
                    print("starting state root hash:\(startingStateRootHash)")
                    getStatusResult.startingStateRootHash = startingStateRootHash;
                }
                if let upTime = result["uptime"] as? String {
                    print("upTime:\(upTime)")
                    getStatusResult.upTime = upTime;
                }
            }//end of get information for result
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
          //  print("getStatus back:\(json)")
            return getStatusResult
        } catch {
            throw error
        }
    }
}
