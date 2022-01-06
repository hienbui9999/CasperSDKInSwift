import Foundation

public class NextUpgrade {
    public var activationPoint : Int = 0;
    public var protocolVersion:ProtocolVersion = ProtocolVersion();
}

public class BlockInfo {
    public var creatorHash:String = "";
    public var eraId:UInt64 = 0;
    public var hash:String = "";
    public var height:UInt64 = 0;
    public var stateRootHash:String = "";
    public var timeStamp:String = "";
}

public class GetStatusResult {
    public var apiVersion:String = "";
    public var buildVersionName:String = "";
    public var chainSpecName:String = "";
    public var lastAddedBlockInfo:BlockInfo = BlockInfo();
    public var peers:PeerMap = PeerMap();
    public var nextUpgrade:NextUpgrade = NextUpgrade();
    public var ourPublicSigningKey :String = ""
    public var roundLength:String = "";
    public var startingStateRootHash:String = "";
    public var upTime : String = "";
    public func getLastAddedBlockInfo()->BlockInfo {
        return self.lastAddedBlockInfo;
    }
}
