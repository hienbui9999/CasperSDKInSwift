import Foundation
/**
 Class for Bid object
 */
public class Bid {
    /// Validator public key
    public var validatorPublicKey: PublicKey!
    /// Bonding purse
    public var bondingPurse: URef!
    /// Staked amount
    public var stakedAmount: U512Class!
    /// Delegation rate
    public var delegationRate: UInt8!
    /// Release time stamp, in milisecond
    public var releaseTimestampMillis: UInt64?
    /// Vesting schedule
    public var vestingSchedule: VestingSchedule?
    /// A list of Delegator
    public var delegators: [String: Delegator] = [: ]
    /// Inactive
    public var inactive: Bool = false
}
