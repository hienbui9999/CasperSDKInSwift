
import Foundation
public class DeployHash {
    public var value:String?
    public let ACCOUNT_PREFIX:String="deploy-"
    
    public static func fromStrToHash(from:String) -> DeployHash {
        let ret:DeployHash = DeployHash();
        ret.value = from;
        return ret;
    }
}

