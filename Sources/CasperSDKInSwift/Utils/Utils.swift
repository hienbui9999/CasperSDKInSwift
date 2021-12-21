//
//  Utils.swift
//  SampleRPCCall1
//
//  Created by Hien on 11/12/2021.
//

import Foundation
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
enum DictionaryIdentifier {
    case AccountNamedKey
    case  ContractNamedKey
    case URef
    case Dictionary
}
class Utils {
    func hand_request(url:String,method:String){
        let parameters = ["id": 1, "method": method,"params":"[]","jsonrpc":"2.0"] as [String : Any]
            //create the url with URL
            let url = URL(string: url)! //change the url
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
                       // return json;
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            })
            task.resume()
    }
}
