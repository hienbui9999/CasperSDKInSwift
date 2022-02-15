import Foundation
/**
 class represent the GetEraInfoResult
 */
public class GetEraInfoResult {
    ///Casper api version
    public var api_version:ProtocolVersion = ProtocolVersion()
    ///era summary object
    public var era_summary:EraSummary?
}
