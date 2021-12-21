//
//  GetStateRootHash.swift
//  SampleRPCCall1
//
//  Created by Hien on 09/12/2021.
//
//https://docs.rs/casper-node/latest/casper_node/rpcs/chain/struct.GetStateRootHash.html

//DATA BACK LIKE THIS
/*
 ["result": {
     "api_version" = "1.4.3";
     "state_root_hash" = 1b0e70c9c78873867E317b184Ce1723162d6956fad9E8e4b1897D6f505c5e496;
 }, "id": 1, "jsonrpc": 2.0]
 */

import Foundation
class GetStateRootHash {
    let methodStr : String = "chain_get_state_root_hash";// "chain_get_state_root_hash"
    //let methodURL : String = "http://3.136.227.9:7777/rpc";//
    //836e0D3B8F6ba91e7B11EC9501FEc39150728777A72CF3B93555754DD7B77DFd;
    //836e0D3B8F6ba91e7B11EC9501FEc39150728777A72CF3B93555754DD7B77DFd;
    let methodURL : String = "http://65.21.227.180:7777/rpc";
   // var getStateRootHashResult:GetStateRootHashResult = GetStateRootHashResult();
    //fdggfa623841478381D78C769636582305efdgd724f561d7314B4daED19A3EA6373Dd778
    //state_root_hash back:
    //1b0e70c9c78873867E317b184Ce1723162d6956fad9E8e4b1897D6f505c5e496
    //37918dF9Cc553352d5fFC019B67CFD43e131BfA353ece9688C51D114Ae103968
    //37918dF9Cc553352d5fFC019B67CFD43e131BfA353ece9688C51D114Ae103968
    //b34810C053B385260C5F2D7e3235DEFDC726b0B6E009ED96B44C5E3451f0e993
    //aaDEBC4Fdb8F01d96e452136470919506cF3f08d182d92B3258Eec3d72295D16;
    //aaDEBC4Fdb8F01d96e452136470919506cF3f08d182d92B3258Eec3d72295D16
    //aaDEBC4Fdb8F01d96e452136470919506cF3f08d182d92B3258Eec3d72295D16
    //9D386a6F60B4905EeBDd6a8c57B353869cbA9353D0a5F3D71309A0D445D5952C;
    func handle_request() {
        print("Handle Request started to call for GetStateRootHash1")
        let parameters = ["id": 1, "method": methodStr,"params":"[\"Hash\": \"37918dF9Cc553352d5fFC019B67CFD43e131BfA353ece9688C51D114Ae103968;\"]","jsonrpc":"2.0"] as [String : Any]
       // let parameters = ["id": 1, "method": methodStr,"params":" ({name = \"block_identifier\";required = 5;schema ={\"$ref\"\"#/components/schemas/BlockIdentifier\";description = \"The block hash.\";};});","jsonrpc":"2.0"] as [String : Any]
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
                        if let id = json["id"] as? Int {
                            print("id back:\(id)")
                        } else {
                            print("Can not retrieve id");
                        }
                        if let jsonRPC = json["jsonrpc"] as? Float {
                            print("jsonRPC:\(jsonRPC)");
                        }
                        if let result = json["result"] as? AnyObject {
                            if let api_version = result["api_version"] as? String {
                                print("Api_version:\(api_version)")
                                //var protocolVersion:ProtocolVersion = ProtocolVersion();
                               // protocolVersion.protocolString = api_version;
                               // protocolVersion.serialize();
                             //   self.getStateRootHashResult.apiVersion = protocolVersion;
                            } else {
                                print("Can not get api_version in result")
                            }
                            if let state_root_hash = result["state_root_hash"] as? String{
                                print("stateRootHash:\(state_root_hash)")
                              //  self.getStateRootHashResult.stateRootHash = state_root_hash;
                            } else {
                                print("Can not get state root hash in result")
                            }
                        } else {
                            print("Can not get result")
                        }
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            })
            task.resume()
      
    }
}
