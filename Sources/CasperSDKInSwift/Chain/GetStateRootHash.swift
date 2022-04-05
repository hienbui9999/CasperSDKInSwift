import Foundation
/**
 Class represents the GetStateRootHashParam
 */
public class GetStateRootHashParam {
    /// The block identifier for getting GetBlockTransfersResult
    public var blockIdentifier: BlockIdentifier = .none
}
/**
 class represent the GetStateRootHash
 */
class GetStateRootHash {
    /**
     Get state root hash from Json string
     - Parameter: a Json String represent the state root hash
     - Throws: CasperMethodCallError.CasperError with code and message according to the error returned by the Casper system
     - Returns: state root hash string
     */

    public static func getStateRootHash(from: [String: Any]) throws -> String {
        do {
            if let error = from["error"] as AnyObject? {
                var code: Int!
                var message: String!
                if let code1 = error["code"] as? Int {
                    code = code1
                }
                if let message1 = error["message"] as? String {
                    message = message1
                }
                throw CasperMethodCallError.casperError(code: code, message: message, methodCall: "chain_get_state_root_hash")
            }
        }
        if let result = from["result"] as AnyObject? {
            if let _ = result["api_version"] as? String {
            } else {
            }
            if let stateRootHash = result["state_root_hash"] as? String {
                return stateRootHash
            } else {
                NSLog("Error get state root hash")
            }
        } else {
            NSLog("Error get state root hash")
        }
        return ""
    }

}
