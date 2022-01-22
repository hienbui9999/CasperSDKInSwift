import Foundation

public class Operation {
    public var  key:String?
    public var kind:OpKind?
    public static func getOperationFromJson(from:AnyObject)->Operation {
        let retOp : Operation = Operation();
        return retOp;
    }
}
