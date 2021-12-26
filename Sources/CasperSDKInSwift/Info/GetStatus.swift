//
//  GetStatus.swift
//  SampleRPCCall1
//
//  Created by Hien on 09/12/2021.
//
//https://docs.rs/casper-node/latest/casper_node/rpcs/info/struct.GetStatus.html
//INFO BACK LIKE THIS
/*
 ["jsonrpc": 2.0, "result": {
     "api_version" = "1.4.3";
     "build_version" = "1.4.3-a44bed1fd-casper-mainnet";
     "chainspec_name" = "casper-test";
     "last_added_block_info" =     {
         creator = 0196948158bF5b35C0c84F680F110B8dEbAA4e7628E13ba336a95651a214d3B9BD;
         "era_id" = 2947;
         hash = 328D7b791A392BAfe29353ff9c1ade752F34666B742B658d85cEfdFADe283E2D;
         height = 365842;
         "state_root_hash" = fd0C93320429C0212B45E9796Adc2Da5354514460B289FbE7427fa6D77863Cc0;
         timestamp = "2021-12-11T03:53:40.608Z";
     };
     "next_upgrade" = "<null>";
     "our_public_signing_key" = 01cd807fb41345d8dD5A61da7991e1468173acbEE53920E4DFe0D28Cb8825AC664;
     peers =     (
                 {
             address = "89.163.227.185:35000";
             "node_id" = "tls:006b..1551";
         },
                 {
             address = "18.163.249.168:35000";
             "node_id" = "tls:0097..b253";
         },
 ....
 
 {
address = "93.186.201.14:35000";
"node_id" = "tls:ff95..c014";
},
 {
address = "198.244.179.16:35000";
"node_id" = "tls:ffdb..7c9e";
}
);
"round_length" = "32s 768ms";
"starting_state_root_hash" = E2218B6BdB8137A178f242E9DE24ef5Db06af7925E8E4C65Fa82D41Df38F4576;
uptime = "14h 8m 48s 929ms";
}, "id": 1]
 
 */
import Foundation
struct GetStatus:RpcWithoutParams,RpcWithoutParamsExt {
    let methodStr : String = "info_get_status"
    let methodURL : String = "http://65.21.227.180:7777/rpc"
    public func getStatus() async throws ->GetStatusResult {
        do {
            let statusResult = try await HttpHandler.handleRequest(method: methodStr, params: "[]")
            print("getStatus back:\(statusResult)")
            let ret:GetStatusResult = GetStatusResult();
            return ret
        } catch {
            throw error
        }
    }
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
