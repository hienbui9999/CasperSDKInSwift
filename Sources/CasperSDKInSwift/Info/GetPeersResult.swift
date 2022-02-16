import Foundation
/**
 Class represents the GetPeersResult, in which the most important information is the PeerMap object contains the peer list of type PeerEntry
 */

public class GetPeersResult {
    var protocolVersion:ProtocolVersion=ProtocolVersion();
    var peers:PeerMap = PeerMap();
    public func getProtocolVersion()->ProtocolVersion {
        return self.protocolVersion;
    }
    public func getPeerMap()->PeerMap {
        return self.peers;
    }
}
