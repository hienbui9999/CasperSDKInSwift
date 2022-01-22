import Foundation

public class Bid {
    public var validator_public_key:PublicKey!
    public var bonding_purse:URef!
    public var staked_amount:U512Class!
    public var delegation_rate:UInt8!
    public var release_timestamp_millis:UInt64?
    public var vesting_schedule:VestingSchedule?
    public var delegators:[String:Delegator]!
    public var inactive:Bool = false
}
