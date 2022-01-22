import Foundation

public class AccountHash {
    public var value:String?
    public let ACCOUNT_PREFIX:String="account-hash-"
    
    public static func fromStrToHash(from:String) -> AccountHash {
        let ret:AccountHash = AccountHash();
        ret.value = from;
        return ret;
    }
}
