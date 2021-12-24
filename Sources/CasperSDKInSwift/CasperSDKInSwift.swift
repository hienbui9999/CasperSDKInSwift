
import Foundation

//let CASPER_ID : Int32 = 1;
//let methodURL:String = "http://65.21.227.180:7777/rpc";

enum GetStateRootHashError: Error {
    case invalidURL
    case parseError
    case methodNotFound
}
enum CasperMethodError:Error {
    case invalidURL
    case parseError
    case methodNotFound
    case unknown
    case getDataBackError
}

public class CasperSDKInSwift {
    //public private(set) var text = "Hello, World!"
    
    let CASPER_ID : Int32 = 1;
    var methodURL:String = "http://65.21.227.180:7777/rpc";
    public func setMethodUrl(url:String) {
        methodURL = url;
    }
    public init() {
    }
    @available(iOS 15.0.0, *)
    public func getStateRootHashExtends(blockHash:String = "") async throws->String {
        let methodStr : String = "chain_get_state_root_hash";
        do {
            var params = "[]"
            if blockHash != "" {
                params = "[\"block_hash\":\"\(blockHash)\"]"
            }
            let json = try await handleRequestExtends(method:methodStr,params: params);
            //print("json back:\(json)")
            if let error = json["error"] as? AnyObject {
                if let code = error["code"] as? Int32 {
                    print("error code:\(code)")
                    if code == -32700 {
                        throw GetStateRootHashError.parseError;
                    } else if code == -32601 {
                        throw GetStateRootHashError.methodNotFound
                    }
                }
                if let message = error["message"] as? String {
                    print("message:\(message)")
                } else {
                    //print("Can not show message in error")
                }
            }
            if let result = json["result"] as? AnyObject {
                if let api_version = result["api_version"] as? String {
                   // print("----IN ASYNC Api_version:\(api_version)")
                } else {
                  //  print("Can not get api_version in result")
                }
                if let state_root_hash = result["state_root_hash"] as? String{
                  //  print("-----IN ASYNC stateRootHash:\(state_root_hash)")
                    return state_root_hash
                } else {
                 //   print("Error get state root hash")
                    throw GetStateRootHashError.parseError
                }
            } else {
                //print("error get json result")
                throw GetStateRootHashError.parseError
            }
        } catch {
            //print("ERROR GET STATE ROOT HASH 2")
            throw CasperMethodError.invalidURL
        }
        throw CasperMethodError.unknown
    }
    @available(iOS 15.0.0, *)
    public func handleRequestExtends(method:String,params:String="[]") async throws->[String:Any] {
      //  print("Param:\(params)")
        guard let url = URL(string: methodURL) else {
            print("ERROR URL")
            throw CasperMethodError.invalidURL
        }
        let parameters = ["id": CASPER_ID, "method": method,"jsonrpc":"2.0","params":params] as [String : Any]
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
            }
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
        let (data, _) = try await URLSession.shared.data(for:request)
        do {
            //create json object from data
            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                 return json
            }
        } catch {
            throw CasperMethodError.getDataBackError
        }
        throw CasperMethodError.getDataBackError
    }
    @available(iOS 15.0.0, *)
    public func getPeers() async throws -> GetPeersResult {
        let getPeers:GetPeers = GetPeers();
        do {
            let getPeersResult = try  await  getPeers.getPeers2()
            return getPeersResult;
        } catch {
            print("Error")
            throw CasperMethodError.invalidURL;
        }
    }
    
}
