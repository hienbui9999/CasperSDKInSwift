//
//  GetBlockTransfers.swift
//  SampleRPCCall1
//
//  Created by Hien on 11/12/2021.
//
//https://docs.rs/casper-node/latest/casper_node/rpcs/chain/struct.GetBlockTransfers.html
//DATA BACK
/*
 ["jsonrpc": 2.0, "result": {
     "api_version" = "1.4.3";
     "block_hash" = 64177f7aD6944f3e85857D44FD4a97Ce7DB806F132bc7d4dbAbb29438401954c;
     transfers =     (
                 {
             amount = 10000000000;
             "deploy_hash" = 8Fd9Ba04Edda1B8C4681d8DBB58dE380643FF92924fe8803F87e5194d67D9fa2;
             from = "account-hash-0616191782F4cC2D97132cf580b96B269Ca7631343Ae2545a5cCF4490400eC4A";
             gas = 0;
             id = "<null>";
             source = "uref-F91063035c03eadD462c79Ca674C2B081E46008314589E27617aA24500bBe17c-007";
             target = "uref-CD22F82697FE9B3f92f8C0D47240496Fa035Ae1e161E38eCc00050b523A4B912-004";
             to = "account-hash-0616191782F4cC2D97132cf580b96B269Ca7631343Ae2545a5cCF4490400eC4A";
         },
                 {
             amount = 10000000000;
             "deploy_hash" = FF04d55A292Aa00644D8F65646F7bF6b317541Fde21058C89d71a681394895CD;
             from = "account-hash-0616191782F4cC2D97132cf580b96B269Ca7631343Ae2545a5cCF4490400eC4A";
             gas = 0;
             id = "<null>";
             source = "uref-CD22F82697FE9B3f92f8C0D47240496Fa035Ae1e161E38eCc00050b523A4B912-007";
             target = "uref-66c9B94777Ec761fD30884A63DC97F4A2701e30452F81ad0A55e70b3aaAcba81-007";
             to = "<null>";
         },
                 {
             amount = 10000000000;
             "deploy_hash" = FF04d55A292Aa00644D8F65646F7bF6b317541Fde21058C89d71a681394895CD;
             from = "account-hash-0616191782F4cC2D97132cf580b96B269Ca7631343Ae2545a5cCF4490400eC4A";
             gas = 0;
             id = "<null>";
             source = "uref-66c9B94777Ec761fD30884A63DC97F4A2701e30452F81ad0A55e70b3aaAcba81-007";
             target = "uref-F91063035c03eadD462c79Ca674C2B081E46008314589E27617aA24500bBe17c-007";
             to = "<null>";
         },
                 {
             amount = 1000000000000;
             "deploy_hash" = 1e4a3CD74DbB53d8dB41A7c797D4cf0ce3C2890eB4A41f6966E2A4C5dc07881f;
             from = "account-hash-b383C7CC23D18Bc1B42406A1B2d29fc8DbA86425197B6f553d7Fd61375b5E446";
             gas = 0;
             id = "<null>";
             source = "uref-b06a1AB0CfB52b5D4f9a08B68a5dBE78E999de0b0484C03e64F5C03897cF637b-007";
             target = "uref-29b22287c7867D1f1fE5a24c0aE47163c0A731b9A0e8574cB172D276A5b6ED01-004";
             to = "account-hash-F6ea2eFdA4FBd8Ac1239466a594deD85610D3E55eACCc22A0Feb9CAA33A59Ce6";
         }
     );
 }, "id": 1]

 */
import Foundation
class GetBlockTransfers:RpcWithOptionalParams {
    let methodStr : String = "chain_get_block_transfers"
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
