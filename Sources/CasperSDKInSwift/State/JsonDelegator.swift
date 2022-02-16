import Foundation
/**
 Class supports the getting of JsonDelegator from Json string
 */

public class JsonDelegator {
    public var bonding_purse:URef = URef()
    public var delegatee:PublicKey = PublicKey()
    public var public_key:PublicKey = PublicKey()
    public var staked_amount:U512Class = U512Class()
    /**
       Get JsonDelegator object from Json string
       - Parameter : a Json string represents the JsonDelegator object
       - Returns: JsonDelegator object
       */

    public static func toJsonDelegator(from:[String:Any]) -> JsonDelegator {
        let rJD:JsonDelegator = JsonDelegator()
        if let bonding_purse = from["bonding_purse"] as? String {
            rJD.bonding_purse = URef.fromStringToUref(from: bonding_purse)
        }
        if let delegatee = from["delegatee"] as? String {
            rJD.delegatee = PublicKey.strToPublicKey(from: delegatee)
        }
        if let public_key = from["public_key"] as? String {
            rJD.public_key = PublicKey.strToPublicKey(from: public_key)
        }
        if let staked_amount = from["staked_amount"] as? String {
            rJD.staked_amount = U512Class.fromStringToU512(from: staked_amount)
        }
        return rJD
    }
}
