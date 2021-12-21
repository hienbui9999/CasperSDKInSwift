//
//  CLType.swift
//  SampleRPCCall1
//
//  Created by Hien on 14/12/2021.
//

import Foundation
enum CLType : Int {
    case BOOL               = 0
    case I32                = 1
    case I64                = 2
    case U8                 = 3
    case U32                = 4
    case U64                = 5
    case U128               = 6
    case U256               = 7
    case U512               = 8
    /** singleton value without additional semantics */
    case CLName_UNIT        = 9
    /** e.g. "Hello, World!" */
    case CLName_STRING      = 10
    /** global state key */
    case CLName_KEY         = 11
    /** unforgeable reference */
    case CLName_UREF        = 12
    /** optional value of the given type Option(CLType) */
    case CLName_OPTION      = 13
    /** List of values of the given type (e.g. Vec in rust). List(CLType) */
    case CLName_LIST        = 14
    /** Byte array prefixed with U32 length (FixedList) */
    case CLName_BYTE_ARRAY  = 15
    /** co-product of the the given types; one variant meaning success, the other failure */
    case CLName_RESULT      = 16
    /** Map(CLType, CLType), // key-value association where keys and values have the given types */
    case CLName_MAP         = 17
    /** Tuple1(CLType) single value of the given type */
    case CLName_TUPLE_1     = 18
    /** Tuple2(CLType, CLType), // pair consisting of elements of the given types */
    case CLName_TUPLE_2     = 19
    /** Tuple3(CLType, CLType, CLType), // triple consisting of elements of the given types */
    case CLName_TUPLE_3     = 20
    /** Indicates the type is not known */
    case CLName_ANY         = 21
    /** NO DEF IN SPEC https://docs.casperlabs.io/en/latest/implementation/serialization-standard.html */
    case CLName_PUBLIC_KEY  = 22
   
    
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
