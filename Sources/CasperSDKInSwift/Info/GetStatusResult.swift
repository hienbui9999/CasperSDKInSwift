import Foundation
/**
 Class represents the GetStatusResult, in which the peer list is declared in a PeerMap object
 */

public class GetStatusResult {
    public var apiVersion: ProtocolVersion = ProtocolVersion()
    public var buildVersion: String = ""
    public var chainspecName: String = ""
    public var lastAddedBlockInfo: MinimalBlockInfo = MinimalBlockInfo()
    /// The  peer list, retrieve from attribute [PeerEntry]  in PeerMap object
    public var peers: PeerMap = PeerMap()
    public var nextUpgrade: NextUpgrade = NextUpgrade()
    public var ourPublicSigningKey: String = ""
    public var roundLength: String = ""
    public var startingStateRootHash: String = ""
    public var uptime: String = ""
}
