import Foundation

/**
Class supports the getting of GetDictionaryItemResult from Json String
*/

class GetDictionaryItemResult {
    public var api_version:String!
    public var dictionary_key:String!
    public var stored_value:StoredValue!
    public var merkle_proof:String!
    /**
        Get GetDictionaryItemResult object from Json string
        - Parameter : a Json string represents the GetDictionaryItemResult object
        - Throws: CasperMethodCallError.CasperError with code and message according to the error returned by the Casper system
        - Returns: GetDictionaryItemResult object
        */

    public static func getResult(from:[String:Any]) throws -> GetDictionaryItemResult {
        do {
            if let error = from["error"] as AnyObject? {
                var code:Int!
                var message:String!
                if let code1 = error["code"] as? Int {
                    code = code1
                }
                if let message1 = error["message"] as? String {
                    message = message1
                }
                throw CasperMethodCallError.CasperError(code: code, message: message,methodCall: "state_get_dictionary_item")
            }
            let ret:GetDictionaryItemResult = GetDictionaryItemResult()
            if let result = from["result"] as? [String:Any] {
                if let api_version = result["api_version"] as? String {
                    ret.api_version = api_version
                }
                if let dictionary_key = result["dictionary_key"] as? String {
                    ret.dictionary_key = dictionary_key
                }
                if let merkle_proof = result["merkle_proof"] as? String {
                    ret.merkle_proof = merkle_proof
                }
                if let stored_value = result["stored_value"] as? [String:Any] {
                    ret.stored_value = StoredValueHelper.getStoredValue(from: stored_value)
                }
            }
            return ret
        } catch {
            throw error
        }
    }
}
