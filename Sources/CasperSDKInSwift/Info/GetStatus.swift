import Foundation
/**
 Class supports the getting of GetStatusResult from Json String
 */

public class GetStatus {
    let methodStr : String = "info_get_status"
    /**
       Get GetStatusResult object from Json string
       - Parameter : a Json String represents the GetStatusResult object
       - Throws: CasperMethodCallError.CasperError with code and message according to the error returned by the Casper system
       - Returns: GetStatusResult object
       */
    
    public static func getStatus(from:[String:Any])  throws ->GetStatusResult {
        do {
            if let error = from["error"] as AnyObject? {
                var code:Int!
                var message:String!
                if let code1 = error["code"] as? Int {
                    code = code1
                }
                if let message1 = error["message"] as? String {
                    message = message1
                }
                throw CasperMethodCallError.CasperError(code: code, message: message,methodCall: "info_get_status")
            }
            let getStatusResult:GetStatusResult = GetStatusResult();
            if let result = from["result"] as? [String:Any] {
                if let apiVersion = result["api_version"] as? String {
                    getStatusResult.api_version = ProtocolVersion.strToProtocol(from: apiVersion)
                } else {
                }
                if let buildVersion = result["build_version"] as? String {
                    getStatusResult.build_version = buildVersion
                } else {
                }
                if let chainSepecName = result["chainspec_name"] as? String {
                    getStatusResult.chainspec_name = chainSepecName
                } else {
                }
                
                if let lastAddedBlockInfo = result["last_added_block_info"] as AnyObject? {
                    if let creatorHash = lastAddedBlockInfo["creator"] as? String {
                        getStatusResult.last_added_block_info.creatorHash=creatorHash
                        
                    } else {
                    }
                    if let eraId = lastAddedBlockInfo["era_id"] as? UInt64 {
                        getStatusResult.last_added_block_info.era_id = eraId;
                    }
                    if let creatorHash = lastAddedBlockInfo["hash"] as? String {
                        getStatusResult.last_added_block_info.creatorHash = creatorHash;
                    }
                    if let height = lastAddedBlockInfo["height"] as? UInt64 {
                        getStatusResult.last_added_block_info.height = height;
                    }
                    if let stateRootHash = lastAddedBlockInfo["state_root_hash"] as? String {
                        getStatusResult.last_added_block_info.state_root_hash = stateRootHash;
                    }
                    if let timeStamp = lastAddedBlockInfo["timestamp"] as? String {
                        getStatusResult.last_added_block_info.timestamp = timeStamp;
                    }
                }
           
                if let nextUpgradeResult = result["next_upgrade"]  as? [String:Any] {
                    let nextUpgrade:NextUpgrade = NextUpgrade();
                    if let activationPoint = nextUpgradeResult["activation_point"] as? Int {
                        nextUpgrade.activation_point = activationPoint;
                    }
                    if let protocolVersionStr = nextUpgradeResult["protocol_version"] as? String {
                        nextUpgrade.protocol_version = protocolVersionStr;
                    }
                    getStatusResult.next_upgrade = nextUpgrade;
                } else {
                }
                if let publicSigningKey = result["our_public_signing_key"] as? String {
                    getStatusResult.our_public_signing_key = publicSigningKey;
                }
            //get peers
                if let peers = result["peers"] as? [AnyObject] {
                    var counter = 0;
                    let peerMap:PeerMap = PeerMap();
                    for peer in peers {
                        counter += 1;
                        if let node_id = peer["node_id"] as? String {
                            if let address = peer["address"] as? String {
                                let onePeerEntry : PeerEntry = PeerEntry();
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
                    getStatusResult.round_length = roundLength;
                }
                if let startingStateRootHash = result["starting_state_root_hash"] as? String {
                    getStatusResult.starting_state_root_hash = startingStateRootHash;
                }
                if let upTime = result["uptime"] as? String {
                    getStatusResult.uptime = upTime;
                }
            }
            return getStatusResult
        } catch {
            throw error
        }
    }
}
