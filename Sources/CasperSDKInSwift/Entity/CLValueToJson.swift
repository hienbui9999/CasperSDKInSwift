import Foundation
public class CLValueToJson {
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
    public static func toJsonObj(clValue:CLValue)throws -> [String:Any] {
        do {
            if CLValue.isCLTypePrimitive(cl_type: clValue.cl_type) {
                let clValueType : String = CLValue.getCLTypeString(cl_type:clValue.cl_type)
                if clValueType == "Bool" {
                    let ret:[String:Any] = ["cl_type": clValueType,"bytes":try CLTypeSerializeHelper.CLValueSerialize(input: clValue.parsed), "parsed": CLValue.getParsedValueBool(clValueWrapper:clValue.parsed)]
                    return ret
                } else if clValueType == "I32" {
                    let ret:[String:Any] = ["cl_type": clValueType,"bytes":try CLTypeSerializeHelper.CLValueSerialize(input: clValue.parsed), "parsed": CLValue.getRawValueOfI32(clValue: clValue.parsed)]
                    return ret
                }else if clValueType == "I64" {
                    let ret:[String:Any] = ["cl_type": clValueType,"bytes":try CLTypeSerializeHelper.CLValueSerialize(input: clValue.parsed), "parsed": CLValue.getRawValueOfI64(clValue: clValue.parsed)]
                    return ret
                }else if clValueType == "U8" {
                    let ret:[String:Any] = ["cl_type": clValueType,"bytes":try CLTypeSerializeHelper.CLValueSerialize(input: clValue.parsed), "parsed": CLValue.getRawValueOfU8(clValue: clValue.parsed)]
                    return ret
                }else if clValueType == "U32" {
                    let ret:[String:Any] = ["cl_type": clValueType,"bytes":try CLTypeSerializeHelper.CLValueSerialize(input: clValue.parsed), "parsed": CLValue.getRawValueOfU32(clValue: clValue.parsed)]
                    return ret
                }else if clValueType == "U64" {
                    let ret:[String:Any] = ["cl_type": clValueType,"bytes":try CLTypeSerializeHelper.CLValueSerialize(input: clValue.parsed), "parsed": CLValue.getRawValueOfU64(clValue: clValue.parsed)]
                    return ret
                }else if clValueType == "U128" {
                    let ret:[String:Any] = ["cl_type": clValueType,"bytes":try CLTypeSerializeHelper.CLValueSerialize(input: clValue.parsed), "parsed": CLValue.getRawValueOfU128(clValue: clValue.parsed).valueInStr]
                    return ret
                }else if clValueType == "U256" {
                    let ret:[String:Any] = ["cl_type": clValueType,"bytes":try CLTypeSerializeHelper.CLValueSerialize(input: clValue.parsed), "parsed": CLValue.getRawValueOfU256(clValue: clValue.parsed).valueInStr]
                    return ret
                }else if clValueType == "U512" {
                    let ret:[String:Any] = ["cl_type": clValueType,"bytes":try CLTypeSerializeHelper.CLValueSerialize(input: clValue.parsed), "parsed": CLValue.getRawValueOfU512(clValue:clValue.parsed).valueInStr]
                    return ret
                } else if clValueType == "String" {
                    let ret:[String:Any] = ["cl_type": clValueType,"bytes":try CLTypeSerializeHelper.CLValueSerialize(input: clValue.parsed), "parsed": CLValue.getRawValueOfStringType(clValue:clValue.parsed)]
                    return ret
                } else if clValueType == "PublicKey" {
                    let ret:[String:Any] = ["cl_type": clValueType,"bytes":try CLTypeSerializeHelper.CLValueSerialize(input: clValue.parsed), "parsed": CLValue.getRawValueOfPublicKeyType(clValue:clValue.parsed)]
                    return ret
                } else if clValueType == "URef" {
                    let ret:[String:Any] = ["cl_type": clValueType,"bytes":try CLTypeSerializeHelper.CLValueSerialize(input: clValue.parsed), "parsed": CLValue.getRawValueOfURef(clValue:clValue.parsed)]
                    return ret
                }  else if clValueType == "Key" {
                    let ret:[String:Any] = ["cl_type": clValueType,"bytes":try CLTypeSerializeHelper.CLValueSerialize(input: clValue.parsed), "parsed": CLValue.getRawValueOfKey(clValue:clValue.parsed)]
                    return ret
                }
                
            } else {
                let clValueType : String = CLValue.getCLTypeString(cl_type:clValue.cl_type)
                //get Json for Option
                if clValueType == "Option" {
                    let ret = CLValueToJson.getJsonForOptionCLValue(clValue: clValue)
                    return ret
                } else if clValueType == "List" {
                    let ret = CLValueToJson.getJsonForListCLValueOfTypeString(clValue: clValue)
                }
                let ret:[String:Any] = ["cl_type": CLValue.getCLTypeJsonCompound(cl_type: clValue.cl_type),"bytes":try CLTypeSerializeHelper.CLValueSerialize(input: clValue.parsed), "parsed": CLValue.getParsedValue(clValueWrapper:clValue.parsed)]
                return ret
            }
            
        } catch {
            throw error
        }
        return ["":""]
    }
    //json for List
    public static func getJsonForListCLValueOfTypeString(clValue:CLValue)->[String:Any] {
        var ret:[String] = [];
        do {
            switch clValue.cl_type {
            case .List(let clType):
                if CLValue.isCLTypePrimitive(cl_type: clType) {
                    print("List of type primitive begin")
                    switch clValue.parsed {
                        case .ListWrapper(let array):
                        for element in array {
                            switch element {
                            case .U128(let u128Class):
                                ret.append(u128Class.valueInStr)
                            case .U256(let u256Class):
                                ret.append(u256Class.valueInStr)
                            case .U512(let u512Class):
                                ret.append(u512Class.valueInStr)
                            case .Unit(let string):
                                ret.append(string)
                            case .String(let string):
                                ret.append(string)
                            case .Key(let string):
                                ret.append(string)
                            case .URef(let string):
                                ret.append(string)
                            case .PublicKey(let string):
                                ret.append(string)
                            case .BytesArray(let string):
                                ret.append(string)
                            default:
                                ret.append("")
                            }
                        }
                        print("Ret for list:\(ret)")
                        do {
                            let retReal:[String:Any] = ["cl_type": CLValue.getCLTypeJsonCompound(cl_type: clValue.cl_type),"bytes": try CLTypeSerializeHelper.CLValueSerialize(input: clValue.parsed), "parsed": ret]
                            return retReal;
                        } catch {
                            return ["":""]
                        }
                        
                            break;
                        default:
                            break;
                    }
                    print("List of type primitive end")
                }
                else {
                    print("List of type Compound")
                }
            default:
                break;
            }
        }
        return ["":""]
    }
    public static func getJsonForListCLValue(clValue:CLValue)->[AnyObject] {
        var ret:[AnyObject] = [];
        do {
            switch clValue.cl_type {
            case .List(let clType):
                if CLValue.isCLTypePrimitive(cl_type: clType) {
                    print("List of type primitive begin")
                    switch clValue.parsed {
                        case .ListWrapper(let array):
                        for element in array {
                            switch element {
                            case .Bool(let bool):
                                ret.append(bool as AnyObject)
                            case .I32(let int32):
                                ret.append(int32 as AnyObject)
                            case .I64(let int64):
                                ret.append(int64 as AnyObject)
                            case .U8(let uInt8):
                                ret.append(uInt8 as AnyObject)
                            case .U32(let uInt32):
                                ret.append(uInt32 as AnyObject)
                            case .U64(let uInt64):
                                ret.append(uInt64 as AnyObject)
                            case .U128(let u128Class):
                                ret.append(u128Class.valueInStr as AnyObject)
                            case .U256(let u256Class):
                                ret.append(u256Class.valueInStr as AnyObject)
                            case .U512(let u512Class):
                                ret.append(u512Class.valueInStr as AnyObject)
                            case .Unit(let string):
                                ret.append(string as AnyObject)
                            case .String(let string):
                                ret.append(string as AnyObject)
                            case .Key(let string):
                                ret.append(string as AnyObject)
                            case .URef(let string):
                                ret.append(string as AnyObject)
                            case .PublicKey(let string):
                                ret.append(string as AnyObject)
                            case .BytesArray(let string):
                                ret.append(string as AnyObject)
                            default:
                                ret.append("" as AnyObject)
                            }
                        }
                        print("Ret for list:\(ret)")
                        return ret;
                            break;
                        default:
                            break;
                    }
                    print("List of type primitive end")
                }
                else {
                    print("List of type Compound")
                }
            default:
                break;
            }
        }
        return ret
    }
    //json for option
    public static func getJsonForOptionCLValue(clValue:CLValue)->[String:Any] {
        do {
            switch clValue.parsed {
            case .NULL:
                let ret:[String:Any] = ["cl_type": CLValue.getCLTypeJsonCompound(cl_type: clValue.cl_type),"bytes":try CLTypeSerializeHelper.CLValueSerialize(input: .OptionWrapper(.NULL)), "parsed": "NULL" as AnyObject]
                return ret
            case .OptionWrapper(.Bool(let bool)):
                let ret:[String:Any] = ["cl_type": CLValue.getCLTypeJsonCompound(cl_type: clValue.cl_type),"bytes":try CLTypeSerializeHelper.CLValueSerialize(input: clValue.parsed), "parsed": bool]
                return ret
            case .OptionWrapper(.I32(let i32)):
                let ret:[String:Any] = ["cl_type": CLValue.getCLTypeJsonCompound(cl_type: clValue.cl_type),"bytes":try CLTypeSerializeHelper.CLValueSerialize(input: clValue.parsed), "parsed": i32]
                return ret
            case .OptionWrapper(.I64(let i64)):
                let ret:[String:Any] = ["cl_type": CLValue.getCLTypeJsonCompound(cl_type: clValue.cl_type),"bytes":try CLTypeSerializeHelper.CLValueSerialize(input: clValue.parsed), "parsed": i64]
                return ret
            case .OptionWrapper(.U8(let u8)):
                let ret:[String:Any] = ["cl_type": CLValue.getCLTypeJsonCompound(cl_type: clValue.cl_type),"bytes":try CLTypeSerializeHelper.CLValueSerialize(input: clValue.parsed), "parsed": u8]
                return ret
            case .OptionWrapper(.U32(let u32)):
                let ret:[String:Any] = ["cl_type": CLValue.getCLTypeJsonCompound(cl_type: clValue.cl_type),"bytes":try CLTypeSerializeHelper.CLValueSerialize(input: clValue.parsed), "parsed": u32]
                return ret
            case .OptionWrapper(.U64(let u64)):
                let ret:[String:Any] = ["cl_type": CLValue.getCLTypeJsonCompound(cl_type: clValue.cl_type),"bytes":try CLTypeSerializeHelper.CLValueSerialize(input: clValue.parsed), "parsed": u64]
                return ret
            case .OptionWrapper(.U128(let u128)):
                let ret:[String:Any] = ["cl_type": CLValue.getCLTypeJsonCompound(cl_type: clValue.cl_type),"bytes":try CLTypeSerializeHelper.CLValueSerialize(input: clValue.parsed), "parsed": u128.valueInStr]
                return ret
            case .OptionWrapper(.U256(let u256)):
                let ret:[String:Any] = ["cl_type": CLValue.getCLTypeJsonCompound(cl_type: clValue.cl_type),"bytes":try CLTypeSerializeHelper.CLValueSerialize(input: clValue.parsed), "parsed": u256.valueInStr]
                return ret
            case .OptionWrapper(.U512(let u512)):
                let ret:[String:Any] = ["cl_type": CLValue.getCLTypeJsonCompound(cl_type: clValue.cl_type),"bytes":try CLTypeSerializeHelper.CLValueSerialize(input: clValue.parsed), "parsed": u512.valueInStr]
                return ret
            case .OptionWrapper(.String(let string)):
                let ret:[String:Any] = ["cl_type": CLValue.getCLTypeJsonCompound(cl_type: clValue.cl_type),"bytes":try CLTypeSerializeHelper.CLValueSerialize(input: clValue.parsed), "parsed": string] //CLValue.getRawValueOfStringType(clValue: clValue.parsed)]
                return ret
            case .OptionWrapper(.Key(let key)):
                let ret:[String:Any] = ["cl_type": CLValue.getCLTypeJsonCompound(cl_type: clValue.cl_type),"bytes":try CLTypeSerializeHelper.CLValueSerialize(input: clValue.parsed), "parsed": key]
                return ret
            case .OptionWrapper(.URef(let uref)):
                let ret:[String:Any] = ["cl_type": CLValue.getCLTypeJsonCompound(cl_type: clValue.cl_type),"bytes":try CLTypeSerializeHelper.CLValueSerialize(input: clValue.parsed), "parsed": uref]
                return ret
            case .OptionWrapper(.PublicKey(let publicKey)):
                let ret:[String:Any] = ["cl_type": CLValue.getCLTypeJsonCompound(cl_type: clValue.cl_type),"bytes":try CLTypeSerializeHelper.CLValueSerialize(input: clValue.parsed), "parsed": publicKey]
                return ret
            default:
                return ["":""]
            }
        } catch {
            return ["":""]
        }
    }
}
