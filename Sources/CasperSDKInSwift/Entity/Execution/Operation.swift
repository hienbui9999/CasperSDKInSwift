import Foundation
/**
 Class represents the Operation
 */

public class Operation {
    public var  key: String?
    public var kind: OpKind?
    /**
        Get Operation object from Json string
        - Parameter : a Json String represents the Operation object
        - Returns: Operation object
        */

    public static func getOperationFromJson(from: AnyObject) -> Operation {
        let retOp: Operation = Operation()
        return retOp
    }

}
