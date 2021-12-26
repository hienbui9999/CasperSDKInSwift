//
//  File.swift
//  
//
//  Created by Hien on 26/12/2021.
//

import Foundation
public class BlockInfo {
    public var creatorHash:String = "015dA78bc6315643FbCf57D87a50853c67D8b271B615F38F6538F78A844CC4501D";
    public var eraId:UInt64 = 3127;
    public var hash:String = "A5F86f0174613dDA54e15613413B1b025fB625139c7b1b4c09C84a609794160A"
    public var height:UInt64 = 405327;
    public var stateRootHash:String = "5Ee660Bb30F2FBdf93954e871F82f021d2BdD3e24d2218e7611793451C5d87d9"
    public var timeStamp:String = "2021-12-26T04:30:23.232Z"
}
public class GetStatusResult {
    public var apiVersion:String = "1.4.3";
    public var buildVersionName:String = "casper-test"
    public var lastAddedBlockInfo:BlockInfo = BlockInfo();
    public var peers:PeerMap = PeerMap();
    public var nextUpgrade:String = "";//"<null>";
    public var ourPublicSigningKey :String = "01cd807fb41345d8dD5A61da7991e1468173acbEE53920E4DFe0D28Cb8825AC664";//a hash
}
