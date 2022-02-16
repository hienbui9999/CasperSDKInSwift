import Foundation
/**
 Enumeration type represents the ActivationPoint
 */

enum ActivationPoint {
    case EraId(UInt64)
    case Timestamp(UInt64)
}
/**
 Class represents the NextUpgrade
 */

public class NextUpgrade {
    public var activation_point : Int = 0;
    public var protocol_version:String = "";
}
