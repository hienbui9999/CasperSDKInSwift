import Foundation
/**
 Class supports the getting of JsonBids from Json string
 */

public class JsonBids {
    public var bid:JsonBid = JsonBid()
    public var public_key:PublicKey = PublicKey();
    /**
        Get JsonBids object from Json string
        - Parameter : a Json string represents the JsonBids object
        - Returns: JsonBids object
        */

    public static func toJsonBids(from:[String:Any]) -> JsonBids {
        let retBids:JsonBids = JsonBids()
        if let public_key = from["public_key"] as? String {
            retBids.public_key = PublicKey.strToPublicKey(from: public_key)
        }
        if let bid = from["bid"] as? [String:Any] {
            retBids.bid = JsonBid.toJsonBid(from: bid)
        }
        return retBids
    }
}
