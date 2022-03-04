import Foundation
/**
 Class represents the VestingSchedule
 */

public class VestingSchedule {
    public var initial_release_timestamp_millis:UInt64?
    public var locked_amounts:[U512Class]?//14 items in list
    /**
       Get VestingSchedule object from Json string
       - Parameter : a Json String represents the VestingSchedule object
       - Returns: VestingSchedule object
       */

    public static func jsonToVestingSchedule(from:[String:Any])->VestingSchedule {
        let ret:VestingSchedule = VestingSchedule();
        if let initial_release_timestamp_millis = from["initial_release_timestamp_millis"] as? UInt64 {
            ret.initial_release_timestamp_millis = initial_release_timestamp_millis
        }
        if let locked_amounts = from["locked_amounts"] as? [String] {
            ret.locked_amounts = [U512Class]();
            for locked_amount in locked_amounts {
                ret.locked_amounts!.append(U512Class.fromStringToU512(from: locked_amount))
            }
        }
        return ret
    }
}
