import Foundation

public class Validator {
    public var validator_public_key:PublicKey!
    public var amount:U512Class!
}
public class Delegator2 {
    public var validator_public_key:PublicKey!
    public var amount:U512Class!
    public var delegator_public_key:PublicKey!
}

public enum SeigniorageAllocation {
    case Validator(Validator)
    case Delegator(Delegator2)
}

public enum BlockIdentifier {
    case Hash(String)
    case Height(UInt64)
    case None
}
public class EraInfo {
    public var listSeigniorageAllocation:[SeigniorageAllocation]=[SeigniorageAllocation]();
}

public class U512Class {
    public var realValue:[UInt64]?
    public var valueInStr:String=""
    public static func fromStringToU512(from:String)->U512Class {
        let ret:U512Class = U512Class();
        ret.valueInStr = from;
        return ret;
    }
}

public class U256Class {
    public var realValue:[UInt64]?
    public var valueInStr:String=""
    public static func fromStringToU256(from:String)->U256Class {
        let ret:U256Class = U256Class();
        ret.valueInStr = from;
        return ret;
    }
}

public class U128Class {
    public var realValue:[UInt64]?
    public var valueInStr:String=""
    public static func fromStringToU128(from:String)->U128Class {
        let ret:U128Class = U128Class();
        ret.valueInStr = from;
        return ret;
    }
}

public class EraID {
    public var maxValue:UInt64?
}



