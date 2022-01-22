import Foundation

public class URef {
    let UREF_PREFIX:String = "uref"
    public var value:String?
    public static func fromStringToUref(from:String)->URef {
        let uref:URef = URef();
        uref.value = from;
        return uref;
    }
}
