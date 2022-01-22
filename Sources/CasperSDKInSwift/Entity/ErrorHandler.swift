import Foundation
public enum ErrorCode:Error {
    case REAL_ERROR(Int,String)
    case NONE
}
public class ErrorHandler {
    public static func getError2(from:[String:Any]) -> ErrorCode {
        print("get error from:\(from)")
        var ret:ErrorCode = .NONE
        if let result = from["error"] as? [String:Any] {
            print("Result:\(result)")
            var errorCode:Int?
            var errorMessage:String?
            if let code = result["code"] as? Int {
               errorCode = code
            }
            if let data = result["data"] as? String {
                
            }
            if let message = result["message"] as? String {
                errorMessage = message
            }
            return .REAL_ERROR(errorCode!, errorMessage!)
        }
        return .NONE
    }
    public static func getError(from:[String:Any]) -> CasperMethodError {
        print("get error from:\(from)")
        if let result = from["error"] as? [String:Any] {
            print("Result:\(result)")
            if let code = result["code"] as? Int {
                if code == -32005 {
                    return CasperMethodError.parseError
                } else if code == -32602 {
                    return CasperMethodError.invalidParams
                } else if code == -32001 {
                    return CasperMethodError.invalidParams
                }
            }
            if let data = result["data"] as? String {
                
            }
            if let message = result["message"] as? String {
                
            }
        }
        return CasperMethodError.NONE
    }
}
