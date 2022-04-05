import Foundation

/**
Class supports the getting of GetDictionaryItemResult from Json String
*/

class GetDictionaryItemResult {
    public var apiVersion: String!
    public var dictionaryKey: String!
    public var storedValue: StoredValue!
    public var merkleProof: String!
    /**
        Get GetDictionaryItemResult object from Json string
        - Parameter : a Json string represents the GetDictionaryItemResult object
        - Throws: CasperMethodCallError.CasperError with code and message according to the error returned by the Casper system
        - Returns: GetDictionaryItemResult object
        */

    public static func getResult(from: [String: Any]) throws -> GetDictionaryItemResult {
        do {
            if let error = from["error"] as AnyObject? {
                var code: Int!
                var message: String!
                if let code1 = error["code"] as? Int {
                    code = code1
                }
                if let message1 = error["message"] as? String {
                    message = message1
                }
                throw CasperMethodCallError.casperError(code: code, message: message, methodCall: "state_get_dictionary_item")
            }
            let ret: GetDictionaryItemResult = GetDictionaryItemResult()
            if let result = from["result"] as? [String: Any] {
                if let apiVersion1 = result["api_version"] as? String {
                    ret.apiVersion = apiVersion1
                }
                if let dictionaryKey1 = result["dictionary_key"] as? String {
                    ret.dictionaryKey = dictionaryKey1
                }
                if let merkleProof1 = result["merkle_proof"] as? String {
                    ret.merkleProof = merkleProof1
                }
                if let storedValue1 = result["stored_value"] as? [String: Any] {
                    ret.storedValue = StoredValueHelper.getStoredValue(from: storedValue1)
                }
            }
            return ret
        } catch {
            throw error
        }
    }

}
