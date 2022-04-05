import Foundation
/**
 Class supports the getting of GetBalanceResult from Json String
 */

class GetBalance {
    /**
        Get GetBalanceResult object from Json string
        - Parameter : a Json string represents the GetBalanceResult object
        - Throws: CasperMethodCallError.CasperError with code and message according to the error returned by the Casper system
        - Returns: GetBalanceResult object
        */

    public static func getStateBalanceFromJson(from: [String: Any])throws -> GetBalanceResult {
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
                throw CasperMethodCallError.casperError(code: code, message: message, methodCall: "state_get_balance")
            }
            let ret: GetBalanceResult = GetBalanceResult()
            if let result = from["result"] as? [String: Any] {
                if let apiVersion1 = result["api_version"] as? String {
                    ret.apiVersion = ProtocolVersion.strToProtocol(from: apiVersion1)
                }
                if let balanceValue1 = result["balance_value"] as? String {
                    ret.balanceValue = U512Class.fromStringToU512(from: balanceValue1)
                }
                if let merkleProof1 = result["merkle_proof"] as? String {
                    ret.merkleProof = merkleProof1
                }
            }
            return ret
        }
    }

}
