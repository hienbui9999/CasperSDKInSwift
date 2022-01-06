//
//  GetStateRootHash.swift
//  SampleRPCCall1
//
//  Created by Hien on 09/12/2021.
//
//https://docs.rs/casper-node/latest/casper_node/rpcs/chain/struct.GetStateRootHash.html

//DATA BACK LIKE THIS
/*
 ["result": {
     "api_version" = "1.4.3";
     "state_root_hash" = 1b0e70c9c78873867E317b184Ce1723162d6956fad9E8e4b1897D6f505c5e496;
 }, "id": 1, "jsonrpc": 2.0]
 */

import Foundation
enum GetStateRootHashError: Error {
    case invalidURL
    case parseError
    case methodNotFound
    case blockNotFound
    case blockHeightError
}
public class GetStateRootHashParam{
    public var blockHash:String?
    public var blockHeight:UInt64?
}
class GetStateRootHash {
    public static func getStateRootHash(from:[String:Any]) throws ->String {
        if let error = from["error"] as AnyObject? {
            if let code = error["code"] as? Int32 {
                if code == -32700 {
                    throw GetStateRootHashError.parseError;
                } else if code == -32601 {
                    throw GetStateRootHashError.methodNotFound
                } else if code == -32001 {
                    throw GetStateRootHashError.blockNotFound
                } else {
                    throw GetStateRootHashError.invalidURL
                }
            }
        }
        if let result = from["result"] as AnyObject? {
            if let _ = result["api_version"] as? String {
            } else {
            }
            if let state_root_hash = result["state_root_hash"] as? String{
                return state_root_hash
            } else {
                throw GetStateRootHashError.parseError
            }
        } else {
            throw GetStateRootHashError.parseError
        }
    }
}
