import Foundation

enum ActivationPoint {
    case EraId(UInt64)
    case Timestamp(UInt64)
}

public class NextUpgrade {
    public var activation_point : Int = 0;
    public var protocol_version:String = "";
}
