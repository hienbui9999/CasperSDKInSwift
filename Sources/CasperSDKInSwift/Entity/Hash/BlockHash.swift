import Foundation

public class BlockHash {
    public var value:String?
    public let ACCOUNT_PREFIX:String=""
    
    public static func fromStrToHash(from:String) -> BlockHash {
        let ret:BlockHash = BlockHash();
        ret.value = from;
        return ret;
    }
}
