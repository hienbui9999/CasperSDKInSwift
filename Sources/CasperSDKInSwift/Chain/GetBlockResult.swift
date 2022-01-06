
//
//  Created by Hien on 27/12/2021.
//

import Foundation

public class NextEraValidatorWeightsItem {
    public var validator:String = "";
    public var weight:String = "";
}
public class RewardItem {
    public var amount:UInt64 = 0 ;
    public var validator:String = "";
}
public class EraReport {
    public var equivocators:[String] = [String]();
    public var inactiveValidators:[String] = [String]();
    public var rewards : [RewardItem] = [RewardItem]();
}
public class EraEnd {
    public var eraReport:EraReport = EraReport();
    public var nextEraValidatorWeights:[NextEraValidatorWeightsItem] = [NextEraValidatorWeightsItem]();
}
public class BlockBody {
    public var deployHash:[String] = [String]();
    public var proposer:String = "";
    public var transferHash:[String] = [String]();
    
}
public class BlockHeader {
    public var accumulatedSeed:String = "";
    public var bodyHash:String = "";
    public var eraEnd:EraEnd = EraEnd();
    public var eraID:UInt64 = 0;
    public var height:UInt64 = 0;
    public var parentHash:String = "";
    public var protocolVersion:ProtocolVersion = ProtocolVersion();
    public var randomBit:Bool = false;
    public var stateRootHash:String = "";
    public var timeStamp:String = "";
}
public class ProofItem {
    public var publicKey:String = "";
    public var signature:String = "";
}
public class Block { //4 items
    public var hash:String = "";
    public var body:BlockBody = BlockBody();
    public var header:BlockHeader = BlockHeader();
    public var proofs: [ProofItem] = [ProofItem]();
}
public class GetBlockResult {
    public var apiVersion:String = "";
    public var block:Block = Block();
}
