
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
    public static func fromBlockIdentifierToJsonData(input:BlockIdentifier,method:CasperMethodCall) -> Data {
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
        
    }
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
    public static func fromBlockIdentifierToJsonData2(input:BlockIdentifier,method:CasperMethodCall)->Data {
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
            print("Error:\(error)")
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
            print("Error:\(error)")
        }
        return Data()
    }
    public static func fromGetBalanceParamsToJson(input:GetBalanceParams)->[String] {
        var retJson:[String] = [String]()
        //let param1 = ["state_root_hash":input.state_root_hash] as [String:Any]
       // let param2 = ["purse_uref":input.purse_uref] as [String:Any]
        retJson.append(input.state_root_hash)
        retJson.append(input.purse_uref)
        return retJson
    }
    /* public static func toJson3()->String {
         let g:GetDictionaryItemParams2 = GetDictionaryItemParams2()
         var ank:AccountNamedKey = AccountNamedKey();
         var ankC:AccountNamedKeyContainer = AccountNamedKeyContainer();
         ank.key = "account-hash-ad7e091267d82c3b9ed1987cb780a005a550e6b3d1ca333b743e2dba70680877"
         ank.dictionary_name = "dict_name"
         ank.dictionary_item_key = "abc_name"
         g.state_root_hash = "146b860f82359ced6e801cbad31015b5a9f9eb147ab2a449fd5cdb950e961ca8";
         ankC.AccountNamedKey = ank
         g.dictionary_identifier = ankC
         let encode = JSONEncoder()
         encode.outputFormatting = .prettyPrinted
         let data = try! encode.encode(g)
         
         print(String(data: data, encoding: .utf8)!)
         var retStr = String(data:data,encoding: .utf8)!
         retStr = retStr.replacingOccurrences(of: "\\", with: "", options: NSString.CompareOptions.literal, range: nil)
         retStr = retStr.replacingOccurrences(of: "\\n", with: "", options: NSString.CompareOptions.literal, range: nil)
         print("------retStr:\(retStr)")
         return retStr
     }*/
}
