//
//  File.swift
//  
//
//  Created by Hien on 26/12/2021.
//

import Foundation
public class NextUpgrade {//2 items
    public var activationPoint : Int = 0;//42
    public var protocolVersion:ProtocolVersion = ProtocolVersion();
}
public class BlockInfo {//6 items
    public var creatorHash:String = "";//"015dA78bc6315643FbCf57D87a50853c67D8b271B615F38F6538F78A844CC4501D";
    public var eraId:UInt64 = 0;//3127;
    public var hash:String = "";//"A5F86f0174613dDA54e15613413B1b025fB625139c7b1b4c09C84a609794160A"
    public var height:UInt64 = 0;// 405327;
    public var stateRootHash:String = "";// "5Ee660Bb30F2FBdf93954e871F82f021d2BdD3e24d2218e7611793451C5d87d9"
    public var timeStamp:String = "";// "2021-12-26T04:30:23.232Z"
}
public class GetStatusResult {//9 items
    public var apiVersion:String = "";// "1.4.3";
    public var buildVersionName:String = "";//"1.4.3-a44bed1fd-casper-mainnet"
    public var chainSpecName:String = "";//"casper-test"
    public var lastAddedBlockInfo:BlockInfo = BlockInfo();
    public var peers:PeerMap = PeerMap();//a list of PeerEntry
    public var nextUpgrade:NextUpgrade = NextUpgrade();//"<null>";
    public var ourPublicSigningKey :String = "01cd807fb41345d8dD5A61da7991e1468173acbEE53920E4DFe0D28Cb8825AC664";//a hash
    public var roundLength:String = "32s 768ms";
    public var startingStateRootHash:String = "E2218B6BdB8137A178f242E9DE24ef5Db06af7925E8E4C65Fa82D41Df38F4576";
    public var upTime : String = "15days 14h 45m 44s 205ms"; //THIS IS NOT DECLARE IN
    // http://casper-rpc-docs.s3-website-us-east-1.amazonaws.com/
    public func getLastAddedBlockInfo()->BlockInfo {
        return self.lastAddedBlockInfo;
    }
}
