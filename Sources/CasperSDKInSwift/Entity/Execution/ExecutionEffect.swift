import Foundation
public class ExecutionEffect {
    public var operations:[Operation] = [Operation]()
    public var transforms:[TransformEntry] = [TransformEntry]()
    public static func getExecutionEffect(from:[String:Any]) -> ExecutionEffect {
        let retExecutionEffect:ExecutionEffect = ExecutionEffect();
        if let oJsons = from["operations"] as? [AnyObject] {
            let totalOperations = oJsons.count
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
