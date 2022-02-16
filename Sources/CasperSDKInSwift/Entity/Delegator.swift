import Foundation
/**
 Class represents the Delegator
 */

public class Delegator {
    ///Delegator public key
    public var delegator_public_key : PublicKey = PublicKey()
    ///Validator public key
    public var validator_public_key : PublicKey = PublicKey()
    ///Staked amount
    public var staked_amount        : U512Class = U512Class()
    ///Bonding purse
    public var bonding_purse        : URef      = URef()
    ///Vesting schedule
    public var vesting_schedule     : VestingSchedule?
    /**
        Get Delegator object from Json string
        - Parameter : a Json String represents the Delegator object
        - Returns: Delegator object
        */

    public static func jsonToDelegator(from:[String:Any])->Delegator {
        ///Delegator to return when function finish
        let delegator:Delegator = Delegator();
        if let delegator_public_key = from["delegator_public_key"] as? String {
            delegator.delegator_public_key = PublicKey.strToPublicKey(from: delegator_public_key)
        }
        if let validator_public_key = from["validator_public_key"] as? String {
            delegator.validator_public_key = PublicKey.strToPublicKey(from: validator_public_key)
        }
        if let staked_amount = from["staked_amount"] as? String {
            delegator.staked_amount = U512Class.fromStringToU512(from: staked_amount)
        }
        if let bonding_purse = from["bonding_purse"] as? String {
            delegator.bonding_purse = URef.fromStringToUref(from: bonding_purse)
        }
        if let vesting_scheduleJson = from["vesting_schedule"] as? [String:Any]{
            delegator.vesting_schedule = VestingSchedule.jsonToVestingSchedule(from: vesting_scheduleJson)
        }
        return delegator;
    }
}
