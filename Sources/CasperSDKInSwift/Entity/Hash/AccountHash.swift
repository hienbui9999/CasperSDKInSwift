import Foundation
/**
 Class represents the AccountHash
 */

public class AccountHash {
    public var value:String?
    public let ACCOUNT_PREFIX:String="account-hash-"
    /**
       Build AccountHash object from string
       - Parameter : a  String represents the AccountHash object
       - Returns: AccountHash object
       */

    public static func fromStrToHash(from:String) -> AccountHash {
        let ret:AccountHash = AccountHash();
        ret.value = from;
        return ret;
    }
}
