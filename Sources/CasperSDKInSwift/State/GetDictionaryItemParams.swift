import Foundation

/**
 Enumeration type represents the DictionaryIdentifier
 */
public enum DictionaryIdentifier: Codable {
    case accountNamedKey(key: String, dictionary_name: String, dictionary_item_key: String)
    case contractNamedKey(key: String, dictionary_name: String, dictionary_item_key: String)
    case uRef(seed_uref: String, dictionary_item_key: String)
    case dictionary(String)
}
/**
 Class represents the GetDictionaryItemParams, used for sending parameter when call state_get_dictionary_item RPC method
 */

public class GetDictionaryItemParams: Codable {
    /// The state root hash value
    var stateRootHash: String!
    /// DictionaryIdentifier value, which can be 1 among the 4 type of value declared in the DictionaryIdentifier enumeration: AccountNamedKey, ContractNamedKey, URef, Dictionary
    var dictionaryIdentifier: DictionaryIdentifier!
    /**
        Get Data parameter  from DictionaryIdentifier object, used for sending POST method when call for state_get_dictionary_item RPC method
        - Parameter : none
        - Throws: Json serialization error
        - Returns:  Data parameter  from DictionaryIdentifier object
        */

    public func toJsonData()throws -> Data {
        var dicObj: [String: Any] = [: ]
        switch dictionaryIdentifier {
        case .accountNamedKey(let key, let dictionaryName, let dictionaryItemKey):
            let obj: [String: Any] = ["key": key, "dictionary_name": dictionaryName, "dictionary_item_key": dictionaryItemKey]
            dicObj = ["AccountNamedKey": obj]
            break
        case .contractNamedKey(let key, let dictionaryName, let dictionaryItemKey):
            let obj: [String: Any] = ["key": key, "dictionary_name": dictionaryName, "dictionary_item_key": dictionaryItemKey]
            dicObj = ["ContractNamedKey": obj]
            break
        case .uRef(let seedUref, let dictionaryItemKey):
            let obj: [String: Any] = ["seed_uref": seedUref, "dictionary_item_key": dictionaryItemKey]
            dicObj = ["URef": obj]
            break
        case .dictionary(let string):
            dicObj = ["Dictionary": string]
            break
        default:
            break
        }
        let objParam: [String: Any] = ["state_root_hash": stateRootHash!, "dictionary_identifier": dicObj]
        let obj: [String: Any] = ["jsonrpc": "2.0", "id": 1, "method": "state_get_dictionary_item", "params": objParam]
        let encode = JSONEncoder()
        encode.outputFormatting = .prettyPrinted
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
            return jsonData
        }
        catch {
            NSLog("Error: \(error)")
            throw error
        }
    }

}
