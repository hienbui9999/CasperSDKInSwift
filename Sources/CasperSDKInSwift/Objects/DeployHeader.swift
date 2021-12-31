//
//  File.swift
//  
//
//  Created by Hien on 29/12/2021.
//

import Foundation
public class DeployHeader { //7 items
    public var account:String = "";//01d9bf2148748a85c89da5aad8ee0b0fc2d105fd39d41a4c796536354f0ae2900c
    public var bodyHash:String = "";//4811966d37fe5674a8af4001884ea0d9042d1c06668da0c963769c3a01ebd08f
    public var chainName:String = "";//casper-example
    public var gasPrice:UInt64 = 0;//1
    public var timeStamp:String = "";//2020-11-17T00:39:24.072Z
    public var ttl:String = "";//"1h"
    public var dependencies:[String] = [String]();//[0:"0101010101010101010101010101010101010101010101010101010101010101"]
}
