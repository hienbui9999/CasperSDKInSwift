import Foundation

public class TransferAddr {
    public var value:String = ""
    public static func fromStrToTranferAddr(from:String) -> TransferAddr {
        let trans:TransferAddr = TransferAddr();
        trans.value = from
        return trans
    }
}
