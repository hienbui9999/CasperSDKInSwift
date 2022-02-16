import Foundation
/**
 Class represents the BlockHash
 */
public class BlockHash {
    public var value:String?
    public let ACCOUNT_PREFIX:String=""
    /**
       Build BlockHash object from string
       - Parameter : a  String represents the BlockHash object
       - Returns: BlockHash object
       */
    public static func fromStrToHash(from:String) -> BlockHash {
        let ret:BlockHash = BlockHash();
        ret.value = from;
        return ret;
    }
}
