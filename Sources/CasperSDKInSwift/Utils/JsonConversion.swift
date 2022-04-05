import Foundation
public class AccountNamedKey: Codable {
    var key: String!
    var dictionaryName: String!
    var dictionaryItemKey: String!
}
public class AccountNamedKeyContainer: Codable {
    public var accountNamedKey: AccountNamedKey!
}
public class GetDictionaryItemParams2: Codable {
    public var stateRootHash: String!
    public var dictionaryIdentifier: AccountNamedKeyContainer!
}
public class JsonParam: Codable {
    var jsonrpc: String!
    var id: Int32!
    var method: String!
    var params: GetDictionaryItemParams!
}
public class JsonParam2: Codable {
    var jsonrpc: String!
    var id: Int32!
    var method: String!
    var params: GetDictionaryItemParams2!
}
public class JsonConversion {
    /**
        Function to get  json data from GetItemParams object
       - Parameter: GetItemParams object
       - Returns: json data representing the GetItemParams object
     */

    public static func fromGetStateItemToJsonData(input: GetItemParams) -> Data {
        var retJson: [Any]=[Any]()
        retJson.append(input.stateRootHash!)
        retJson.append(input.key!)
        if input.path?.isEmpty != nil {
            var paths: [String] = [String]()
            for onePath in input.path! {
                paths.append(onePath)
            }
            retJson.append(paths)
        }
        let obj: [String: Any] = ["jsonrpc": casperRpcVersion, "id": casperId, "method": "state_get_item", "params": retJson]
        let encode = JSONEncoder()
        encode.outputFormatting = .prettyPrinted
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
            return jsonData
        }
        catch {
            NSLog("Error: \(error)")
        }
        return Data()
    }
    /**
        Function to get  json data from GetItemParams object
       - Parameter: GetItemParams object
       - Returns: json data representing the GetItemParams object
     */

    public static func fromGetStateItemToJsonStr1(input: GetItemParams) -> [Any] {
        var retJson: [Any]=[Any]()
        retJson.append(input.stateRootHash!)
        retJson.append(input.key!)
        if input.path?.isEmpty != nil {
            var paths: [String] = [String]()
            for onePath in input.path! {
                paths.append(onePath)
            }
            retJson.append(paths)
        }
        return retJson
    }

    public static func generatePostDataNoParam(method: CasperMethodCall) -> Data {
        let  obj: [String: Any] = ["jsonrpc": casperRpcVersion, "id": casperId, "method": method.rawValue, "params": "[]"]
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

    public static func fromBlockIdentifierToJsonData(input: BlockIdentifier, method: CasperMethodCall) -> Data {
        var objParams: [String: Any]?
        var obj: [String: Any]!
        switch input{
        case .hash(let hash):
            objParams =  ["block_identifier": ["Hash": hash]]
            obj = ["jsonrpc": casperRpcVersion, "id": casperId, "method": method.rawValue, "params": objParams as Any]
                break
        case .height(let height):
            objParams =  ["block_identifier": ["Height": height]]
            obj = ["jsonrpc": casperRpcVersion, "id": casperId, "method": method.rawValue, "params": objParams as Any]
                break
        case .none:
            obj = ["jsonrpc": casperRpcVersion, "id": casperId, "method": method.rawValue, "params": "[]"]
                break
        }
        let encode = JSONEncoder()
        encode.outputFormatting = .prettyPrinted
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: obj as Any, options: .prettyPrinted)
            // let convertedString: String = String(data: jsonData, encoding: String.Encoding.utf8) ?? ""
           // print("converedString: \(convertedString)")
            return jsonData
        }
        catch {
            NSLog("Error: \(error)")
        }
        return Data()
    }

    public static func fromBlockIdentifierToJson(input: BlockIdentifier) -> [[String: Any]] {
        var retStr: [[String: Any]]?
        switch input{
        case .hash(let hash):
            retStr =  [["Hash": hash]] as [[String: Any]]
                break
        case .height(let height):
            retStr =  [["Height": height]] as [[String: Any]]
                break
        case .none:
                retStr =  [["None": ""]] as [[String: Any]]
                break
        }
        return retStr!
    }

    public static func fromGetBalanceParamsToJsonData(input: GetBalanceParams) -> Data {
        var retJson: [String] = [String]()
        retJson.append(input.stateRootHash)
        retJson.append(input.purseUref)
        let obj: [String: Any] = ["jsonrpc": casperRpcVersion, "id": casperId, "method": "state_get_balance", "params": retJson]
        let encode = JSONEncoder()
        encode.outputFormatting = .prettyPrinted
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
            return jsonData
        }
        catch {
            NSLog("Error: \(error)")
        }
        return Data()
    }

    public static func fromGetBalanceParamsToJson(input: GetBalanceParams) -> [String] {
        var retJson: [String] = [String]()
        retJson.append(input.stateRootHash)
        retJson.append(input.purseUref)
        return retJson
    }

}
