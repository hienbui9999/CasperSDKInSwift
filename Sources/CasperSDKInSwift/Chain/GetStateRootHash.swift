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
}
class GetStateRootHash {
    public static func getStateRootHash(from:[String:Any]) throws ->String {
        do {
            if let error = from["error"] as AnyObject? {
                var code:Int!
                var message:String!
                if let code1 = error["code"] as? Int {
                    code = code1
                }
                if let message1 = error["message"] as? String {
                    message = message1
                }
                throw CasperMethodCallError.CasperError(code: code, message: message,methodCall: "chain_get_state_root_hash")
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
