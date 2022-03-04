import Foundation
/**
 Enumeration type represents the ErrorCode, which takes two type of value
 - REAL_ERROR: if the error does occur
 - NONE: if no error appear at all
 */
public enum ErrorCode:Error {
    case REAL_ERROR(Int,String)
    case NONE
}
/**
 Class represents the ErrorHandler. This class is used when call RPC methods to handle error.
 */

public class ErrorHandler {
    /**
       Get ErrorCode object from Json string
       - Parameter : a Json String represents the ErrorCode object
       - Returns: ErrorCode object
       */

    public static func getError(from:[String:Any]) -> ErrorCode {

        if let result = from["error"] as? [String:Any] {
            var errorCode:Int?
            var errorMessage:String?
            if let code = result["code"] as? Int {
               errorCode = code
            }
            if let message = result["message"] as? String {
                errorMessage = message
            }
            return .REAL_ERROR(errorCode!, errorMessage!)
        }
        return .NONE
    }
}
