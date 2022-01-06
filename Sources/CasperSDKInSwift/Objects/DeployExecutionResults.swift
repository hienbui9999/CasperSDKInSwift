import Foundation

public class RuntimeArg {
    public var item0:String = "";
    public var argsItem:DeployArgItem=DeployArgItem();
    public func textToArgObject(input:[String:Any]) -> DeployArgItem {
        var retArg:DeployArgItem = DeployArgItem();
        if let bytes = input["bytes"] as? String {
            retArg.bytes = bytes
        }
        if let clType=input["cl_type"] as? String {
            //PRIMITIVE TYPES
            if clType == "U8" {
                retArg.clType = .U8
            }else if clType == "U32" {
                retArg.clType = .U32
            }else if clType == "U64" {
                retArg.clType = .U64
            } else if clType == "U128" {
                retArg.clType = .U128
            } else if clType == "U256" {
                retArg.clType = .U256
            } else if clType == "U512" {
                retArg.clType = .U512
            } else if clType == "String" {
                retArg.clType = .CLType_STRING
            } else if clType == "BOOL" {
                retArg.clType = .BOOL
            } else if clType == "URef" {
                retArg.clType = .CLType_UREF
            } else if clType == "Key" {
                retArg.clType = .CLType_KEY
            }
            retArg.clTypeWarper = clType as AnyObject
        }
        else if let clTypeObj = input["cl_type"] as? AnyObject {
            retArg.clTypeWarper = clTypeObj
            let clType = encodeCLTypePrimitive(from: clTypeObj)
            switch clType {
            case .NONE:
                let clTypeCompound = encodeCLTypeCompound(from: clTypeObj)
                retArg.clType = clTypeCompound
                break;
            default:
                retArg.clType = clType;
                break;
            }
        }
        if let parsed = input["parsed"] as? String {
            retArg.parsed = parsed as AnyObject
        } else if let parsed = input["parsed"] as? AnyObject {
            retArg.parsed = parsed
            if let account = parsed["Account"] as? String {
            }
        }
        return retArg
    }
    public func printMe() {
        argsItem.printMe();
    }
    public func decodeCLTypeCompound(from:CLType)->String {
        return "";
    }
    public func decodeCLTypePrimitive(from:CLType)->String {
        return "";
    }
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
            return .CLType_STRING
        }
        if let keyMapCLType = from["key"] as? String {
            return .CLType_STRING
        }
        if let valueMapCLType = from["value"] as? String {
            return .CLType_STRING
        }
        if let byteArrray = from["ByteArray"] as? UInt32 {
            return .CLType_BytesArray
        }
        if let keyCLType = from["Key"] as? String {
            return .CLType_KEY;
        }
        if let publicKeyCLType = from["PublicKey"] as? String {
            return .CLType_PublicKey;
        }
        if let URefClType = from["URef"] as? String {
            return .CLType_UREF
        }
        return clType
    }
    public func stringToCLTypePrimitive(input:String)->CLType {
        if input == "String" {
            return .CLType_STRING
        } else if input == "Bool" {
            return .BOOL
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
            return .CLType_STRING
        } else if input == "Key" {
            return .CLType_KEY
        } else if input == "URef" {
            return .CLType_UREF
        } else if input == "PublicKey" {
            return .CLType_PublicKey
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
            return .CLType_LIST(clType)
        } else if let listCLType = from["List"] as? AnyObject {
            if !(listCLType is NSNull) {
                clType = encodeCLTypeCompound(from: listCLType)
                return .CLType_LIST(clType)
            }
        } else {
        }
        //FOR MAP TYPE
        if let mapCLType = from["Map"] as? AnyObject {
            if !(mapCLType is NSNull) {
                if let keyCLType = encodeCLTypePrimitive(from: mapCLType) as? CLType {
                    if let valueCLType = encodeCLTypePrimitive(from: mapCLType) as? CLType {
                        return .CLType_MAP(keyCLType, valueCLType)
                    } else {
                        let valueCLType = encodeCLTypeCompound(from: mapCLType) as! CLType
                        return .CLType_MAP(keyCLType, valueCLType)
                    }
                } else {
                    let keyCLType = encodeCLTypeCompound(from: mapCLType) as! CLType
                    if let valueCLType = encodeCLTypePrimitive(from: mapCLType) as? CLType {
                        return .CLType_MAP(keyCLType, valueCLType)
                    } else {
                        let valueCLType = encodeCLTypeCompound(from: mapCLType) as! CLType
                        return .CLType_MAP(keyCLType, valueCLType)
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
            return .CLType_OPTION(clType)
        } else if let optionCLType = from["Option"] as? AnyObject {
            if !(optionCLType is NSNull) {
                clType = encodeCLTypeCompound(from: optionCLType)
                return .CLType_OPTION(clType)
            }
        } else {
            
        }
        return .NONE
    }
}
public class DeployModuleByte {
    public var moduleBytes:String?
    public var args:[RuntimeArg]?
}
public class DeployStoredContractByHash {
    public var hash:String?
    public var entryPoint:String?
    public var args:[RuntimeArg]?
}
public enum ExecutableDeployItem {
    case ModuleBytes (String, [RuntimeArg])
    case StoredContractByHash(String,String,[RuntimeArg])
    case StoredContractByName(String,String,[RuntimeArg])
    case StoredVersionedContractByHash (String,UInt32?,String,[RuntimeArg])
    case StoredVersionedContractByName(String,UInt32?,String,[RuntimeArg])
    case Transfer([RuntimeArg])
    case NONE
}

public class DeployArgs {
    public var clType:CLType = .BOOL;
    public var parse:String="";
    public var bytes:String = "";
    public var argsDesc:String = "";
}

public class DeployExecutionResult {
    public var blockHash:String = "";
    
}
public class DeployExecutionResults {
    public var executionResults:[DeployExecutionResult] = [DeployExecutionResult] ();
}
