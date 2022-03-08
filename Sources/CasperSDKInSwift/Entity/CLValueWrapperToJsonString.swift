import Foundation
let parsedFixStr:String = "!!!!!___PARSED___!!!!!"
public class CLValueWrapperToJsonString
{
    public static func toJsonString(clValue:CLValueWrapper)->String {
        if CLValueWrapperToJsonString.isParsedPrimitive(clValueWrapper: clValue) {
            return CLValueWrapperToJsonString.getParsedPrimitiveString(clValueWrapper: clValue)
        } else {
            return CLValueWrapperToJsonString.getParsedCompound(clValueWrapper: clValue);
        }
    }
    /**
        Function to get  json data from CLValue object
       - Parameter : none
       - Returns: json data representing the current CLValue object, in form of [String:Any]
     Example returned value:
     {
         bytes = 0400ca9a3b;
         "cl_type" = U512;
         parsed = 0400ca9a3b;
     }
     */
    public static func isParsedPrimitive(clValueWrapper:CLValueWrapper)->Bool {
        var ret:Bool = true
        switch clValueWrapper {
        case .Bool(_):
            break;
        case .I32(_):
            break;
        case .I64(_):
            break;
        case .U8(_):
            break;
        case .U32(_):
            break;
        case .U64(_):
            break;
        case .U128(_):
            break;
        case .U256(_):
            break;
        case .U512(_):
            break;
        case .Unit(_):
            break;
        case .String(_):
            break;
        case .Key(_):
            break;
        case .URef(_):
            break;
        case .PublicKey(_):
            break;
        case .BytesArray(_):
            break;
        case .OptionWrapper(_):
            ret = false
        case .ListWrapper(_):
            ret = false
        case .FixedListWrapper(_):
            ret = false
        case .ResultWrapper(_, _):
            ret = false
        case .MapWrapper(_, _):
            ret = false
        case .Tuple1Wrapper(_):
            ret = false
        case .Tuple2Wrapper(_, _):
            ret = false
        case .Tuple3Wrapper(_,_,_):
            ret = false
        case .AnyCLValue(_):
            ret = false
        case .NULL:
            ret = false
        case .NONE:
            ret = false;
        }
        return ret;
    }
    public static func isParsedStringPrimitive(clValueWrapper:CLValueWrapper)->Bool {
        var ret:Bool = true
        switch clValueWrapper {
        case .Bool(_):
            ret = false
        case .I32(_):
            ret = false
        case .I64(_):
            ret = false
        case .U8(_):
            ret = false
        case .U32(_):
            ret = false
        case .U64(_):
            ret = false
        case .U128(_):
            break;
        case .U256(_):
            break;
        case .U512(_):
            break;
        case .Unit(_):
            break;
        case .String(_):
            break;
        case .Key(_):
            break;
        case .URef(_):
            break;
        case .PublicKey(_):
            break;
        case .BytesArray(_):
            break;
        case .OptionWrapper(_):
            ret = false
        case .ListWrapper(_):
            ret = false
        case .FixedListWrapper(_):
            ret = false
        case .ResultWrapper(_, _):
            ret = false
        case .MapWrapper(_,_):
            ret = false
        case .Tuple1Wrapper(_):
            ret = false
        case .Tuple2Wrapper(_,_):
            ret = false
        case .Tuple3Wrapper(_,_,_):
            ret = false
        case .AnyCLValue(_):
            ret = false
        case .NULL:
            ret = false
        case .NONE:
            ret = false;
        }
        return ret;
    }
    public static func getParsedBool(clValueWrapper:CLValueWrapper)-> Bool {
        if case .Bool(let bool) = clValueWrapper {
            return bool
        }
        return false
    }
    public static func getParsedI32(clValueWrapper:CLValueWrapper)-> Int32 {
        if case .I32(let i32) = clValueWrapper {
            return i32
        }
        return 0
    }
    public static func getParsedI64(clValueWrapper:CLValueWrapper)-> Int64 {
        if case .I64(let i64) = clValueWrapper {
            return i64
        }
        return 0
    }
    public static func getParsedU8(clValueWrapper:CLValueWrapper)-> UInt8 {
        if case .U8(let u8) = clValueWrapper {
            return u8
        }
        return 0
    }
    public static func getParsedU32(clValueWrapper:CLValueWrapper)-> UInt32 {
        if case .U32(let u32) = clValueWrapper {
            return u32
        }
        return 0
    }
    public static func getParsedU64(clValueWrapper:CLValueWrapper)-> UInt64 {
        if case .U64(let u64) = clValueWrapper {
            return u64
        }
        return 0
    }

   public static func getParsedPrimitiveString(clValueWrapper:CLValueWrapper)->String {
        switch clValueWrapper {
            case .Bool(let bool) :
                return "\(parsedFixStr):\(bool)";
            case .I32(let i32):
                return "\(parsedFixStr):\(i32)";
            case .I64(let i64):
                return "\(parsedFixStr):\(i64)";
            case .U8(let u8) :
                return "\(parsedFixStr):\(u8)";
            case .U32(let u32):
                return "\(parsedFixStr):\(u32)";
            case .U64(let u64):
                return "\(parsedFixStr):\(u64)";
            case .U128(let u128Class):
                return "\"\(u128Class.valueInStr)\""
            case .U256(let u256Class):
            return "\"\(u256Class.valueInStr)\""
            case .U512(let u512Class):
                return "\"\(u512Class.valueInStr)\""
            case .Unit(let string):
                return "\"\(string)\""
            case .String(let string):
                return "\"\(string)\""
            case .Key(let string):
                let element = string.components(separatedBy:"-")
                if (element[0] == "account") {
                    return "{\"Account\":\"\(string)\"}"
                }
                else if (element[0] == "hash") {
                    return "{\"Hash\":\"\(string)\"}"
                } else {
                    return "{\"URef\":\"\(string)\"}"
                }
            case .URef(let string):
                return "\"\(string)\""
            case .PublicKey(let string):
                return "\"\(string)\""
            case .BytesArray(let string):
                return "\"\(string)\""
            default:
                break
        }
        return "";
    }
    public static func getParsedCompound(clValueWrapper:CLValueWrapper)->String {
        if CLValueWrapperToJsonString.isParsedPrimitive(clValueWrapper: clValueWrapper) {
            return "";
        }
        var ret:String = "";
        switch clValueWrapper {
        case .OptionWrapper(let cLValueWrapperOption):
            if case .NULL = cLValueWrapperOption {
                return "NULL"
            } else if CLValueWrapperToJsonString.isParsedPrimitive(clValueWrapper: cLValueWrapperOption) {
                ret = CLValueWrapperToJsonString.getParsedPrimitiveString(clValueWrapper: cLValueWrapperOption);
            } else {
                ret = CLValueWrapperToJsonString.getParsedCompound(clValueWrapper: cLValueWrapperOption);
            }
            return ret;
        case .ListWrapper(let array):
            ret = "["
            var elementStr = "";
            for element in array {
                if CLValueWrapperToJsonString.isParsedPrimitive(clValueWrapper: element) {
                    elementStr = CLValueWrapperToJsonString.getParsedPrimitiveString(clValueWrapper: element)
                } else {
                    elementStr = CLValueWrapperToJsonString.getParsedCompound(clValueWrapper: element);
                }
                ret = ret + elementStr + ","
            }
            let index = ret.index(ret.endIndex,offsetBy: -1)
            ret = String(ret[..<index]);
            ret = ret + "]";
        case .FixedListWrapper(let array):
            ret = "["
            var elementStr = "";
            for element in array {
                if CLValueWrapperToJsonString.isParsedPrimitive(clValueWrapper: element) {
                    elementStr = CLValueWrapperToJsonString.getParsedPrimitiveString(clValueWrapper: element)
                } else {
                    elementStr = CLValueWrapperToJsonString.getParsedCompound(clValueWrapper: element);
                }
                ret = ret + elementStr + ","
            }
            ret = ret + "]";
        case .ResultWrapper(let string, let cLValueWrapperResult):
            var wrapperStr:String = "";
            if CLValueWrapperToJsonString.isParsedPrimitive(clValueWrapper: cLValueWrapperResult) {
                wrapperStr = CLValueWrapperToJsonString.getParsedPrimitiveString(clValueWrapper: cLValueWrapperResult)
            } else {
                wrapperStr = CLValueWrapperToJsonString.getParsedCompound(clValueWrapper: cLValueWrapperResult);
            }
            ret = "{\(string):\(wrapperStr)}}";
        case .MapWrapper(let keyArray, let valueArray):
            let totalElement = keyArray.count;
            if (totalElement == 0 ) {
                return "[]"
            }
            ret = "[";
            var keyStr:String = "";
            var valueStr:String = "";
            for i in 0 ... totalElement - 1 {
                let keyElement = keyArray[i];
                let valueElement = valueArray[i];
                if CLValueWrapperToJsonString.isParsedPrimitive(clValueWrapper: keyElement) {
                    keyStr = CLValueWrapperToJsonString.getParsedPrimitiveString(clValueWrapper: keyElement)
                } else {
                    keyStr = CLValueWrapperToJsonString.getParsedCompound(clValueWrapper: keyElement);
                }
                if CLValueWrapperToJsonString.isParsedPrimitive(clValueWrapper: valueElement) {
                    valueStr = CLValueWrapperToJsonString.getParsedPrimitiveString(clValueWrapper: valueElement)
                } else {
                    valueStr = CLValueWrapperToJsonString.getParsedCompound(clValueWrapper: valueElement);
                }
                ret = ret + "{\"key\":\(keyStr),\"value\":\(valueStr)},"
            }
            let index = ret.index(ret.endIndex,offsetBy: -1);
            let retStr = ret[..<index];
            ret = retStr + "]";
        case .Tuple1Wrapper(let cLValueWrapperTuple1):
            ret = "["
            var tupleStr:String = "";
            if CLValueWrapperToJsonString.isParsedPrimitive(clValueWrapper: cLValueWrapperTuple1) {
                tupleStr = CLValueWrapperToJsonString.getParsedPrimitiveString(clValueWrapper: cLValueWrapperTuple1)
            } else {
                tupleStr = CLValueWrapperToJsonString.getParsedCompound(clValueWrapper: cLValueWrapperTuple1);
            }
            ret = ret + tupleStr
            ret = ret + "]";
        case .Tuple2Wrapper(let cLValueWrapperTuple21, let cLValueWrapperTuple22):
            var tupleStr1:String = "";
            var tupleStr2:String = "";
            if CLValueWrapperToJsonString.isParsedPrimitive(clValueWrapper: cLValueWrapperTuple21) {
                tupleStr1 = CLValueWrapperToJsonString.getParsedPrimitiveString(clValueWrapper: cLValueWrapperTuple21)
            } else {
                tupleStr1 = CLValueWrapperToJsonString.getParsedCompound(clValueWrapper: cLValueWrapperTuple21);
            }
            if CLValueWrapperToJsonString.isParsedPrimitive(clValueWrapper: cLValueWrapperTuple22) {
                tupleStr2 = CLValueWrapperToJsonString.getParsedPrimitiveString(clValueWrapper: cLValueWrapperTuple22)
            } else {
                tupleStr2 = CLValueWrapperToJsonString.getParsedCompound(clValueWrapper: cLValueWrapperTuple22);
            }
            ret = "[" + tupleStr1 + "," + tupleStr2 + "]";
        case .Tuple3Wrapper(let cLValueWrapperTuple31, let cLValueWrapperTuple32, let cLValueWrapperTuple33):
            var tupleStr1:String = "";
            var tupleStr2:String = "";
            var tupleStr3:String = "";
            if CLValueWrapperToJsonString.isParsedPrimitive(clValueWrapper: cLValueWrapperTuple31) {
                tupleStr1 = CLValueWrapperToJsonString.getParsedPrimitiveString(clValueWrapper: cLValueWrapperTuple31)
            } else {
                tupleStr1 = CLValueWrapperToJsonString.getParsedCompound(clValueWrapper: cLValueWrapperTuple31);
            }
            if CLValueWrapperToJsonString.isParsedPrimitive(clValueWrapper: cLValueWrapperTuple32) {
                tupleStr2 = CLValueWrapperToJsonString.getParsedPrimitiveString(clValueWrapper: cLValueWrapperTuple32)
            } else {
                tupleStr2 = CLValueWrapperToJsonString.getParsedCompound(clValueWrapper: cLValueWrapperTuple32);
            }
            if CLValueWrapperToJsonString.isParsedPrimitive(clValueWrapper: cLValueWrapperTuple33) {
                tupleStr3 = CLValueWrapperToJsonString.getParsedPrimitiveString(clValueWrapper: cLValueWrapperTuple33)
            } else {
                tupleStr3 = CLValueWrapperToJsonString.getParsedCompound(clValueWrapper: cLValueWrapperTuple33);
            }
            ret = "[" + tupleStr1 + "," + tupleStr2 + "," + tupleStr3 + "]";
        case .AnyCLValue(let anyObject):
            return "NULL"
        case .NULL:
            return "NULL";
        case .NONE:
            return "NULL";
        default:
            return "";
        }
        return ret;
    }
}
