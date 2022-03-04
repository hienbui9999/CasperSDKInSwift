import Foundation

/**
 Class supports the getting of peer list from Json String
 */
class GetPeers  {
    /**
       Get peer list  from Json string.
       - Parameter : a Json String represents the peer list
       - Returns: GetPeersResult object, which contains the peer list
       */

    public static func getPeers(from:[String:Any]) throws -> GetPeersResult {
        do {
            let getPeerResult:GetPeersResult = GetPeersResult();
            if let result = from["result"] as? [String:Any] {
                if let api_version = result["api_version"] as? String {
                    let protocolVersion:ProtocolVersion = ProtocolVersion();
                    protocolVersion.protocolString = api_version;
                    protocolVersion.serialize();
                    getPeerResult.protocolVersion = protocolVersion;
                } else {
                }
                if let peers = result["peers"] as? [AnyObject]{
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
                    getPeerResult.peers = peerMap;
                    return getPeerResult;
                } else {
                    throw CasperMethodError.parseError
                }
            } else {
                throw CasperMethodError.parseError
            }
        } catch {
            throw error
        }
    }
}
