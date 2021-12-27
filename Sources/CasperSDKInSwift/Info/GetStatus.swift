//
//  GetStatus.swift
//  SampleRPCCall1
//
//  Created by Hien on 09/12/2021.
//
//https://docs.rs/casper-node/latest/casper_node/rpcs/info/struct.GetStatus.html
//INFO BACK LIKE THIS
/*
 ["jsonrpc": 2.0, "result": {
     "api_version" = "1.4.3";
     "build_version" = "1.4.3-a44bed1fd-casper-mainnet";
     "chainspec_name" = "casper-test";
     "last_added_block_info" =     {
         creator = 0196948158bF5b35C0c84F680F110B8dEbAA4e7628E13ba336a95651a214d3B9BD;
         "era_id" = 2947;
         hash = 328D7b791A392BAfe29353ff9c1ade752F34666B742B658d85cEfdFADe283E2D;
         height = 365842;
         "state_root_hash" = fd0C93320429C0212B45E9796Adc2Da5354514460B289FbE7427fa6D77863Cc0;
         timestamp = "2021-12-11T03:53:40.608Z";
     };
     "next_upgrade" = "<null>";
     "our_public_signing_key" = 01cd807fb41345d8dD5A61da7991e1468173acbEE53920E4DFe0D28Cb8825AC664;
     peers =     (
                 {
             address = "89.163.227.185:35000";
             "node_id" = "tls:006b..1551";
         },
                 {
             address = "18.163.249.168:35000";
             "node_id" = "tls:0097..b253";
         },
 ....
 
 {
address = "93.186.201.14:35000";
"node_id" = "tls:ff95..c014";
},
 {
address = "198.244.179.16:35000";
"node_id" = "tls:ffdb..7c9e";
}
);
"round_length" = "32s 768ms";
"starting_state_root_hash" = E2218B6BdB8137A178f242E9DE24ef5Db06af7925E8E4C65Fa82D41Df38F4576;
uptime = "14h 8m 48s 929ms";
}, "id": 1]
 
 */
import Foundation
struct GetStatus {
    let methodStr : String = "info_get_status"
    //let methodURL : String = "http://65.21.227.180:7777/rpc"
    public func getStatus() async throws ->GetStatusResult {
        let getStatusResult:GetStatusResult = GetStatusResult();
        do {
            let json = try await HttpHandler.handleRequest(method: methodStr, params: "[]")
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
