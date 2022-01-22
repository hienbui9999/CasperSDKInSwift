import Foundation

enum GetStateRootHashError: Error {
    case invalidURL
    case parseError
    case methodNotFound
    case blockNotFound
    case blockHeightError
}
public class GetStateRootHashParam{
    public var block_identifier:BlockIdentifier = .None
    //public var blockHash:String?
    //public var blockHeight:UInt64?
    /*public func toJsonData()->Data {
        var hasParam:Bool = false
        var objParam:[String:Any] = [:]
        if block_identifier blockHash != nil {
            if blockHash != "" {
                objParam = ["block_identifier":["Hash":blockHash]]
                hasParam = true
            }
        }
        if blockHeight != nil {
            if blockHeight! >= 0 {
                objParam = ["block_identifier":["Height":blockHeight]]
                hasParam = true
            }
        }
        var obj:[String:Any]!
        if hasParam {
            obj = ["jsonrpc":CASPER_RPC_VERSION,"id":CASPER_ID,"method":"chain_get_state_root_hash","params":objParam]
        } else {
            obj = ["jsonrpc":CASPER_RPC_VERSION,"id":CASPER_ID,"method":"chain_get_state_root_hash","params":"[]"]
        }
        let encode = JSONEncoder()
        encode.outputFormatting = .prettyPrinted
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
            print(String(data: jsonData, encoding: .utf8)!)
            return jsonData
        }
        catch {
            print("Error:\(error)")
        }
        return Data()
    }*/
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
