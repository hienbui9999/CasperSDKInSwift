import Foundation
/**
 Class represents the GetDeployResult
 */

public class GetDeployResult {
    public var deploy: Deploy = Deploy()
    public var executionResults: [JsonExecutionResult] = [JsonExecutionResult]()
    public var apiVersion: ProtocolVersion =  ProtocolVersion()
}
