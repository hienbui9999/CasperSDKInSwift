//
//  CLType.swift
//  SampleRPCCall1
//
//  Created by Hien on 14/12/2021.
//

import Foundation
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
    case CLName_UNIT
    /** e.g. "Hello, World!" */
    case CLName_STRING
    /** global state key */
    case CLName_KEY
    /** unforgeable reference */
    case CLName_UREF
    /** optional value of the given type Option(CLType) */
    indirect case CLName_OPTION(CLType)
    /** List of values of the given type (e.g. Vec in rust). List(CLType) */
    indirect case CLName_LIST(CLType)
    /** Byte array prefixed with U32 length (FixedList) */
    indirect case CLName_FIXED_LIST(CLType,UInt32)
    /** co-product of the the given types; one variant meaning success, the other failure */
    indirect case CLName_RESULT(CLType,CLType)
    /** Map(CLType, CLType), // key-value association where keys and values have the given types */
    indirect case CLName_MAP(CLType,CLType)
    /** Tuple1(CLType) single value of the given type */
    indirect case CLName_TUPLE_1(CLType)
    /** Tuple2(CLType, CLType), // pair consisting of elements of the given types */
    indirect case CLName_TUPLE_2(CLType,CLType)
    /** Tuple3(CLType, CLType, CLType), // triple consisting of elements of the given types */
    indirect case CLName_TUPLE_3(CLType,CLType,CLType)
    /** Indicates the type is not known */
    case CLName_ANY
    /** NO DEF IN SPEC https://docs.casperlabs.io/en/latest/implementation/serialization-standard.html */
    case CLName_PUBLIC_KEY
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
