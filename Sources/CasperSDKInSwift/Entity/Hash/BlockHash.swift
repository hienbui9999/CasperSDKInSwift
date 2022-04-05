import Foundation
/**
 Class represents the BlockHash
 */
public class BlockHash {
    /// The value of block hash in string
    public var value: String?
    /// The prefix for block hash
    public let blockHasPrefix: String=""
    /**
       Build BlockHash object from string
       - Parameter :  a  String represents the BlockHash object
       - Returns:  BlockHash object
       */

    public static func fromStrToHash(from: String) -> BlockHash {
        let ret: BlockHash = BlockHash()
        ret.value = from
        return ret
    }

}
