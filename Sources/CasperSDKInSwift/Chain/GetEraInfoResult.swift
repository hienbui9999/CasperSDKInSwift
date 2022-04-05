import Foundation
/**
 Class represents the GetEraInfoResult
 */
public class GetEraInfoResult {
    /// Casper api version
    public var apiVersion: ProtocolVersion = ProtocolVersion()
    /// era summary object
    public var eraSummary: EraSummary?
}
