//
//  GetItem.swift
//  SampleRPCCall1
//
//  Created by Hien on 11/12/2021.
//https://docs.rs/casper-node/latest/casper_node/rpcs/state/struct.GetItem.html

//DATA BACK
/*
 ["id": 1, "jsonrpc": 2.0, "error": {
     code = "-32602";
     data = "<null>";
     message = "Invalid params";
 }]
*/

import Foundation
class GetItem {
    let methodStr : String = "state_get_item"
    let methodURL : String = "http://65.21.227.180:7777/rpc"
    func handle_request () {
        //var ret : GetPeersResult = GetPeersResult();
        let parameters = ["id": 1, "method": methodStr,"params":"[]","jsonrpc":"2.0"] as [String : Any]
            //create the url with URL
            let url = URL(string: methodURL)! //change the url
//create the session object
            let session = URLSession.shared
   //now create the URLRequest object using the url object
            var request = URLRequest(url: url)
            request.httpMethod = "POST" //set http method as POST
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            } catch let error {
                print(error.localizedDescription)
            }
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            request.addValue("application/json", forHTTPHeaderField: "Accept")
    
//create dataTask using the session object to send data to the server

            let task = session.dataTask(with: request as URLRequest, completionHandler: {
                data, response, error in
                    guard error == nil else {
                    return
                }
                guard let data = data else {
                    return
                }
                do {
                    //create json object from data
                    if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                        print("JSON BACK:\(json)")
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            })
            task.resume()
       // return ret;
    }
}
