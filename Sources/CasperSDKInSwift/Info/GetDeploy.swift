//
//  GetDeploy.swift
//  SampleRPCCall1
//
//  Created by Hien on 10/12/2021.
//
//https://docs.rs/casper-node/latest/casper_node/rpcs/info/struct.GetDeploy.html

//NOT FULLY IMPLEMENTED, GET ERROR WITH INFORMATION LIKE THIS
/*
 ["jsonrpc": 2.0, "error": {
     code = "-32602";
     data = "<null>";
     message = "Invalid params";
 }, "id": 1]
 */

import Foundation

//https://testnet.cspr.live/deploy/5D2B9FD4B752043a3982b57DF3ca24f2F807926E504D34F746e3F41E8898eDb3

class GetDeploy {
    let methodStr : String = "info_get_deploy"
    let methodURL : String = "http://65.21.227.180:7777/rpc"
    public func getDeploy(deployHash:String="") async throws -> GetDeployResult{
        //var getPeerResult:GetPeersResult = GetPeersResult();
        let getDeploy:GetDeployResult = GetDeployResult();
        let methodStr : String = "info_get_deploy";
        do {
            //let json = try await HttpHandler.handleRequest2(calling_method: methodStr)
            var param = ["":"[]"] as [String:String]
            if deployHash != "" {
                param = ["deploy_hash":"5D2B9FD4B752043a3982b57DF3ca24f2F807926E504D34F746e3F41E8898eDb3"] as [String:String]
            }
            let json = try await HttpHandler.handleRequest(method: methodStr, params: param)
            if let error = json["error"] as? AnyObject {
                if let code = error["code"] as? Int32 {
                  //  print("error code:\(code)")
                    if code == -32700 {
                        throw GetStateRootHashError.parseError;
                    } else if code == -32601 {
                        throw GetStateRootHashError.methodNotFound
                    } else if code == -32001 {
                        throw GetStateRootHashError.blockNotFound
                    } else {
                        throw GetStateRootHashError.invalidURL
                    }
                }
                if let message = error["message"] as? String {
                    print("message:\(message)")
                } else {
                    print("Can not show message in error")
                }
            }
            if let id = json["id"] as? Int {
                print("id back:\(id)")
            } else {
                print("cant get id")
            }
            if let api_version = json["api_version"] as? String {
                print("api_version:\(api_version)")
                getDeploy.apiVersion = api_version;
            } else {
                print("can get json api_version")
            }
            if let result = json["result"] as? [String:Any] {
                //print("---result get deploy:\(result)")
                if let executionResult = result["execution_results"] {
                    print("executionResult:\(executionResult)")
                }
                if let deploy = result["deploy"] as? [String:Any] {
                   // print("deploy:\(deploy)")
                    //GET APPROVALS
                    if let approvals = deploy["approvals"] as? [AnyObject] {
                        let totalApproval = approvals.count
                        print("total approval:\(totalApproval)")
                        for approval in approvals {
                            let oneApproval:DeployApprovalItem = DeployApprovalItem();
                            if let signature = approval["signature"] as? String {
                                if let signer = approval["signer"] as? String {
                                    oneApproval.signature = signature;
                                    oneApproval.signer = signer
                                    print("deploy signer:\(signer), signature:\(signature)")
                                }
                            }
                            getDeploy.deploy.approvals.append(oneApproval);
                        }
                    }
                    //END OF GETTING APPROVALS
                    //GET HASH
                    if let hash = deploy["hash"] as? String {
                        print("deploy - hash:\(hash)")
                        getDeploy.deploy.hash = hash;
                    }
                    //END OF GETTING HASH
                    //GET HEADER
                    if let header = deploy["header"] as? [String:Any] {//7 items
                        if let account = header["account"] as? String {//1
                            print("deploy header account:\(account)")
                            getDeploy.deploy.header.account = account;
                        }
                        if let bodyHash = header["body_hash"] as? String {//2
                            print("deploy header body_hash:\(bodyHash)")
                            getDeploy.deploy.header.bodyHash = bodyHash;
                        }
                        if let chainName = header["chain_name"] as? String {//3
                            print("deploy header chain_name:\(chainName)")
                            getDeploy.deploy.header.chainName = chainName;
                        }
                        if let gasPrice = header["gas_price"] as? UInt64 {//4
                            print("deploy header gas_price:\(gasPrice)")
                            getDeploy.deploy.header.gasPrice = gasPrice;
                        }
                        if let timeStamp = header["timestamp"] as? String {//5
                            print("deploy header timestamp:\(timeStamp)");
                            getDeploy.deploy.header.timeStamp = timeStamp;
                        }
                        if let ttl = header["ttl"] as? String {//6
                            print("deploy header ttl:\(ttl)");
                            getDeploy.deploy.header.ttl = ttl;
                        }
                        if let dependencies = header["dependencies"] as? [String] {
                            for dependency in dependencies {
                                print("deploy header dependency:\(dependency)")
                                getDeploy.deploy.header.dependencies.append(dependency)
                            }
                        }
                    }
                    //END OF GETTING HEADER
                }
            }
        } catch {
            throw error;
        }
        return getDeploy;
    }
    func handle_request() {
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
                                var protocolVersion:ProtocolVersion = ProtocolVersion();
                                protocolVersion.protocolString = api_version;
                                protocolVersion.serialize();
                                //self.getStateRootHashResult.apiVersion = protocolVersion;
                            } else {
                                print("Can not get api_version in result")
                            }
                            if let state_root_hash = result["state_root_hash"] as? String{
                                print("stateRootHash:\(state_root_hash)")
                               // self.getStateRootHashResult.stateRootHash = state_root_hash;
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
