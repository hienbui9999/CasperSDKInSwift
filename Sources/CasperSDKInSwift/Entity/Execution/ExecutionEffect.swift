import Foundation
/**
 Class represents the ExecutionEffect
 */

public class ExecutionEffect {
    ///List of Operation
    public var operations:[Operation] = [Operation]()
    ///List of TransformEntry
    public var transforms:[TransformEntry] = [TransformEntry]()
    /**
        Get ExecutionEffect object from Json string
        - Parameter : a Json String represents the ExecutionEffect object
        - Returns: ExecutionEffect object
        */

    public static func getExecutionEffect(from:[String:Any]) -> ExecutionEffect {
        let retExecutionEffect:ExecutionEffect = ExecutionEffect();
        if let oJsons = from["operations"] as? [AnyObject] {
            for oJson in oJsons {
                let oneOperation = Operation.getOperationFromJson(from: oJson);
                retExecutionEffect.operations.append(oneOperation)
            }
        }
        if let transforms = from["transforms"] as? [[String:AnyObject]] {
            for transform in transforms {
                let transformObj:TransformEntry = TransformEntry.getTransformEntry(from:transform)
                retExecutionEffect.transforms.append(transformObj)
            }
        }
        return retExecutionEffect
    }
}
