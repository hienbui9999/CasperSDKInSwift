import Foundation
/**
 Class represents the VestingSchedule
 */

public class VestingSchedule {
    public var initialReleaseTimestampMillis: UInt64?
    public var lockedAmounts: [U512Class]?// 14 items in list
    /**
       Get VestingSchedule object from Json string
       - Parameter: a Json String represents the VestingSchedule object
       - Returns: VestingSchedule object
       */

    public static func jsonToVestingSchedule(from: [String: Any]) -> VestingSchedule {
        let ret: VestingSchedule = VestingSchedule()
        if let initialReleaseTimestampMillis1 = from["initial_release_timestamp_millis"] as? UInt64 {
            ret.initialReleaseTimestampMillis = initialReleaseTimestampMillis1
        }
        if let lockedAmounts1 = from["locked_amounts"] as? [String] {
            ret.lockedAmounts = [U512Class]()
            for lockedAmount in lockedAmounts1 {
                ret.lockedAmounts!.append(U512Class.fromStringToU512(from: lockedAmount))
            }
        }
        return ret
    }

}
