import Foundation
/**
 Class represents the DeployHash
 */
public class DeployHash {
    public var value:String?
    public let ACCOUNT_PREFIX:String="deploy-"
    /**
       Build DeployHash object from string
       - Parameter : a  String represents the DeployHash object
       - Returns: DeployHash object
       */
    public static func fromStrToHash(from:String) -> DeployHash {
        let ret:DeployHash = DeployHash();
        ret.value = from;
        return ret;
    }
}

