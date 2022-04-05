import Foundation
/**
 Class represents the AccountHash
 */

public class AccountHash {
    /// The value of account hash in string
    public var value: String?
    /// Prefix of the account hash
    public let accountPrefix: String="account-hash-"
    /**
       Build AccountHash object from string
       - Parameter :  a  String represents the AccountHash object
       - Returns:  AccountHash object
       */

    public static func fromStrToHash(from: String) -> AccountHash {
        let ret: AccountHash = AccountHash()
        ret.value = from
        return ret
    }

}
