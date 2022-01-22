import Foundation

public class NamedArg {
    public var name:String = "";
    public var argsItem:CLValue=CLValue();
    public static func jsonToCLValue(input:[String:Any]) -> CLValue {
        var retArg:CLValue = CLValue();
        if let bytes = input["bytes"] as? String {
            retArg.bytes = bytes
        }
        retArg.cl_type = CLTypeHelper.jsonToCLType(from: input as AnyObject)
        retArg.parsed = CLValue.getCLValueWrapper(from: input as AnyObject, clType: retArg.cl_type)
        return retArg
    }
    
    public func decodeCLTypeCompound(from:CLType)->String {
        return "";
    }
    public func decodeCLTypePrimitive(from:CLType)->String {
        return "";
    }
    /*
    public func encodeCLTypePrimitive(from:AnyObject)->CLType {
        var clType : CLType = .NONE
        //primitive type
        if let boolCLType = from["Bool"] as? Bool {
            return clType
        }
        if let u8CLType = from["U8"] as? UInt8 {
            return .U8
        }
        if let u32CLType = from["U32"] as? UInt32 {
            return .U32
        }
        if let u64CLType = from["U64"] as? UInt64 {
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
        }//ERROR IF MAP IS key:UINT32,VALUE:String
        if let keyMapCLType = from["key"] as? String {
            return .String
        }
        if let valueMapCLType = from["value"] as? String {
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
        return clType
    }
    public func stringToCLTypePrimitive(input:String)->CLType {
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
        } 
        return .NONE
    }
    public func encodeCLTypeCompound(from:AnyObject)->CLType {
        var clType:CLType = .NONE
        if let clType = encodeCLTypePrimitive(from: from) as? CLType {
            switch clType {
            case .NONE:
                break;
            default:
                return clType
                break;
            }
        }
        if let listCLType = from["List"] as? String {
            clType = stringToCLTypePrimitive(input: listCLType)
            return .List(clType)
        } else if let listCLType = from["List"] as? AnyObject {
            if !(listCLType is NSNull) {
                clType = encodeCLTypeCompound(from: listCLType)
                return .List(clType)
            }
        } else {
            
        }
        //FOR MAP TYPE
        if let mapCLType = from["Map"] as? AnyObject {
            if !(mapCLType is NSNull) {
                if let keyCLType = encodeCLTypePrimitive(from: mapCLType) as? CLType {
                    if let valueCLType = encodeCLTypePrimitive(from: mapCLType) as? CLType {
                        return .Map(keyCLType, valueCLType)
                    } else {
                        let valueCLType = encodeCLTypeCompound(from: mapCLType) as! CLType
                        return .Map(keyCLType, valueCLType)
                    }
                } else {
                    let keyCLType = encodeCLTypeCompound(from: mapCLType) as! CLType
                    if let valueCLType = encodeCLTypePrimitive(from: mapCLType) as? CLType {
                        return .Map(keyCLType, valueCLType)
                    } else {
                        let valueCLType = encodeCLTypeCompound(from: mapCLType) as! CLType
                        return .Map(keyCLType, valueCLType)
                    }
                }
            }
        }
        //FOR TUPLE1 TYPE
        if let tuple1CLType = from["Tuple1"] as? AnyObject {
            
        }
        //FOR OPTION
        if let optionCLType = from["Option"] as? String {
            clType = stringToCLTypePrimitive(input: optionCLType)
            return .Option(clType)
        } else if let optionCLType = from["Option"] as? AnyObject {
            if !(optionCLType is NSNull) {
                clType = encodeCLTypeCompound(from: optionCLType)
                return .Option(clType)
            }
        } else {
            
        }
        return .NONE
    }*/
}

public class DeployModuleByte {
    public var moduleBytes:String?
    public var args:[NamedArg]?
}

public class DeployStoredContractByHash {
    public var hash:String?
    public var entryPoint:String?
    public var args:[NamedArg]?
}



public class DeployArgs {
    public var clType:CLType = .NONE;
    public var parse:String="";
    public var bytes:String = "";
    public var argsDesc:String = "";
}


