import Foundation
/**
 Class represents the TransferAddr
 */

public class TransferAddr {
    public var value:String = ""
    /**
        Get TransferAddr object from Json string
        - Parameter : a Json String represents the TransferAddr object
        - Returns: TransferAddr object
        */

    public static func fromStrToTranferAddr(from:String) -> TransferAddr {
        let trans:TransferAddr = TransferAddr();
        trans.value = from
        return trans
    }
}
