import Foundation
public class ExecutionEffect {
    public var operations:[Operation] = [Operation]()
    public var transforms:TransformEntry = TransformEntry()
    public static func getExecutionEffect(from:[String:Any]) -> ExecutionEffect {
        let retExecutionEffect:ExecutionEffect = ExecutionEffect();
        if let oJsons = from["operations"] as? [AnyObject] {
            let totalOperations = oJsons.count
            print("Total operation:\(totalOperations)")
            //THIS IS NOT DONE
            for oJson in oJsons {
                let oneOperation = Operation.getOperationFromJson(from: oJson);
                retExecutionEffect.operations.append(oneOperation)
            }
        }
        if let transforms = from["transforms"] as? [[String:AnyObject]] {
            let totalTransform = transforms.count;
            var counter:UInt = 0;
            for transform in transforms {
                let transformObj:TransformEntry = TransformEntry.getTransformEntry(from:transform)
                counter += 1
            }
        }
        return retExecutionEffect
    }
}
