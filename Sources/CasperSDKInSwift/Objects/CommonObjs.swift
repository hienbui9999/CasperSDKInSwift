import Foundation

public class Validator {
    public var validatorPublicKey: PublicKey!
    public var amount: U512Class!
}
public class Delegator2 {
    public var validatorPublicKey: PublicKey!
    public var amount: U512Class!
    public var delegatorPublicKey: PublicKey!
}

public enum SeigniorageAllocation {
    case validator(Validator)
    case delegator(Delegator2)
}

/**
 Enumeration represents the BlockIdentifier, often used to send as parameter when call the RPC methods
 */
public enum BlockIdentifier {
    /// The block hash
    case hash(String)
    /// The block height
    case height(UInt64)
    /// Block identifier with no value of hash or height, use this None value to send parameter as nil
    case none
}
public class EraInfo {
    public var listSeigniorageAllocation: [SeigniorageAllocation]=[SeigniorageAllocation]()
}

/**
 Class represents the Big number of type U512. The value is stored in String format and then parsed as number.
 */

public class U512Class {

    /// Value stored in string format, example "909889988788781234567899876543211223455566"
    public var valueInStr: String=""
    /**
        Generate a U512 class from number in String format
        - Parameter : number in String format
        - Returns: U512Class object
        */

    public static func fromStringToU512(from: String) -> U512Class {
        let ret: U512Class = U512Class()
        ret.valueInStr = from
        return ret
    }

}
/**
 Class represents the Big number of type U256. The value is stored in String format and then parsed as number.
 */

public class U256Class {

    /// Value stored in string format, example "909889988788781234567899876543211223455566"
    public var valueInStr: String=""
    /**
        Generate a U256 class from number in String format
        - Parameter : number in String format
        - Returns: U256Class object
        */

    public static func fromStringToU256(from: String) -> U256Class {
        let ret: U256Class = U256Class()
        ret.valueInStr = from
        return ret
    }

}

/**
 Class represents the Big number of type U256. The value is stored in String format and then parsed as number.
 */
public class U128Class {
    /// Value stored in string format, example "909889988788781234567899876543211223455566"

    public var valueInStr: String=""
    /**
        Generate a U128 class from number in String format
        - Parameter : number in String format
        - Returns: U128Class object
        */

    public static func fromStringToU128(from: String) -> U128Class {
        let ret: U128Class = U128Class()
        ret.valueInStr = from
        return ret
    }

}

public class EraID {
    public var maxValue: UInt64?
}
