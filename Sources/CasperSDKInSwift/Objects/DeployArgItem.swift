//
//  File.swift
//  
//
//  Created by Hien on 29/12/2021.
//

import Foundation
public class DeployArgItem {
    public var bytes:String = "";// serialization of parsed
    public var clTypeWarper:AnyObject?;//among the CLType
    public var parsed:AnyObject?;//CLType value
    public var clType:CLType?;//real CLType enum
    public func printMe() {
        print("byte:\(bytes), clType:\(clType),parse:\(parsed), clTypeWrapper:\(clTypeWarper)")
    }
}

//if the clType is U32 then parse will be somehow 332
//if the clType is String then parse will be somehow "abc123"
//if the clType is an object {"ByteArray":32} then parse is somehow "f929911F7494A360271b968ac00Fe2220773235e725366952De5d9a349e57c7B"
//if the clType is somehow like this
/*"cl_type":{
    "Map":{
        "key":"String"
        "value":"String"
    }
 }
 then parse would be a list of key-value pairs
 "parsed":[4 items
 0:{2 items
 "key":"contract_package_hash"
 "value":"060961a44DD278285718381aB45D7F020cba33EEe5885e336813f34504cDC8a8"
 }
 1:{2 items
 "key":"event_type"
 "value":"sync"
 }
 2:{2 items
 "key":"reserve0"
 "value":"102134951720961"
 }
 3:{2 items
 "key":"reserve1"
 "value":"220198034302865048279"
 }
 ]
 bytes":"f929911F7494A360271b968ac00Fe2220773235e725366952De5d9a349e57c7B"

 "cl_type":{1 item
 "ByteArray":32
 }
 */
