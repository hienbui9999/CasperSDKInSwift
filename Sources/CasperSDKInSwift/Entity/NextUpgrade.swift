import Foundation
/**
 Enumeration type represents the ActivationPoint
 */

enum ActivationPoint {
    case eraId(UInt64)
    case timeStamp(UInt64)
}
/**
 Class represents the NextUpgrade
 */

public class NextUpgrade {
    public var activationPoint: Int = 0
    public var protocolVersion: String = ""
}
