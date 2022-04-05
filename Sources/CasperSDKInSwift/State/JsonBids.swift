import Foundation
/**
 Class supports the getting of JsonBids from Json string
 */

public class JsonBids {
    public var bid: JsonBid = JsonBid()
    public var publicKey: PublicKey = PublicKey()
    /**
        Get JsonBids object from Json string
        - Parameter : a Json string represents the JsonBids object
        - Returns: JsonBids object
        */

    public static func toJsonBids(from: [String: Any]) -> JsonBids {
        let retBids: JsonBids = JsonBids()
        if let publicKey1 = from["public_key"] as? String {
            retBids.publicKey = PublicKey.strToPublicKey(from: publicKey1)
        }
        if let bid = from["bid"] as? [String: Any] {
            retBids.bid = JsonBid.toJsonBid(from: bid)
        }
        return retBids
    }

}
