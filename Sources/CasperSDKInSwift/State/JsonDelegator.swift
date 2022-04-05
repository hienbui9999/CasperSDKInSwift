import Foundation
/**
 Class supports the getting of JsonDelegator from Json string
 */

public class JsonDelegator {
    public var bondingPurse: URef = URef()
    public var delegatee: PublicKey = PublicKey()
    public var publicKey: PublicKey = PublicKey()
    public var stakedAmount: U512Class = U512Class()
    /**
       Get JsonDelegator object from Json string
       - Parameter : a Json string represents the JsonDelegator object
       - Returns: JsonDelegator object
       */

    public static func toJsonDelegator(from: [String: Any]) -> JsonDelegator {
        let rJD: JsonDelegator = JsonDelegator()
        if let bondingPurse1 = from["bonding_purse"] as? String {
            rJD.bondingPurse = URef.fromStringToUref(from: bondingPurse1)
        }
        if let delegatee1 = from["delegatee"] as? String {
            rJD.delegatee = PublicKey.strToPublicKey(from: delegatee1)
        }
        if let publicKey1 = from["public_key"] as? String {
            rJD.publicKey = PublicKey.strToPublicKey(from: publicKey1)
        }
        if let stakedAmount1 = from["staked_amount"] as? String {
            rJD.stakedAmount = U512Class.fromStringToU512(from: stakedAmount1)
        }
        return rJD
    }

}
