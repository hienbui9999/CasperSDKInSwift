import Foundation
/**
 Class supports the getting of JsonBid from Json string
 */

public class JsonBid {
    public var bonding_purse:URef = URef()
    public var delegation_rate:UInt8 = 0
    public var delegators:[JsonDelegator] = [JsonDelegator]()
    public var inactive:Bool = false
    public var staked_amount:U512Class=U512Class()
    /**
       Get JsonBid object from Json string
       - Parameter : a Json string represents the JsonBid object
       - Returns: JsonBid object
       */

    public static func toJsonBid(from:[String:Any]) -> JsonBid {
        let retJsonBid:JsonBid = JsonBid();
        if let bonding_purse = from["bonding_purse"] as? String {
            retJsonBid.bonding_purse = URef.fromStringToUref(from: bonding_purse)
        }
        if let delegation_rate = from["delegation_rate"] as? UInt8 {
            retJsonBid.delegation_rate = delegation_rate
        }
        if let inactive = from["inactive"] as? Bool {
            retJsonBid.inactive = inactive
        }
        if let staked_amount = from["staked_amount"] as? String {
            retJsonBid.staked_amount = U512Class.fromStringToU512(from: staked_amount)
        }
        if let delegators = from["delegators"] as? [[String:Any]] {
            for delegator in delegators {
                let oneDelegator = JsonDelegator.toJsonDelegator(from: delegator)
                retJsonBid.delegators.append(oneDelegator)
            }
        }
        return retJsonBid
    }
}
