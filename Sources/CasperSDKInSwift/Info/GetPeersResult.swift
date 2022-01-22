import Foundation

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
