import Foundation
//

/*
 pub enum DictionaryIdentifier {
     AccountNamedKey {
         key: String,
         dictionary_name: String,
         dictionary_item_key: String,
     },
     ContractNamedKey {
         key: String,
         dictionary_name: String,
         dictionary_item_key: String,
     },
     URef {
         seed_uref: String,
         dictionary_item_key: String,
     },
     Dictionary(String),
 }
 */
//
public enum DictionaryIdentifier : Codable {
    case AccountNamedKey(key:String,dictionary_name:String,dictionary_item_key:String)
   // case AccountNamedKey(ank:AccountNamedKeyObj)
    case ContractNamedKey(key:String,dictionary_name:String,dictionary_item_key:String)
    case URef(seed_uref:String,dictionary_item_key:String)
    case Dictionary(String)
}

/*public struct DictionaryIdentifierContainer:Codable {
    var AccountNamedKey:AccountNamedKeyObj!
    var state_root_hash:String!
    public static func toJson(input:DictionaryIdentifierContainer)->String {
        var json = ""
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        do {
            let jsonData = try jsonEncoder.encode(input)
            json = String(data:jsonData,encoding: String.Encoding.utf8)!
            print("DictionaryIdentifierContainer json:\(json)")
        } catch {
            
        }
        return json
    }
}*/
/*public struct AccountNamedKeyObj:Codable {
    var key:String!
    var dictionary_name:String!
    var dictionary_item_key:String!
    public static func toJson(input:AccountNamedKeyObj)-> String {
        var json = ""
        let jsonEncoder = JSONEncoder()
        //jsonEncoder.outputFormatting = .prettyPrinted
        do {
            let jsonData = try jsonEncoder.encode(input)
            json = String(data:jsonData,encoding: String.Encoding.utf8)!
        } catch {
            
        }
        return json
    }
}*/
public class DictionaryIdentifierHelper {
    public static func fromDictionaryIdentifierToJson(input:DictionaryIdentifier)->AnyObject {
        switch input {
       /* case .AccountNamedKey(let key, let dictionary_name, let dictionary_item_key):
            let listValue:[String:Any] = ["key":key,"dictionary_name":dictionary_name,"dictionary_item_key":dictionary_item_key]
            return ["AccountNamedKey":listValue] as! AnyObject
            break;*/
        case .AccountNamedKey(let ank):
            /*let listValue:[String:Any] = ["key":ank.key!,"dictionary_name":ank.dictionary_name!,"dictionary_item_key":ank.dictionary_item_key!]
            let ret : [String:Any] = ["AccountNamedKey":listValue]
            print("Ret:\(ret)")
            return ret as! AnyObject
            break;*/
            //let json = AccountNamedKeyObj.toJson(input: ank)
            //var json = JSONSerializer.toJson(ank)
           // print("json:\(json)")
            //return json as AnyObject
            break;
        default:
            break;
        }
        return ["a":"b"] as! AnyObject
    }
}
/*
public class AccountNamedKey:Codable {
    public var key:String?
    public var dictionary_name:String?
    public var dictionary_item_key:String?
}
*/
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
            print("Error:\(error)")
        }
        return Data()
    }
}
