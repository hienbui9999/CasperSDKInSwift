import Foundation

public enum DictionaryIdentifier : Codable {
    case AccountNamedKey(key:String,dictionary_name:String,dictionary_item_key:String)
    case ContractNamedKey(key:String,dictionary_name:String,dictionary_item_key:String)
    case URef(seed_uref:String,dictionary_item_key:String)
    case Dictionary(String)
}

public class GetDictionaryItemParams : Codable {
    var state_root_hash:String!;
    var dictionary_identifier: DictionaryIdentifier!;
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
    
        let objParam:[String:Any] = ["state_root_hash":"146b860f82359ced6e801cbad31015b5a9f9eb147ab2a449fd5cdb950e961ca8","dictionary_identifier":dicObj]
        let obj:[String:Any] = ["jsonrpc":"2.0","id":1,"method":"state_get_dictionary_item","params":objParam]
        let encode = JSONEncoder()
        encode.outputFormatting = .prettyPrinted
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
            return jsonData
        }
        catch {
            NSLog("Error:\(error)")
        }
        return Data()
    }
}
