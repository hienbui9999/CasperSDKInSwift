//
//  RPCInfo.swift
//  SampleRPCCall1
//
//  Created by Hien on 09/12/2021.
//
//https://docs.rs/casper-node/latest/casper_node/rpcs/info/struct.GetPeers.html

import Foundation

struct GetDeployParams {
    
}
struct GetDeployResult {
    
}
class GetPeers : RpcWithoutParams,RpcWithoutParamsExt {
    //method to send: info_get_peers
    let methodStr : String = "info_get_peers"
    let methodURL : String = "http://65.21.227.180:7777/rpc"
   // var getPeerResult:GetPeersResult = GetPeersResult();
    var getPeerResult:GetPeersResult = GetPeersResult();
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
                        //print("JSON BACK:\(json)")
                        if let id = json["id"] as? Int {
                            print("id back:\(id)")
                        } else {
                            print("cant get id")
                        }
                        if let jsonCPR = json["jsonrpc"] as? String {
                            print("jsonCPR:\(jsonCPR)")
                        } else {
                            print("can get json CPR")
                        }
                        if let result = json["result"] as? [String:Any] {
                           // print("---result:\(result)")
                            if let api_version = result["api_version"] as? String {
                                print("Api _version:\(api_version)")
                                var protocolVersion:ProtocolVersion = ProtocolVersion();
                                protocolVersion.protocolString = api_version;
                                protocolVersion.serialize();
                                self.getPeerResult.protocolVersion = protocolVersion;
                            } else {
                                print("can not get api version");
                            }
                            if let peers = result["peers"] as? [AnyObject]{
                                var counter = 0;
                                var peerMap:PeerMap = PeerMap();
                                for peer in peers {
                                    counter += 1;
                                    if let node_id = peer["node_id"] as? String {
                                        print("counter:\(counter), node_id:\(node_id)")
                                        if let address = peer["address"] as? String {
                                            print("Address:\(address)")
                                            var onePeerEntry : PeerEntry = PeerEntry();
                                            onePeerEntry.address = address;
                                            onePeerEntry.nodeID = node_id;
                                            peerMap.peerEntryList.append(onePeerEntry);
                                        } else {
                                            print("Can not get address")
                                        }
                                    } else {
                                        print("can not get node_id")
                                    }
                                }
                                self.getPeerResult.peers = peerMap;
                              //  print("PEERS: \(peers)")
                            } else {
                                print("Can not get peers")
                            }
                        } else {
                            print("result NOT GET")
                        }
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            })
            task.resume()
       // return ret;
    }
    
}
