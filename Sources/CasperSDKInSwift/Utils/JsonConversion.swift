
import Foundation
public class AccountNamedKey:Codable {
    var key:String!
    var dictionary_name:String!
    var dictionary_item_key:String!
}
public class AccountNamedKeyContainer:Codable {
    public var AccountNamedKey: AccountNamedKey!
}
public class GetDictionaryItemParams2:Codable {
    public var state_root_hash:String!
    public var dictionary_identifier:AccountNamedKeyContainer!
}
public class JsonParam : Codable {
    var jsonrpc:String!
    var id:Int32!
    var method:String!
    var params: GetDictionaryItemParams!
}
public class JsonParam2 : Codable {
    var jsonrpc:String!
    var id:Int32!
    var method:String!
    var params: GetDictionaryItemParams2!
}
public class JsonConversion {
    /*public static func fromDictionaryItemToJsonStr(input:GetDictionaryItemParams) -> AnyObject {
        let diJson = DictionaryIdentifierHelper.fromDictionaryIdentifierToJson(input: input.dictionary_identifier!) as AnyObject
        let adiJson : [String:Any] = ["AccountNamedKey":diJson]
        let adiJson2 = adiJson as AnyObject
        let params:[String:Any] = ["state_root_hash" : input.state_root_hash!,"dictionary_identifier" : adiJson as AnyObject];
        return params as AnyObject;
    }*/
    public static func fromGetStateItemToJsonData(input:GetItemParams) -> Data {
        var retJson:[Any]=[Any]();
        retJson.append(input.state_root_hash!)
        retJson.append(input.key!)
        if input.path?.isEmpty != nil {
            var paths:[String] = [String]();
            for onePath in input.path! {
                paths.append(onePath)
            }
            retJson.append(paths)
        }
        
        let obj:[String:Any] = ["jsonrpc":CASPER_RPC_VERSION,"id":CASPER_ID,"method":"state_get_item","params":retJson]
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
    public static func fromGetStateItemToJsonStr(input:GetItemParams) ->[Any] {
        var retJson:[Any]=[Any]();
        retJson.append(input.state_root_hash!)
        retJson.append(input.key!)
        if input.path?.isEmpty != nil {
            var paths:[String] = [String]();
            for onePath in input.path! {
                paths.append(onePath)
            }
            retJson.append(paths)
        }
        return retJson
       
    }
    /*public static func fromBlockIdentifierToJsonData(input:BlockIdentifier,method:CasperMethodCall) -> Data {
        var objParams:[[String:Any]]?;
        switch input{
        case .Hash(let hash):
            objParams =  [["Hash":hash]] as [[String:Any]];
                break;
        case .Height(let height):
            objParams =  [["Height":height]] as [[String:Any]];
                break;
        case .None:
                objParams =  [["None":""]] as [[String:Any]];
                break;
        }
        let objParam:[String:Any] = ["state_root_hash":"146b860f82359ced6e801cbad31015b5a9f9eb147ab2a449fd5cdb950e961ca8","dictionary_identifier":objParams]
        let obj:[String:Any] = ["jsonrpc":CASPER_RPC_VERSION,"id":CASPER_ID,"method":method.rawValue,"params":objParams]
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
        
    }*/
    public static func generatePostDataNoParam(method: CasperMethodCall) -> Data {
        let  obj:[String:Any] = ["jsonrpc":CASPER_RPC_VERSION,"id":CASPER_ID,"method":method.rawValue,"params":"[]"]
       let encode = JSONEncoder()
       encode.outputFormatting = .prettyPrinted
       do {
           let jsonData = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
           return jsonData
       }
       catch {
       }
        return Data()
    }
    public static func fromBlockIdentifierToJsonData(input:BlockIdentifier,method:CasperMethodCall)->Data {
        var objParams:[String:Any]?;
        var obj:[String:Any]!
        switch input{
        case .Hash(let hash):
            objParams =  ["block_identifier":["Hash":hash]];
            obj = ["jsonrpc":CASPER_RPC_VERSION,"id":CASPER_ID,"method":method.rawValue,"params":objParams]
                break;
        case .Height(let height):
            objParams =  ["block_identifier":["Height":height]];
            obj = ["jsonrpc":CASPER_RPC_VERSION,"id":CASPER_ID,"method":method.rawValue,"params":objParams]
                break;
        case .None:
            obj =  ["jsonrpc":CASPER_RPC_VERSION,"id":CASPER_ID,"method":method.rawValue,"params":"[]"]
                break;
        }
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
    public static func fromBlockIdentifierToJson(input:BlockIdentifier)->[[String:Any]] {
        var retStr:[[String:Any]]?;
        switch input{
        case .Hash(let hash):
            retStr =  [["Hash":hash]] as [[String:Any]];
                break;
        case .Height(let height):
            retStr =  [["Height":height]] as [[String:Any]];
                break;
        case .None:
                retStr =  [["None":""]] as [[String:Any]];
                break;
        }
        return retStr!;
    }
    public static func fromGetBalanceParamsToJsonData(input:GetBalanceParams)->Data{
        var retJson:[String] = [String]()
        retJson.append(input.state_root_hash)
        retJson.append(input.purse_uref)
        let obj:[String:Any] = ["jsonrpc":CASPER_RPC_VERSION,"id":CASPER_ID,"method":"state_get_balance","params":retJson]
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
    public static func fromGetBalanceParamsToJson(input:GetBalanceParams)->[String] {
        var retJson:[String] = [String]()
        retJson.append(input.state_root_hash)
        retJson.append(input.purse_uref)
        return retJson
    }
   
}
