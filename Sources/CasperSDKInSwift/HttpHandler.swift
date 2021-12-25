//
//  File.swift
//  
//
//  Created by Hien on 22/12/2021.
//

import Foundation
//THIS SHOULD BE COMMENT LATER
let CASPER_ID : Int32 = 1;
//let methodURL:String = "http://65.21.227.180:7777/rpc";
struct BlockIdentifier : Codable{
    var Height:UInt64 = 1;
}
struct RequestParams : Codable {
    var id:Int = 1;
    var method:String = "chain_get_state_root_hash"
    var jsonprc:String = "2.0"
    var params:[BlockIdentifier]=[BlockIdentifier]();
}
class HttpHandler {
    static var methodURL:String = "http://65.21.227.180";
    @available(iOS 15.0.0, *)
    public static func handleRequest(method:String,params:Any) async throws->[String:Any] {
       // print("Param in HTTP_HANDLER-----:\(params)")
       // HttpHandler.methodURL = "https://node-clarity-testnet.make.services/rpc"
        guard let url = URL(string: HttpHandler.methodURL) else {
            throw CasperMethodError.invalidURL
        }
        let json2: [String: Any] = ["id": CASPER_ID, "method": method,"jsonrpc":"2.0","params":params] as [String:Any]
        //print("parameters json 2:\(json2)")
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: json2, options: .prettyPrinted)
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
           // print("HTTP REQUEST CALLED, databack error:\(error)")
            throw CasperMethodError.invalidURL
        }
        throw CasperMethodError.invalidURL
    }
    @available(iOS 15.0.0, *)
    static func handleRequest2(calling_method:String) async throws->[String:Any] {
        guard let url = URL(string: methodURL) else {
            throw GetStateRootHashError.invalidURL
        }
        let parameters = ["id": CASPER_ID, "method": calling_method,"jsonrpc":"2.0","params":"[]"] as [String : Any]
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
            throw CasperMethodError.methodNotFound
        }
        throw CasperMethodError.parseError
    }
}
