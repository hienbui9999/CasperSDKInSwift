//
//  File.swift
//  
//
//  Created by Hien on 22/12/2021.
//

import Foundation
import XCTest
class HttpHandler:XCTestCase {
    static var methodURL:String = "https://node-clarity-testnet.make.services/rpc";
    public var methodCall:CasperMethodCall = .chainGetStateRootHash;
    public func handleRequest(method:CasperMethodCall,params:Any) throws{
        guard let url = URL(string: HttpHandler.methodURL) else {
            throw CasperMethodError.invalidURL
        }
        let json: [String: Any] = ["id": CASPER_ID, "method": method.rawValue,"jsonrpc":"2.0","params":params] as [String:Any]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let expectation = self.expectation(description: "Getting json data from casper")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                expectation.fulfill()
                if self.methodCall == .chainGetStateRootHash {
                    do {
                        let stateRootHash = try GetStateRootHash.getStateRootHash(from: responseJSON);
                         XCTAssertEqual(stateRootHash.count,64,"Error data back, state_root_hash should be 64 length string")
                        /*  Uncomment this for showing the state_root_hash*/
                        
                        // print("StateRootHash:\(stateRootHash)")
                         
                    }
                    catch {
                     
                    }
                } else if self.methodCall == .infoGetPeer {
                    do {
                        let getPeer:GetPeersResult = try GetPeers.getPeers(from: responseJSON)
                        
                        /* Uncomment this for showing the getPeer results - a list of PeerEntry*/
                        /*
                        //If the result is parsed well, then we can get information from the GetPeerResult
                        let peerMap = getPeer.getPeerMap()
                        let peerEntryList = peerMap.getPeerEntryList();
                        //This is the total
                        let totalPeer = peerEntryList.count
                        print("Total peer:\(totalPeer)")
                        for peer in peerEntryList {
                            print("Peer id:\(peer.getNodeId()), peer address:\(peer.getAddress())")
                        }
                         */
                         
                    } catch {
                
                    }
                }
            } else {
                print("Error get data")
            }
        }
        task.resume()
        self.waitForExpectations(timeout: 15, handler: nil)
    }
}
