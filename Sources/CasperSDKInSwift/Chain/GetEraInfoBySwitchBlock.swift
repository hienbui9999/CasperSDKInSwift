import Foundation

class GetEraInfoBySwitchBlock {
    public static func getResult(from:[String:Any]) throws -> GetEraInfoResult {
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
