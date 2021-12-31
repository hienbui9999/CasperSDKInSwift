//
//  File.swift
//  
//
//  Created by Hien on 27/12/2021.
//

import Foundation

public class NextEraValidatorWeightsItem {
    public var validator:String = "";//016e7a1cdd29b0b78fd13af4c5598feff4ef2a97166e3ca6f2e4fbfccd80505bf1
    public var weight:String = "";//"456"
}
public class RewardItem {
    public var amount:UInt64 = 0 ;//1000
    public var validator:String = "";//018a88e3dd7409f195fd52db2d3cba5d72ca6709bf1d94121bf3748801b40f6f5c
}
public class EraReport {//3 items of 3 array
    public var equivocators:[String] = [String]();//[0:013b6a27bcceb6a42d62a3a8d02a6f0d73653215771de243a63ac048a18b59da29]
    public var inactiveValidators:[String] = [String]();//[0:018139770ea87d175f56a35466c34c7ecccb8d8a91b4ee37a25df60f5b8fc9b394]
    public var rewards : [RewardItem] = [RewardItem]();
}
public class EraEnd {//2 items
    public var eraReport:EraReport = EraReport();
    public var nextEraValidatorWeights:[NextEraValidatorWeightsItem] = [NextEraValidatorWeightsItem]();
}
public class BlockBody {//3 items
    public var deployHash:[String] = [String](); //[0:01da3c604f71e0e7df83ff1ab4ef15bb04de64ca02e3d2b78de6950e8b5ee187]
    public var proposer:String = "";//01d9bf2148748a85c89da5aad8ee0b0fc2d105fd39d41a4c796536354f0ae2900c
    public var transferHash:[String] = [String]();// maybe same like deployHash
    
}
public class BlockHeader {//10 items
    public var accumulatedSeed:String = "";//ac979f51525cfd979b14aa7dc0737c5154eabe0db9280eceaa8dc8d2905b20d5
    public var bodyHash:String = "";//5f4b03936cebebe35eb1f2c542d34098b4c645c898673f1597de64ebdf916956
    public var eraEnd:EraEnd = EraEnd();
    public var eraID:UInt64 = 0;//
    public var height:UInt64 = 0;//
    public var parentHash:String = "";//0707070707070707070707070707070707070707070707070707070707070707
    public var protocolVersion:ProtocolVersion = ProtocolVersion();//1.2.3
    public var randomBit:Bool = false;//
    public var stateRootHash:String = "";//0808080808080808080808080808080808080808080808080808080808080808
    public var timeStamp:String = "";//2020-11-17T00:39:24.072Z
}
public class ProofItem {
    public var publicKey:String = "";//01d9bf2148748a85c89da5aad8ee0b0fc2d105fd39d41a4c796536354f0ae2900c
    public var signature:String = "";//130 chars
}
public class Block { //4 items
    public var hash:String = "";//528c63a9e30bf6e52b9d38f7c1a3e2ec035a54bfb29225d31ecedff00eebbe18
    public var body:BlockBody = BlockBody();
    public var header:BlockHeader = BlockHeader();
    public var proofs: [ProofItem] = [ProofItem]();
}
public class GetBlockResult {
    public var apiVersion:String = "";// "1.4.3";
    public var block:Block = Block();
}
