import Foundation
/**
 Class for Bid object
 */
public class Bid {
    ///Validator public key
    public var validator_public_key:PublicKey!
    ///Bonding purse
    public var bonding_purse:URef!
    ///Staked amount
    public var staked_amount:U512Class!
    ///Delegation rate
    public var delegation_rate:UInt8!
    ///Release time stamp, in milisecond
    public var release_timestamp_millis:UInt64?
    ///Vesting schedule
    public var vesting_schedule:VestingSchedule?
    ///A list of Delegator
    public var delegators:[String:Delegator]=[:]
    ///Inactive
    public var inactive:Bool = false
}
