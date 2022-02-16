import Foundation
/**
 Class represents the GetDeployResult
 */

public class GetDeployResult {
    public var deploy:Deploy = Deploy();
    public var execution_results:[JsonExecutionResult] = [JsonExecutionResult]();
    public var api_version:ProtocolVersion =  ProtocolVersion();//1.4.3
}
