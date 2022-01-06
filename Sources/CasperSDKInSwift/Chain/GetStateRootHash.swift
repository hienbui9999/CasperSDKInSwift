
/**
  * Retrieves a state root hash at a given block
  *
  * @param blockHash or blockHeight or []
  * @return state_root_hash_String
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
