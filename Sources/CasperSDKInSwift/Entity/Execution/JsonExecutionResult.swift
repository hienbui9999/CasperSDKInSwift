import Foundation
/**
 Class represents the JsonExecutionResult
 */

public class JsonExecutionResult {
    public var blockHash: String = ""
    public var result: ExecutionResult = .none
    /**
       Get JsonExecutionResult object list from Json string
       - Parameter : a Json String represents the JsonExecutionResult object list
       - Returns: JsonExecutionResult object list
       */

    public static func getExecutionResult(from: [String: Any]) -> [JsonExecutionResult] {
        var retValue: [JsonExecutionResult] = [JsonExecutionResult]()
        if let executionResults = from["execution_results"] as? [AnyObject] {
            for executionResult in executionResults {
                let retJER: JsonExecutionResult = JsonExecutionResult()
                if let blockHash = executionResult["block_hash"] as? String {
                    retJER.blockHash = blockHash
                }
                if let ercJson = executionResult["result"] as? [String: Any] {
                    let result = ExecutionResultHelper.getExecutionResult(from: ercJson)
                    retJER.result = result
                }
                retValue.append(retJER)
            }
        }
        return retValue
    }

}
