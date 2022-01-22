import Foundation

public class PeerEntry {
    var nodeID:String = "";
    var address:String = "";
    public func getNodeId()->String {
        return nodeID;
    }
    public func getAddress()->String {
        return address
    }
}

