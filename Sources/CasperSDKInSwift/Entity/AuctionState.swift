import Foundation
/**
 Class for AuctionState object
 */
public class AuctionState {
    ///state root hash
    public var state_root_hash:String=""
    /// block height
    public var block_height:UInt64=0
    ///JsonBids list
    public var bids:[JsonBids] = [JsonBids]()
    ///JsonEraValidators list 
    public var era_validators:[JsonEraValidators] = [JsonEraValidators]()
}
