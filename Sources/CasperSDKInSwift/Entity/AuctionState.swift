import Foundation
/**
 Class for AuctionState object
 */
public class AuctionState {
    /// State root hash value
    public var stateRootHash: String=""
    ///  Block height
    public var blockHeight: UInt64=0
    /// JsonBids list
    public var bids: [JsonBids] = [JsonBids]()
    /// JsonEraValidators list
    public var eraValidators: [JsonEraValidators] = [JsonEraValidators]()
}
