import Foundation
/**
 Class for AuctionState object
 */
public class AuctionState {
    ///State root hash value
    public var state_root_hash:String=""
    /// Block height
    public var block_height:UInt64=0
    ///JsonBids list
    public var bids:[JsonBids] = [JsonBids]()
    ///JsonEraValidators list 
    public var era_validators:[JsonEraValidators] = [JsonEraValidators]()
}
