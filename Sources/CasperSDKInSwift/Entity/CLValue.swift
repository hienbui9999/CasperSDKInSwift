import Foundation
let CONST_NULL_RETURN_VALUE: String = "______NULL______"
public enum CLValueWrapper {
    case Bool(Bool)
    case I32(Int32)
    case I64(Int64)
    case U8(UInt8)
    case U32(UInt32)
    case U64(UInt64)
    case U128(U128Class)
    case U256(U256Class)
    case U512(U512Class)
    case Unit(String)
    case String(String)
    case Key(String)
    case URef(String)
    case PublicKey(String)
    case BytesArray(String)
    indirect case OptionWrapper(CLValueWrapper)
    indirect case ListWrapper([CLValueWrapper])
    indirect case ResultWrapper(String,CLValueWrapper)
    indirect case MapWrapper([CLValueWrapper],[CLValueWrapper])
    indirect case Tuple1Wrapper(CLValueWrapper)
    indirect case Tuple2Wrapper(CLValueWrapper,CLValueWrapper)
    indirect case Tuple3Wrapper(CLValueWrapper,CLValueWrapper,CLValueWrapper)
    case AnyCLValue(AnyObject)
    case NULL
    case NONE
}
public class CLValue {
    public var bytes:String = ""
    public var cl_type:CLType = .NONE
    public var parsed:CLValueWrapper = .NONE
    public static func getCLValueWrapperDirect(from:AnyObject,clType:CLType) -> CLValueWrapper {
        var ret = getCLValueWrapperPrimitive(from: from, clType: clType)
        switch ret {
        case .NONE:
            ret = getCLValueWrapperCompound(from: from, clType: clType)
        default:
            break;
        }
        return ret;
    }
    public static func getCLValueWrapper(from:AnyObject,clType:CLType,keyStr:String = "parsed") -> CLValueWrapper {
        if let parsedJson = from[keyStr] as? AnyObject {
            var ret = getCLValueWrapperPrimitive(from: parsedJson, clType: clType)
            switch ret {
            case .NONE:
                ret = getCLValueWrapperCompound(from: parsedJson, clType: clType)
            default:
                break;
            }
            return ret;
        }
        else {
            return CLValueWrapper.NONE
        }
    }
    public static func getCLValueWrapperPrimitiveFromRaw(input:AnyObject,clType:CLType)->CLValueWrapper {
        switch clType {
        case .Bool:
            if let input1 = input as? Bool {
                return .Bool(input1 as Bool)
            }
        case .I32:
            if let input1 = input as? Int32 {
                return .I32(input1)
            }
        case .I64:
            if let input1 = input as? Int64 {
                return .I64(input1)
            }
        case .U8:
            if let input1 = input as? UInt8 {
                return .U8(input1)
            }
        case .U32:
            if let input1 = input as? UInt32 {
                return .U32(input1)
            }
        case .U64:
            if let input1 = input as? UInt64 {
                return .U64(input1)
            }
        case .U128:
            if let input1 = input as? String {
                return .U128(U128Class.fromStringToU128(from: input1))
            }
        case .U256:
            if let input1 = input as? String {
                return  .U256(U256Class.fromStringToU256(from: input1))
            }
        case .U512:
            if let input1 = input as? String {
                return .U512(U512Class.fromStringToU512(from:input1 ))
            }
        case .Unit:
            if let input1 = input as? String {
                return .Unit(input1)
            }
            break;
        case .String:
            if let input1 = input as? String {
                return .String(input1)
            }
            break;
        case .Key:
                if let account = input["Account"] as? String {
                    return .Key(account);
            }
        case .URef:
            break;
        case .PublicKey:
            break
        case .BytesArray(let uInt32):
            break
        case .CLAny :
            break
        case .NONE:
            return .NONE
            break
        default:
            break;
        }
        return .NONE
    }
    
    public static func getCLValueWrapperPrimitive(from:AnyObject,clType:CLType) -> CLValueWrapper {
        switch clType {
        case .Bool:
            if let parsed = from as? Bool {
                return .Bool(parsed)
            }
        case .I32:
            if let parsed = from as? Int32 {
                return .I32(parsed)
            }
        case .I64:
            if let parsed = from as? Int64 {
                return .I64(parsed)
            }
        case .U8:
            if let parsed = from as? UInt8 {
                return .U8(parsed)
            }
        case .U32:
            if let parsed = from as? UInt32 {
                return .U32(parsed)
            }
        case .U64:
            if let parsed = from as? UInt64 {
                return .U64(parsed)
            }
        case .U128:
            if let parsed = from as? String {
                return .U128(U128Class.fromStringToU128(from: parsed))
            }
        case .U256:
            if let parsed = from as? String {
                return  .U256(U256Class.fromStringToU256(from: parsed))
            }
        case .U512:
            if let parsed = from as? String {
                return .U512(U512Class.fromStringToU512(from: parsed))
            }
        case .Unit:
            if let parsed = from as? AnyObject {
                if parsed is NSNull != nil {
                    return .Unit(CONST_NULL_RETURN_VALUE)
                }
                else if let parsed = from as? String {
                    if parsed == "<null>" {
                        return .Unit(CONST_NULL_RETURN_VALUE)
                    } else {
                    }
                    return .Unit(parsed)
                }
            }
            break;
        case .String:
            if let parsed = from as? String {
                return .String(parsed)
            }
            break;
        case .Key:
            if let parsed = from as? [String:String] {
                for (key,value) in parsed {
                    return .Key(value)
                }
            }
        case .URef:
            if let parsed = from as? String {
                return .URef(parsed)
            }
            break;
        case .PublicKey:
            if let parsed = from as? String {
                return .PublicKey(parsed)
            }
            break
        case .BytesArray(let uInt32):
            if let parsed = from as? String {
                return .BytesArray(parsed)
            }
        case .CLAny:
        if let parsed = from as? AnyObject {
            if parsed is NSNull != nil {
                return .AnyCLValue(CONST_NULL_RETURN_VALUE as AnyObject)
            } else if (parsed as? String)?.lowercased() == "<null>" {
                return .AnyCLValue(CONST_NULL_RETURN_VALUE as AnyObject)
            } else {
            }
            return .AnyCLValue(parsed)
        } else {
            return .AnyCLValue(CONST_NULL_RETURN_VALUE as AnyObject)
        }
        
        case .NONE:
            return .NONE
        default:
            break;
        }
        return .NONE
    }
    
    public static func getCLValueWrapperCompound(from:AnyObject,clType:CLType) -> CLValueWrapper {
        switch clType {
        case .Result(let cLType1, let cLType2):
            if let OkValue = from["Ok"] as? AnyObject {
                if !(OkValue is NSNull)  {
                    let ret1 = CLValue.getCLValueWrapperDirect(from: OkValue, clType: cLType1)
                    return .ResultWrapper("Ok", ret1)
                }
            }
            if let ErrValue = from["Err"] as? AnyObject {
                if !(ErrValue is NSNull) {
                    let ret1 = CLValue.getCLValueWrapperDirect(from: ErrValue, clType: cLType2)
                    return .ResultWrapper("Err", ret1)
                }
            }
            break;
        case .Option(let cLType):
            let ret = CLValue.getCLValueWrapperDirect(from: from, clType: cLType)
            CLValue.printParsed(parsed: ret)
            return .OptionWrapper(ret)
            break;
        case .List(let cLTypeInList):
            var retList:[CLValueWrapper] = [CLValueWrapper]();
            if let parseds = from as? [AnyObject] {
                var counter:Int = 0 ;
                for parsed in parseds {
                    counter += 1
                    let oneParsed = CLValue.getCLValueWrapperPrimitive(from: parsed, clType: cLTypeInList)
                    switch oneParsed {
                    case .NONE:
                        let oneParsed = CLValue.getCLValueWrapperCompound(from: parsed, clType: cLTypeInList)
                        retList.append(oneParsed)
                        break;
                    default:
                        retList.append(oneParsed)
                        break;
                    }
                }
                return .ListWrapper(retList)
            }
            break;
        case .Map(let cLType1, let cLType2):
            var counter:Int = 0;
            var mapList1 : [CLValueWrapper] = [CLValueWrapper]();
            var mapList2 : [CLValueWrapper] = [CLValueWrapper]()
            if let fromList = from as? [AnyObject] {
                for from1 in fromList {
                    counter += 1
                    let clValueType1 = CLValue.getCLValueWrapper(from: from1, clType: cLType1, keyStr: "key")
                    let clValueType2 = CLValue.getCLValueWrapper(from: from1, clType: cLType1, keyStr: "value")
                    mapList1.append(clValueType1)
                    mapList2.append(clValueType2)
                    
                }
                return .MapWrapper(mapList1,mapList2)
            }
            break
        case .Tuple1(let cLType1):
            var clValueType1:CLValueWrapper = .NONE
            if let fromList = from as? [AnyObject] {
                var counter : Int = 0;
                for from1 in fromList {
                    if counter == 0 {
                        clValueType1 = CLValue.getCLValueWrapperDirect(from: from1, clType: cLType1)
                    }
                }
                return .Tuple1Wrapper(clValueType1)
            }
            
            break
        case .Tuple2(let cLType1, let cLType2):
            var clValueType1:CLValueWrapper = .NONE
            var clValueType2:CLValueWrapper = .NONE
            if let fromList = from as? [AnyObject] {
                var counter : Int = 0;
                for from1 in fromList {
                    if counter == 0 {
                        clValueType1 = CLValue.getCLValueWrapperDirect(from: from1, clType: cLType1)
                    } else if counter == 1 {
                        clValueType2 = CLValue.getCLValueWrapperDirect(from: from1, clType: cLType2)
                    }
                    counter += 1
                }
                return .Tuple2Wrapper(clValueType1, clValueType2)
            }
            break
        case .Tuple3(let cLType1, let cLType2, let cLType3):
                var clValueType1:CLValueWrapper = .NONE
                var clValueType2:CLValueWrapper = .NONE
                var clValueType3:CLValueWrapper = .NONE
            if let fromList = from as? [AnyObject] {
                var counter : Int = 0;
                for from1 in fromList {
                    if counter == 0 {
                        clValueType1 = CLValue.getCLValueWrapperDirect(from: from1, clType: cLType1)
                    } else if counter == 1 {
                        clValueType2 = CLValue.getCLValueWrapperDirect(from: from1, clType: cLType2)
                    } else if counter == 2 {
                        clValueType3 = CLValue.getCLValueWrapperDirect(from: from1, clType: cLType3)
                    }
                    counter += 1
                }
                return .Tuple3Wrapper(clValueType1, clValueType2, clValueType3)
            }
            break
        case .CLAny:
            break
        case .NONE:
            return .NONE
            break
        default:
            break;
        }
        return .NONE
    }
   
    public static func printParsed(parsed:CLValueWrapper) {
        switch parsed {
        case .Bool(let bool):
            print("parsed bool:\(bool)")
        case .I32(let int32):
            print("parsed I32:\(int32)")
        case .I64(let int64):
            print("parsed I64:\(int64)")
        case .U8(let uInt8):
            print("parsed U8:\(uInt8)")
        case .U32(let uInt32):
            print("parsed U32:\(uInt32)")
        case .U64(let uInt64):
            print("parsed U64:\(uInt64)")
        case .U128(let u128Class):
            print("parsed type U128, value:\(u128Class.valueInStr)")
        case .U256(let u256Class):
            print("parsed type U256,value:\(u256Class.valueInStr)")
        case .U512(let u512Class):
            print("parsed type U512: value: \(u512Class.valueInStr)")
        case .Unit(let string):
            print("parsed type Unit, value:\(string)")
        case .String(let string):
            print("parsed type String, value:\(string)")
        case .Key(let string):
            print("parsed type Key, value:\(string)")
        case .URef(let string):
            print("parsed type URef,value:\(string)")
        case .PublicKey(let string):
            print("parsed type PublicKey,value:\(string)")
        case .BytesArray(let uInt32):
            print("parsed type BytesArray,value:\(uInt32)")
        case .OptionWrapper(let cLValueWrapper):
            print("parsed OptionalWrapper")
            CLValue.printParsed(parsed: cLValueWrapper)
        case .ListWrapper(let array):
            print("parsed ListWrapper, print for each element")
            var counter:Int = 0;
            for element in array {
                print("Print for list element number \(counter):")
                CLValue.printParsed(parsed: element)
                counter += 1
            }
            
        case .ResultWrapper(let resultType, let cLValueWrapper):
            print("parsed ResultWrapper")
            if resultType == "Ok" {
                print("OK:")
                CLValue.printParsed(parsed: cLValueWrapper)
            } else {
                print("Err:")
                CLValue.printParsed(parsed: cLValueWrapper)
            }
        case .MapWrapper(let cLValueWrapper1, let cLValueWrapper2):
            print("parsed MapWrapper")
            let totalE:Int = cLValueWrapper1.count
            if totalE == 0 {
                print("CLVALUE - Map is empty")
                break
                //return .MapWrapper(CLValueWrapper.NONE, CLValueWrapper.NONE)
            }
            for i in 0 ... totalE-1 {
                print("Key:")
                CLValue.printParsed(parsed: cLValueWrapper1[i])
                print("Value:")
                CLValue.printParsed(parsed: cLValueWrapper2[i])
            }
            print("done for map")
        case .Tuple1Wrapper(let cLValueWrapper):
            print("Tuple1Wrapper")
            break;
        case .Tuple2Wrapper(let cLValueWrapper1, let cLValueWrapper2):
            print("Tuple2Wrapper, value 1:")
            CLValue.printParsed(parsed: cLValueWrapper1)
            print("Tuple2Wrapper, value 2:")
            CLValue.printParsed(parsed: cLValueWrapper2)
            break;
        case .Tuple3Wrapper(let cLValueWrapper1, let cLValueWrapper2, let cLValueWrapper3):
            print("Tuple3Wrapper, value 1:")
            CLValue.printParsed(parsed: cLValueWrapper1)
            print("Tuple3Wrapper, value 2:")
            CLValue.printParsed(parsed: cLValueWrapper2)
            print("Tuple3Wrapper, value 3:")
            CLValue.printParsed(parsed: cLValueWrapper3)
            print("Tuple3Wrapper")
            break;
        case .AnyCLValue(let string):
            print("AnyCLValue:\(string)")
            break;
        case .NULL:
            print("null")
        case .NONE:
            print("None")
        }
    }
    public static func getCLValue(from:[String:Any]) -> CLValue {
        let clValue:CLValue = CLValue();
        if let bytes = from["bytes"] as? String {
            clValue.bytes = bytes;
        }
        clValue.cl_type = CLTypeHelper.jsonToCLType(from: from as AnyObject)
        clValue.parsed = CLValue.getCLValueWrapper(from: from as AnyObject,clType: clValue.cl_type)
        return clValue
    }
}
