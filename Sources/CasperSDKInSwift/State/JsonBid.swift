import Foundation
/**
 Class supports the getting of JsonBid from Json string
 */

public class JsonBid {
    public var bondingPurse: URef = URef()
    public var delegationRate: UInt8 = 0
    public var delegators: [JsonDelegator] = [JsonDelegator]()
    public var inactive: Bool = false
    public var stakedAmount: U512Class=U512Class()
    /**
       Get JsonBid object from Json string
       - Parameter : a Json string represents the JsonBid object
       - Returns: JsonBid object
       */

    public static func toJsonBid(from: [String: Any]) -> JsonBid {
        let retJsonBid: JsonBid = JsonBid()
        if let bondingPurse1 = from["bonding_purse"] as? String {
            retJsonBid.bondingPurse = URef.fromStringToUref(from: bondingPurse1)
        }
        if let delegationRate1 = from["delegation_rate"] as? UInt8 {
            retJsonBid.delegationRate = delegationRate1
        }
        if let inactive = from["inactive"] as? Bool {
            retJsonBid.inactive = inactive
        }
        if let stakedAmount1 = from["staked_amount"] as? String {
            retJsonBid.stakedAmount = U512Class.fromStringToU512(from: stakedAmount1)
        }
        if let delegators = from["delegators"] as? [[String: Any]] {
            for delegator in delegators {
                let oneDelegator = JsonDelegator.toJsonDelegator(from: delegator)
                retJsonBid.delegators.append(oneDelegator)
            }
        }
        return retJsonBid
    }

}
