import Foundation
/**
 Class represents the DeployHash
 */
public class DeployHash {
    ///The value of deploy hash in string
    public var value:String?
    ///Prefix of the deploy hash
    public let DEPLOY_HASH_PREFIX:String="deploy-"
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

