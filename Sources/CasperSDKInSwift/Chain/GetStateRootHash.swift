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
class GetStateRootHash {
    @available(iOS 15.0.0, *)
    public static func getStateRootHash(params:Any)async throws -> String {
        let methodStr : String = "chain_get_state_root_hash";
        do {
            let json = try await HttpHandler.handleRequest(method:methodStr,params: params);
            if let error = json["error"] as? AnyObject {
                if let code = error["code"] as? Int32 {
                  //  print("error code:\(code)")
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
                if let message = error["message"] as? String {
                  //  print("message:\(message)")
                } else {
                    //print("Can not show message in error")
                }
            }
            if let result = json["result"] as? AnyObject {
                if let api_version = result["api_version"] as? String {
                   // print("----IN ASYNC Api_version:\(api_version)")
                } else {
                  //  print("Can not get api_version in result")
                }
                if let state_root_hash = result["state_root_hash"] as? String{
                  //  print("-----IN ASYNC stateRootHash:\(state_root_hash)")
                    return state_root_hash
                } else {
                 //   print("Error get state root hash")
                    throw GetStateRootHashError.parseError
                }
            } else {
                //print("error get json result")
                throw GetStateRootHashError.parseError
            }
        } catch {
           // print("GetStateRootHash - getStateRootHash function called, ERROR GET STATE ROOT HASH 2: \(error)")
            throw error
        }
       // throw CasperMethodError.unknown
    }
}
