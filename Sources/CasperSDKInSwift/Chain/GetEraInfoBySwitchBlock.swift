import Foundation

class GetEraInfoBySwitchBlock {
    public static func getResult(from:[String:Any]) throws -> GetEraInfoResult {
        if let error = from["error"] as AnyObject? {
            var code:Int!
            var message:String!
            if let code1 = error["code"] as? Int {
                code = code1
            }
            if let message1 = error["message"] as? String {
                message = message1
            }
            throw CasperMethodCallError.CasperError(code: code, message: message)
        }
        let retResult:GetEraInfoResult = GetEraInfoResult();
        if let resultJson = from["result"] as? [String:Any] {
            if let apiVersion = resultJson["api_version"] as? String {
                retResult.api_version = ProtocolVersion.strToProtocol(from: apiVersion)
            }
            if let eraSummaryJson = resultJson["era_summary"] as? [String:Any]{
                retResult.era_summary = EraSummary.getEraSummaryFromJson(from: eraSummaryJson)
            }
        }
        return retResult;
    }
    
}
