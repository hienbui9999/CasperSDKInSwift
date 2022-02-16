import Foundation

/**
 Enumeration type represents the DictionaryIdentifier
 */
public enum DictionaryIdentifier : Codable {
    case AccountNamedKey(key:String,dictionary_name:String,dictionary_item_key:String)
    case ContractNamedKey(key:String,dictionary_name:String,dictionary_item_key:String)
    case URef(seed_uref:String,dictionary_item_key:String)
    case Dictionary(String)
}
/**
 Class represents the GetDictionaryItemParams, used for sending parameter when call state_get_dictionary_item RPC method
 */

public class GetDictionaryItemParams : Codable {
    ///The state root hash value
    var state_root_hash:String!;
    ///DictionaryIdentifier value, which can be 1 among the 4 type of value declared in the DictionaryIdentifier enumeration: AccountNamedKey, ContractNamedKey, URef, Dictionary
    var dictionary_identifier: DictionaryIdentifier!;
    /**
        Get Data parameter  from DictionaryIdentifier object, used for sending POST method when call for state_get_dictionary_item RPC method
        - Parameter : none
        - Throws: Json serialization error
        - Returns:  Data parameter  from DictionaryIdentifier object
        */

    public func toJsonData()throws -> Data {
        var dicObj:[String:Any] = [:]
        switch dictionary_identifier {
        case .AccountNamedKey(let key, let dictionary_name, let dictionary_item_key):
            let obj:[String:Any] = ["key":key,"dictionary_name":dictionary_name,"dictionary_item_key":dictionary_item_key]
            dicObj = ["AccountNamedKey":obj]
            break
        case .ContractNamedKey(let key, let dictionary_name, let dictionary_item_key):
            let obj :[String:Any] = ["key":key,"dictionary_name":dictionary_name,"dictionary_item_key":dictionary_item_key]
            dicObj = ["ContractNamedKey":obj]
            break
        case .URef(let seed_uref, let dictionary_item_key):
            let obj:[String:Any] = ["seed_uref":seed_uref,"dictionary_item_key":dictionary_item_key]
            dicObj = ["URef":obj]
            break
        case .Dictionary(let string):
            dicObj = ["Dictionary":string]
            break
        default:
            break
        }
    
        let objParam:[String:Any] = ["state_root_hash":state_root_hash!,"dictionary_identifier":dicObj]
        let obj:[String:Any] = ["jsonrpc":"2.0","id":1,"method":"state_get_dictionary_item","params":objParam]
        let encode = JSONEncoder()
        encode.outputFormatting = .prettyPrinted
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
            return jsonData
        }
        catch {
            NSLog("Error:\(error)")
            throw error
        }
    }
}
