import Foundation

struct GetStatus {
    let methodStr : String = "info_get_status"
    public func getStatus(json:[String:Any])  throws ->GetStatusResult {
        let getStatusResult:GetStatusResult = GetStatusResult();
        do {
            if let result = json["result"] as? [String:Any] {
                if let apiVersion = result["api_version"] as? String {
                    getStatusResult.apiVersion = apiVersion
                } else {
                }
                if let buildVersion = result["build_version"] as? String {
                    getStatusResult.buildVersionName = buildVersion
                } else {
                }
                if let chainSepecName = result["chainspec_name"] as? String {
                    getStatusResult.chainSpecName = chainSepecName
                } else {
                }
                
                if let lastAddedBlockInfo = result["last_added_block_info"] as? AnyObject {
                    if let creatorHash = lastAddedBlockInfo["creator"] as? String {
                        getStatusResult.lastAddedBlockInfo.creatorHash=creatorHash
                    } else {
                    }
                    if let eraId = lastAddedBlockInfo["era_id"] as? UInt64 {
                        getStatusResult.lastAddedBlockInfo.eraId = eraId;
                    }
                    if let creatorHash = lastAddedBlockInfo["hash"] as? String {
                        getStatusResult.lastAddedBlockInfo.creatorHash = creatorHash;
                    }
                    if let height = lastAddedBlockInfo["height"] as? UInt64 {
                        getStatusResult.lastAddedBlockInfo.height = height;
                    }
                    if let stateRootHash = lastAddedBlockInfo["state_root_hash"] as? String {
                        getStatusResult.lastAddedBlockInfo.stateRootHash = stateRootHash;
                    }
                    if let timeStamp = lastAddedBlockInfo["timestamp"] as? String {
                        getStatusResult.lastAddedBlockInfo.timeStamp = timeStamp;
                    }
                } else {
                   
                }
           
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
                }
                if let publicSigningKey = result["our_public_signing_key"] as? String {
                    getStatusResult.ourPublicSigningKey = publicSigningKey;
                }
            //get peers
                if let peers = result["peers"] as? [AnyObject] {
                    var counter = 0;
                    var peerMap:PeerMap = PeerMap();
                    for peer in peers {
                        counter += 1;
                        if let node_id = peer["node_id"] as? String {
                            if let address = peer["address"] as? String {
                                var onePeerEntry : PeerEntry = PeerEntry();
                                onePeerEntry.address = address;
                                onePeerEntry.nodeID = node_id;
                                peerMap.peerEntryList.append(onePeerEntry);
                            } else {
                            }
                        } else {
                        }
                    }
                    getStatusResult.peers = peerMap;
                }
                if let roundLength = result["round_length"] as? String {
                    getStatusResult.roundLength = roundLength;
                }
                if let startingStateRootHash = result["starting_state_root_hash"] as? String {
                    getStatusResult.startingStateRootHash = startingStateRootHash;
                }
                if let upTime = result["uptime"] as? String {
                    getStatusResult.upTime = upTime;
                }
            }
            if let id = json["id"] as? Int {
            } else {
            }
            if let jsonCPR = json["jsonrpc"] as? String {
            } else {
            }
            return getStatusResult
        } catch {
            throw error
        }
    }
}
