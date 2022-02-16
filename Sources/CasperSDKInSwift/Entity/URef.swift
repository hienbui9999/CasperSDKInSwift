import Foundation
/**
 Class represents the URef
 */
 

public class URef {
    let UREF_PREFIX:String = "uref"
    public var value:String?
    /**
       Get URef object from  string
       - Parameter : a  String represents the URef object
       - Returns: URef object
       */

    public static func fromStringToUref(from:String)->URef {
        let uref:URef = URef();
        uref.value = from;
        return uref;
    }
}
