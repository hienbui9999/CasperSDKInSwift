//
//  File.swift
//  
//
//  Created by Hien on 22/12/2021.
//

import Foundation
class HttpHandler {
    @available(iOS 15.0.0, *)
    static func handleRequest(method:String) async throws->[String:Any] {
        guard let url = URL(string: methodURL) else {
            throw GetStateRootHashError.invalidURL
        }
        let parameters = ["id": CASPER_ID, "method": method,"jsonrpc":"2.0","params":"[]"] as [String : Any]
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
