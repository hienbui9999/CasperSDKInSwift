import Foundation
/**
 Enumeration for CLType
 */
public enum CLType {
    case Bool
    case I32
    case I64
    case U8
    case U32
    case U64
    case U128
    case U256
    case U512
    case Unit
    case String
    case Key
    case URef
    case PublicKey
    case BytesArray(UInt32);
    indirect case Result(CLType,CLType)
    indirect case Option(CLType)
    indirect case List(CLType)
    indirect case FixedList(CLType)
    indirect case Map(CLType,CLType)
    indirect case Tuple1(CLType)
    indirect case Tuple2(CLType,CLType)
    indirect case Tuple3(CLType,CLType,CLType)
    case CLAny
    case NONE
}
/**
 Class  for handling the  conversion from Json String to  CLType
 */
public class CLTypeHelper {
    /**
     Get CLType from Json string
     - Parameter : a Json String represent the CLType object
     - Returns: CLType object
     */
    public static func jsonToCLType(from:AnyObject,keyStr:String = "cl_type")-> CLType {
        var ret :CLType = .NONE
        if let clTypeWrapper = from[keyStr] as? String {
            ret = CLTypeHelper.stringToCLTypePrimitive(input: clTypeWrapper)
            return ret
        }
        else if let clTypeWrapper = from[keyStr] as? AnyObject {
            ret = CLTypeHelper.jsonToCLTypeCompound(from: clTypeWrapper as  AnyObject)
        }
        return ret;
    }
    
    /**
     Get CLType primitive (CLType with no recursive type inside) from Json string
     - Parameter : a Json String represent the CLType object
     - Returns: CLType object
     */
    public static func jsonToCLTypePrimitive(from:AnyObject,keyStr:String="cl_type") -> CLType {
        var clType : CLType = .NONE
        //primitive type
        if let boolCLType = from["Bool"] as? Bool {
            return .Bool
        }
        if let u8CLType = from["U8"] as? UInt8 {
            return .U8
        }
        if let u32CLType = from["U32"] as? UInt32 {
            return .U32
        }
        if let _ = from["U64"] as? UInt64 {
            return .U64
        }
        if let u128CLType = from["U128"] as? String {
            return .U128
        }
        if let u256CLType = from["U256"] as? String {
            return .U256
        }
        if let u512CLType = from["U512"] as? String {
            return .U512
        }
        if let stringCLType = from["String"] as? String {
            return .String
        }
        if let keyMapCLType = from["key"] as? String {
            return .String
        }
        if let valueMapCLType = from["value"] as? String {
            return .String
        }
        if let okResult = from["ok"] as? String {
            return .String
        }
        if let errResult = from["err"] as? String {
            return .String
        }
        if let byteArrray = from["ByteArray"] as? UInt32 {
            return .BytesArray(byteArrray)
        }
        if let keyCLType = from["Key"] as? String {
            return .Key;
        }
        if let publicKeyCLType = from["PublicKey"] as? String {
            return .PublicKey;
        }
        if let URefClType = from["URef"] as? String {
            return .URef
        }
        if let UnitCLType = from["Unit"] as? String {
            return .Unit
        }
        return clType
    }
    
    /**
     Get CLType compound from Json string, which are the recursive CLType such as List(CLType), Map(CLType,CLType), Tuple1(CLType), Tuple2(CLType,CLType),Tuple3(CLType,CLType,CLType)...
     - Parameter : a Json String represent the CLType object
     - Returns: CLType object
     */
    
    public static func jsonToCLTypeCompound(from:AnyObject,keyStr:String="cl_type")->CLType {
        var clType:CLType = .NONE
        if let listCLType = from["List"] as? String {
            clType = CLTypeHelper.stringToCLTypePrimitive(input: listCLType)
            return .List(clType)
        } else if let listCLType = from["List"] as? AnyObject {
            if !(listCLType is NSNull) {
                clType = CLTypeHelper.jsonToCLTypeCompound(from: listCLType)
                return .List(clType)
            }
        }
        if let byteArray = from["ByteArray"] as? UInt32 {
            return .BytesArray(byteArray)
        }
        if let mapCLType = from["Map"] as? AnyObject {
            if !(mapCLType is NSNull) {
                let keyCLType = CLTypeHelper.jsonToCLType(from: mapCLType,keyStr: "key")
                let valueCLType = CLTypeHelper.jsonToCLType(from: mapCLType,keyStr: "value")
                return .Map(keyCLType, valueCLType);
            }
        }
        
        if let tuple1CLType = from["Tuple1"] as? [AnyObject] {
            var tuple1:CLType?
            var counter : Int = 0;
            for oneTuple in tuple1CLType {
                if counter == 0 {
                    tuple1 = CLTypeHelper.directJsonToCLType(from: oneTuple)
                }
            }
            return .Tuple1(tuple1!)
        }
        
        if let tuple2CLType = from["Tuple2"] as? [AnyObject] {
            var tuple1:CLType?
            var tuple2:CLType?
            var counter : Int = 0;
            for oneTuple in tuple2CLType {
                if counter == 0 {
                    tuple1 = CLTypeHelper.directJsonToCLType(from: oneTuple)
                } else if counter == 1 {
                    tuple2 = CLTypeHelper.directJsonToCLType(from: oneTuple)
                }
                counter += 1
            }
            return .Tuple2(tuple1!, tuple2!)
        }
        
        if let tuple3CLType = from["Tuple3"] as? [AnyObject] {
            if !(tuple3CLType is NSNull) {
                var tuple1:CLType?
                var tuple2:CLType?
                var tuple3:CLType?
                var counter : Int = 0;
                for oneTuple in tuple3CLType {
                    if counter == 0 {
                        tuple1 = CLTypeHelper.directJsonToCLType(from: oneTuple)
                    } else if counter == 1 {
                        tuple2 = CLTypeHelper.directJsonToCLType(from: oneTuple)
                    } else if counter == 2 {
                        tuple3 = CLTypeHelper.directJsonToCLType(from: oneTuple)
                    }
                    counter += 1
                }
                return .Tuple3(tuple1!, tuple2!,tuple3!)
            }
        }
        
        if let optionCLType = from["Option"] as? String {
            clType = CLTypeHelper.stringToCLTypePrimitive(input: optionCLType)
            return .Option(clType)
        } else if let optionCLType = from["Option"] as? AnyObject {
            if !(optionCLType is NSNull) {
                clType = CLTypeHelper.jsonToCLTypeCompound(from: optionCLType)
                return .Option(clType)
            }
        }
        if let resultCLType = from["Result"] as? AnyObject {
            if !(resultCLType is NSNull) {
                let okCLType = CLTypeHelper.jsonToCLType(from: resultCLType,keyStr: "ok")
                let errCLType = CLTypeHelper.jsonToCLType(from: resultCLType,keyStr: "err")
                return .Result(okCLType, errCLType)
            } else {
                NSLog("parse result cltype error")
            }
        }
        return .NONE
    }
    /**
     Get CLType  from Json string. If the Json string can convert to CLType primitive, then return the CLType primitive, otherwise return the CLType getting from the CLType compound
     - Parameter : a Json String represent the CLType object
     - Returns: CLType object
     */
    public static func directJsonToCLType(from:AnyObject)->CLType {
        var ret :CLType = .NONE
        if let clTypeWrapper = from as? String {
            ret = CLTypeHelper.stringToCLTypePrimitive(input: clTypeWrapper)
            return ret
        }
        else if let clTypeWrapper = from as? AnyObject {
            ret = CLTypeHelper.jsonToCLTypeCompound(from: clTypeWrapper)
        }
        return ret;
    }
    /**
     Get CLType primitive from String
     - Parameter : a  String represent the CLType object
     - Returns: CLType object
     */
    public static func stringToCLTypePrimitive(input:String)->CLType {
        if input == "String" {
            return .String
        } else if input == "Bool" {
            return .Bool
        } else if input == "U8" {
            return .U8
        } else if input == "U32" {
            return .U32
        } else if input == "U64" {
            return .U64
        } else if input == "U128" {
            return .U128
        } else if input == "I32" {
            return .I32
        } else if input == "I64" {
            return .I64
        } else if input == "U256" {
            return .U256
        } else if input == "U512" {
            return .U512
        } else if input == "String" {
            return .String
        } else if input == "Key" {
            return .Key
        } else if input == "URef" {
            return .URef
        } else if input == "PublicKey" {
            return .PublicKey
        } else if input == "Any" {
            return .CLAny
        } else if input == "Unit" {
            return .Unit
        }
        return .NONE
    }
}

