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

    public static func getStateBalanceFromJson(from:[String:Any])throws -> GetBalanceResult {
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
                throw CasperMethodCallError.CasperError(code: code, message: message,methodCall: "state_get_balance")
            }
            let ret:GetBalanceResult = GetBalanceResult();
            if let result = from["result"] as? [String:Any] {
                if let api_version = result["api_version"] as? String {
                    ret.api_version = ProtocolVersion.strToProtocol(from: api_version)
                }
                if let balance_value = result["balance_value"] as? String {
                    ret.balance_value = U512Class.fromStringToU512(from: balance_value)
                }
                if let merkle_proof = result["merkle_proof"] as? String {
                    ret.merkle_proof = merkle_proof
                }
            }
            return ret;
        }
    }
}
