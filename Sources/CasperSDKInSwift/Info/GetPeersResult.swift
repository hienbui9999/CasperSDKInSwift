//
//  File.swift
//  
//
//  Created by Hien on 22/12/2021.
//

import Foundation
struct PeerEntry {
    var nodeID:String = "";
    var address:String = "";
}
//in rust it is a VectorMap
struct PeerMap {
    var peerEntryList : [PeerEntry] = [];
}
class ProtocolVersion {
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
}
public class GetPeersResult {
    var protocolVersion:ProtocolVersion=ProtocolVersion();
   // var peerList:[OnePeer] = [];
    var peers:PeerMap = PeerMap();
}
