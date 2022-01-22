import Foundation

public class Bytes {
    public var value:String = ""
    public static func fromStrToBytes(from:String) -> Bytes {
        let ret:Bytes = Bytes();
        ret.value = from
        return ret
    }
}
