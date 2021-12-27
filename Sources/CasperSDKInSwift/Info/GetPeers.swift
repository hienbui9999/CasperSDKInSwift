//
//  RPCInfo.swift
//  SampleRPCCall1
//
//  Created by Hien on 09/12/2021.
//
//https://docs.rs/casper-node/latest/casper_node/rpcs/info/struct.GetPeers.html

import Foundation


class GetPeers  {
    //method to send: info_get_peers
    @available(iOS 15.0.0, *)
    public func getPeers() async throws -> GetPeersResult {
        var getPeerResult:GetPeersResult = GetPeersResult();
        let methodStr : String = "info_get_peers";
        do {
            let json = try await HttpHandler.handleRequest(method: methodStr, params: "[]")
          //  print("Json back:\(json)")
            if let id = json["id"] as? Int {
               // print("id back:\(id)")
            } else {
                print("cant get id")
            }
            if let jsonCPR = json["jsonrpc"] as? String {
              //  print("jsonCPR:\(jsonCPR)")
            } else {
                print("can get json CPR")
            }
            if let result = json["result"] as? [String:Any] {
               // print("---result:\(result)")
                if let api_version = result["api_version"] as? String {
                   // print("Api _version:\(api_version)")
                    var protocolVersion:ProtocolVersion = ProtocolVersion();
                    protocolVersion.protocolString = api_version;
                    protocolVersion.serialize();
                    getPeerResult.protocolVersion = protocolVersion;
                } else {
                    print("can not get api version");
                }
                if let peers = result["peers"] as? [AnyObject]{
                    var counter = 0;
                    var peerMap:PeerMap = PeerMap();
                    for peer in peers {
                        counter += 1;
                        if let node_id = peer["node_id"] as? String {
                            //print("counter:\(counter), node_id:\(node_id)")
                            if let address = peer["address"] as? String {
                               // print("Address:\(address)")
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
                    getPeerResult.peers = peerMap;
                    return getPeerResult;
                  //  print("PEERS: \(peers)")
                } else {
                    print("Can not get peers")
                    throw CasperMethodError.parseError
                }
            } else {
                print("result NOT GET")
                throw CasperMethodError.parseError
            }
        } catch {
            throw error
        }
    }
    
}
