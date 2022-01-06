//
//  CLType.swift
//  SampleRPCCall1
//
//  Created by Hien on 14/12/2021.
//

import Foundation
public class CLTypeWarpper {
    public func getValueForCLTypePrimitive(atype:CLType) ->String{
        return "";//BOOL, UInt32 to UInt512,String
    }
    public func getValueForCLTypeUnit() -> String { /** singleton value without additional semantics */
        return "";
    }
    public func getValueForCLTypeKey() -> String { /** global state key */
        return ""
    }
    public func getValueForCLTypeURef() -> String { /** unforgeable reference */
        return ""
    }
    public func getValueForCLTypeBytesArray() -> String { /*Fixed-length list of a single CLType (comparable to a Rust array).*/
        return ""
        
    }
    /*
    public func getValueForCLTypeBytesList<T>() -> [T] {/** Byte array prefixed with U32 length (FixedList) */
        return
    }
    public func getValueForCLTypeList<T>()->[T] { /** List of values of the given type (e.g. Vec in rust). List(CLType) */
        return [T];
    }
    public func getValueForCLTypeOption<T>()->[T] {     /** optional value of the given type Option(CLType) */
        return [T]
    }*/
    //public func getValueForCLTypeResult<T,U>()->[T,U] {/** co-product of the the given types; one variant meaning success, the other failure */
        
   // }
   // public func getValueForCLTypeMap<T,U>()->[T,U] {/** Map(CLType, CLType), // key-value association where keys and values have the given types */
        
    //}
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
    /** singleton value without additional semantics */
    case CLType_UNIT
    /** e.g. "Hello, World!" */
    case CLType_STRING
    /** global state key */
    case CLType_KEY
    /** unforgeable reference */
    case CLType_UREF
    case CLType_BytesArray; /*Fixed-length list of a single CLType (comparable to a Rust array).*/
    /** optional value of the given type Option(CLType) */
    indirect case CLType_OPTION(CLType)
    /** List of values of the given type (e.g. Vec in rust). List(CLType) */
    indirect case CLType_LIST(CLType)
    /** Byte array prefixed with U32 length (FixedList) */
    indirect case CLType_FIXED_LIST(CLType,UInt32)
    /** co-product of the the given types; one variant meaning success, the other failure */
    indirect case CLType_RESULT(CLType,CLType)
    /** Map(CLType, CLType), // key-value association where keys and values have the given types */
    indirect case CLType_MAP(CLType,CLType)
    /** Tuple1(CLType) single value of the given type */
    indirect case CLType_TUPLE_1(CLType)
    /** Tuple2(CLType, CLType), // pair consisting of elements of the given types */
    indirect case CLType_TUPLE_2(CLType,CLType)
    /** Tuple3(CLType, CLType, CLType), // triple consisting of elements of the given types */
    indirect case CLType_TUPLE_3(CLType,CLType,CLType)
    /** Indicates the type is not known */
    case CLName_Any
    /** NO DEF IN SPEC https://docs.casperlabs.io/en/latest/implementation/serialization-standard.html */
    case CLType_PublicKey
    case NONE
}
class CLTypeClass {
    private var clType:Int32 = 0;
    //byte in swift is UInt8
  /*  func  getClType()-> UInt8 {
        return (UInt8) clType;
    }*/
    static func isNumeric(clType: CLType) ->Bool {
            switch (clType) {
            case .I32, .I64, .U8, .U32, .U64, .U128, .U256, .U512:
                    return true;
                default:
                    return false;
            }
        }
}
