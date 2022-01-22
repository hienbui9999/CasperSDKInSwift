import Foundation

public class AuctionState {
    public var state_root_hash:String=""
    public var block_height:UInt64=0
    public var bids:[JsonBids] = [JsonBids]()
    public var era_validators:[JsonEraValidators] = [JsonEraValidators]()
}
