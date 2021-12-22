//
//  File.swift
//  
//
//  Created by Hien on 22/12/2021.
//

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
//in rust it is a VectorMap
public class PeerMap {
    var peerEntryList : [PeerEntry] = [];
    public func getPeerEntryList()->[PeerEntry] {
        return peerEntryList;
    }
}
public class ProtocolVersion {
    var protocolString = "";
    var major:Int = 1;
    var minor:Int = 0;
    var patch:Int = 0;
    func serialize() {
        //str like 1.4.2
        let strArr = protocolString.components(separatedBy: ".");
        major = Int(strArr[0]) ?? 1;
        minor = Int(strArr[1]) ?? 0;
        patch = Int(strArr[2]) ?? 0;
    }
    public func getProtocolString()->String {
        return protocolString;
    }
}
public class GetPeersResult {
    var protocolVersion:ProtocolVersion=ProtocolVersion();
   // var peerList:[OnePeer] = [];
    var peers:PeerMap = PeerMap();
    public func getProtocolVersion()->ProtocolVersion {
        return self.protocolVersion;
    }
    public func getPeerMap()->PeerMap {
        return self.peers;
    }
}
