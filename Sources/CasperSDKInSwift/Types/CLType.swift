
import Foundation
public class CLTypeWarpper {
    public func getValueForCLTypePrimitive(atype:CLType) ->String{
        return "";
    }
    public func getValueForCLTypeUnit() -> String {
        return "";
    }
    public func getValueForCLTypeKey() -> String {
        return ""
    }
    public func getValueForCLTypeURef() -> String {
        return ""
    }
    public func getValueForCLTypeBytesArray() -> String {
        return ""
    }
}

public enum CLType {
    case BOOL
    case I32
    case I64
    case U8
    case U32
    case U64
    case U128
    case U256
    case U512
    case CLType_UNIT
    case CLType_STRING
    case CLType_KEY
    case CLType_UREF
    case CLType_BytesArray;
    indirect case CLType_OPTION(CLType)
    indirect case CLType_LIST(CLType)
    indirect case CLType_FIXED_LIST(CLType,UInt32)
    indirect case CLType_RESULT(CLType,CLType)
    indirect case CLType_MAP(CLType,CLType)
    indirect case CLType_TUPLE_1(CLType)
    indirect case CLType_TUPLE_2(CLType,CLType)
    indirect case CLType_TUPLE_3(CLType,CLType,CLType)
    case CLName_Any
    case CLType_PublicKey
    case NONE
}
class CLTypeClass {
    private var clType:Int32 = 0;
    static func isNumeric(clType: CLType) ->Bool {
        switch (clType) {
        case .I32, .I64, .U8, .U32, .U64, .U128, .U256, .U512:
                return true;
            default:
                return false;
        }
    }
}
