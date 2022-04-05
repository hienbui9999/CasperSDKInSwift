import Foundation

/**
 Class represents the PublicKey
 */
public class PublicKey {
    /// The value of public key  in string
    public var value: String=""
    /**
       Build PublicKey object from string
       - Parameter :  a  String represents the PublicKey object
       - Returns:  PublicKey object
       */

    public static func strToPublicKey(from: String) -> PublicKey {
        let ret: PublicKey = PublicKey()
        ret.value = from
        return ret
    }

}
