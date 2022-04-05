import Foundation
/**
 Class represents the Delegator
 */

public class Delegator {
    /// Delegator public key
    public var delegatorPublicKey: PublicKey = PublicKey()
    /// Validator public key
    public var validatorPublicKey: PublicKey = PublicKey()
    /// Staked amount
    public var stakedAmount: U512Class = U512Class()
    /// Bonding purse
    public var bondingPurse: URef = URef()
    /// Vesting schedule
    public var vestingSchedule: VestingSchedule?
    /**
        Get Delegator object from Json string
        - Parameter : a Json String represents the Delegator object
        - Returns: Delegator object
        */

    public static func jsonToDelegator(from: [String: Any]) -> Delegator {
        /// Delegator to return when function finish
        let delegator: Delegator = Delegator()
        if let delegatorPublicKey1 = from["delegator_public_key"] as? String {
            delegator.delegatorPublicKey = PublicKey.strToPublicKey(from: delegatorPublicKey1)
        }
        if let validatorPublicKey1 = from["validator_public_key"] as? String {
            delegator.validatorPublicKey = PublicKey.strToPublicKey(from: validatorPublicKey1)
        }
        if let stakedAmount1 = from["staked_amount"] as? String {
            delegator.stakedAmount = U512Class.fromStringToU512(from: stakedAmount1)
        }
        if let bondingPurse1 = from["bonding_purse"] as? String {
            delegator.bondingPurse = URef.fromStringToUref(from: bondingPurse1)
        }
        if let vestingScheduleJson1 = from["vesting_schedule"] as? [String: Any] {
            delegator.vestingSchedule = VestingSchedule.jsonToVestingSchedule(from: vestingScheduleJson1)
        }
        return delegator
    }

}
