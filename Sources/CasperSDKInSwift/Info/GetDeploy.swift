//
//  GetDeploy.swift
//  SampleRPCCall1
//
//  Created by Hien on 10/12/2021.
//
//https://docs.rs/casper-node/latest/casper_node/rpcs/info/struct.GetDeploy.html
import Foundation
class GetDeploy {
    let methodStr : String = "info_get_deploy"
    let methodURL : String = "http://65.21.227.180:7777/rpc"
    //comment this for real test
    let deployHashFix:String = "5FE66F884b71bCd23BE54ce0Aaae9a8ae3e63Baf5F9Bf633383337DcEBECC060"
    public func getDeploy(json:[String:Any]) throws -> GetDeployResult{
        let getDeploy:GetDeployResult = GetDeployResult();
        /*
         var param = ["":"[]"] as [String:String]
         if deployHash != "" {
             param = ["deploy_hash":deployHashFix] as [String:String]
         } else {
             param = ["deploy_hash":deployHashFix] as [String:String]
         }
         */
        let methodStr : String = "info_get_deploy";
        do {
            //let json = try await HttpHandler.handleRequest(method: methodStr, params: param)
            if let error = json["error"] as? AnyObject {
                if let code = error["code"] as? Int32 {
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
                } else {
                }
            }
            if let id = json["id"] as? Int {
            } else {
            }
            if let api_version = json["api_version"] as? String {
                getDeploy.apiVersion = api_version;
            } else {
            }
            if let result = json["result"] as? [String:Any] {
              
                if let executionResult = result["execution_results"] {
                  //  print("executionResult:\(executionResult)")
                }
                if let deployStrBack = result["deploy"] as? [String:Any] {
                   // print("deploy:\(deploy)")
                    //GET APPROVALS
                    if let approvals = deployStrBack["approvals"] as? [AnyObject] {
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
                    if let hash = deployStrBack["hash"] as? String {
                        print("deploy - hash:\(hash)")
                        getDeploy.deploy.hash = hash;
                    }
                    //END OF GETTING HASH
                    //GET HEADER
                    if let header = deployStrBack["header"] as? [String:Any] {//7 items
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
                    //GET PAYMENT
                    if let payment = deployStrBack["payment"] as? [String:Any] {
                        print("payment:\(payment)")
                        getDeploy.deploy.payment = getExecutableDeployItem(from: payment);
                    }
                    //END OF GETTING PAYMENT
                    print("------------------------------------------------------------GETTING SESSION")
                    //GET SESSION
                    if let session = deployStrBack["session"] as? [String:Any] {
                        getDeploy.deploy.session = getExecutableDeployItem(from: session);
                    }
                    //END OF GETTING SESSION
                    print("------------------------------------------------------------GETTING EXECUTION RESULT")
                    //GET EXECUTION RESULT
                    let executionResult = getExecutionResult(from: result);
                    //END OF GETTING EXECUTION RESULT
                }
            }
        } catch {
            throw error;
        }
        return getDeploy;
    }
    public func getExecutionResult(from:[String:Any]) -> [JsonExecutionResult] {
       // print("from is:\(from)")
        let retValue:[JsonExecutionResult] = [JsonExecutionResult]();
        if let executionResults = from["execution_results"] as? [AnyObject] {
            for executionResult in executionResults{
                if let blockHash = executionResult["block_hash"] {
                    
                }
                if let result = executionResult["result"] as? [String:Any] {
                    if let success = result["Success"] as? [String:Any] {
                        if let cost = success["cost"] as? String {
                            
                        }
                        if let transfers = success["transfers"] as? [AnyObject] {
                            var counter:Int = 0;
                            for transfer in transfers {
                                print("Tranfer \(counter), \(transfer) ")
                                counter += 1;
                            }
                        }
                        if let effect = success["effect"] as? [String:Any] {
                            if let operations = effect["operations"] as? [AnyObject] {
                                let totalOperations = operations.count
                                print("Print for operations here, total operations:\(totalOperations)")
                            }
                            if let transforms = effect["transforms"] as? [AnyObject] {
                                let totalTransform = transforms.count;
                                print("Total transform:\(totalTransform)")
                                var counter:UInt = 0;
                                for transform in transforms {
                                    counter += 1;
                                    if let key = transform["key"] as? String {
                                        if let transformValue = transform["transform"] as? String {
                                            print("transform item \(counter) key:\(key), transformValue:\(transformValue)");
                                            if transformValue == "Identity" {
                                                print("IT IS IDENTITY")
                                            }
                                        }
                                        //TYPE NOT IDENTITY, SUCH AS WriteCLValue,AddUInt512, WriteDeployInfo
                                        else if let transformValue = transform["transform"] as? AnyObject {
                                            print("transform item \(counter) key:\(key), transformValue NOT IDENTITY :\(transformValue)");
                                            if let addUInt512 = transformValue["AddUInt512"] as? String {
                                                let u512:U512=U512()
                                                let transformObj:Transform = .AddUInt512(u512)
                                            }
                                            let transformObj:Transform = getDeployExecutionTransform(from: transformValue);
                                           
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        return retValue;
    }
    func getDeployExecutionTransform(from:AnyObject)-> Transform{
        var retValue:Transform = .NONE
        if let transformWriteDeployInfo = from["WriteDeployInfo"] as? [String:Any] {
            print("---THIS IS WriteDeployInfo")
            var oneDeployInfo : DeployInfo = DeployInfo();
            if let deployHash:String = transformWriteDeployInfo["deploy_hash"] as? String {
                oneDeployInfo.deployHash = deployHash
                print("hash:\(deployHash)")
            }
            if let deployFrom : String = transformWriteDeployInfo["from"] as? String {
                oneDeployInfo.from = deployFrom
                print("from:\(deployFrom)")
            }
            if let gas = transformWriteDeployInfo["gas"] as? String {
                oneDeployInfo.gas = gas;
                print("gas:\(gas)")
            }
            if let source:String = transformWriteDeployInfo["source"] as? String {
                oneDeployInfo.source = source
                print("source:\(source)")
            }
            if let transfers = transformWriteDeployInfo["transfers"] as? [String] {
                for transfer in transfers {
                    print("transfer in transform:\(transfer)")
                    oneDeployInfo.transfers?.append(transfer)
                }
            }
            //if let
            retValue = .WriteDeployInfo(oneDeployInfo)
        }
        else if let transformWriteCLValue = from["WriteCLValue"] as? [String:Any] {
            print("This is WriteCLValue")
            
        }
        return retValue;
    }
  //  public func getExecutionResult(from:[String:Any]) -> 
    public func getExecutableDeployItem(from:[String:Any]) -> ExecutableDeployItem {
        var retExecutionDeployItem:ExecutableDeployItem = .NONE;
        //ModuleBytes
        /*
         ModuleBytes {
             #[serde(with = "HexForm::<Vec<u8>>")]
             module_bytes: Vec<u8>,
             // assumes implicit `call` noarg entrypoint
             #[serde(with = "HexForm::<Vec<u8>>")]
             args: Vec<u8>,
         },
         */
        if let argsType = from["ModuleBytes"] as? [String:Any] {
            print("executableDeployItem is module bytes")//,ModuleBytes:\(argsType)")
            var moduleBytesStr = "";
            if let module_bytes = argsType["module_bytes"] as? String {
                moduleBytesStr = module_bytes;
            }
            var runtimesArgList:[RuntimeArg] = [RuntimeArg]();
            
            if let args = argsType["args"] as? [AnyObject] {
                var counter:Int = 0;
                for arg in args {
                    counter += 1;
                   // print("arg:\(arg)")
                    if let arg0 = arg[0] as? String {
                        print("counter:\(counter), ---- arg0:\(arg0)")
                        if let arg1 = arg[1] as? [String:Any] {
                            var runtimeArg:RuntimeArg = RuntimeArg();
                            var arg:DeployArgItem = runtimeArg.textToArgObject(input: arg1);
                            runtimeArg.item0 = arg0;
                            runtimeArg.argsItem = arg;
                            runtimesArgList.append(runtimeArg);
                        }
                    }
                    
                }
            }
            retExecutionDeployItem = .ModuleBytes(moduleBytesStr, runtimesArgList)
        }
       /*
        StoredContractByHash {
            #[serde(with = "HexForm::<[u8; KEY_HASH_LENGTH]>")]
            hash: ContractHash,
            entry_point: String,
            #[serde(with = "HexForm::<Vec<u8>>")]
            args: Vec<u8>,
        },
        */
        if let argsType = from["StoredContractByHash"] as? [String:Any] {
            print("executableDeployItem is StoredContractByHash,StoredContractByHash:\(argsType)")
            var hash1:String = "";
            var entryPoint1:String = "";
            if let hash = argsType["hash"] as? String {
                print("session hash:\(hash)")
                hash1 = hash;
            }
            if let entryPoint = argsType["entry_point"] as? String {
                print("entryPoint:\(entryPoint)")
                entryPoint1 = entryPoint
            }
            var runtimesArgList:[RuntimeArg] = [RuntimeArg]();
            
            if let args = argsType["args"] as? [AnyObject] {
                var counter:Int = 0;
                for arg in args {
                    counter += 1;
                   // print("arg:\(arg)")
                    if let arg0 = arg[0] as? String {
                        print("counter:\(counter), ---- arg0:\(arg0)")
                        if let arg1 = arg[1] as? [String:Any] {
                            var runtimeArg:RuntimeArg = RuntimeArg();
                            var arg:DeployArgItem = runtimeArg.textToArgObject(input: arg1);
                            runtimeArg.item0 = arg0;
                            runtimeArg.argsItem = arg;
                            runtimesArgList.append(runtimeArg);
                        }
                    }
                }
            }
            //TAKE THE VERSION HERE
            retExecutionDeployItem = .StoredContractByHash(hash1, entryPoint1, runtimesArgList)
        }
       /*
        StoredContractByName {
            name: String,
            entry_point: String,
            #[serde(with = "HexForm::<Vec<u8>>")]
            args: Vec<u8>,
        },
        */
        if let argsType = from["StoredContractByName"] as? [String:Any] {
            print("executableDeployItem is StoredContractByName,StoredContractByName:\(argsType)")
            var hash1:String = "";
            var entryPoint1:String = "";
            if let hash = argsType["hash"] as? String {
                print("session hash:\(hash)")
                hash1 = hash;
            }
            if let entryPoint = argsType["entry_point"] as? String {
                print("entryPoint:\(entryPoint)")
                entryPoint1 = entryPoint
            }
            var runtimesArgList:[RuntimeArg] = [RuntimeArg]();
            
            if let args = argsType["args"] as? [AnyObject] {
                var counter:Int = 0;
                for arg in args {
                    counter += 1;
                   // print("arg:\(arg)")
                    if let arg0 = arg[0] as? String {
                        print("counter:\(counter), ---- arg0:\(arg0)")
                        if let arg1 = arg[1] as? [String:Any] {
                            var runtimeArg:RuntimeArg = RuntimeArg();
                            var arg:DeployArgItem = runtimeArg.textToArgObject(input: arg1);
                            runtimeArg.item0 = arg0;
                            runtimeArg.argsItem = arg;
                            runtimesArgList.append(runtimeArg);
                        }
                    }
                }
            }
            retExecutionDeployItem = .StoredContractByName(hash1, entryPoint1, runtimesArgList)
        }
        /*
         StoredVersionedContractByHash {
             #[serde(with = "HexForm::<[u8; KEY_HASH_LENGTH]>")]
             hash: ContractPackageHash,
             version: Option<ContractVersion>, // defaults to highest enabled version
             entry_point: String,
             #[serde(with = "HexForm::<Vec<u8>>")]
             args: Vec<u8>,
         },
         */
        
        if let argsType = from["StoredVersionedContractByHash"] as? [String:Any] {
            print("executableDeployItem is StoredVersionedContractByHash,StoredVersionedContractByHash:\(argsType)")
            var hash1:String = "";
            var entryPoint1:String = "";
            if let hash = argsType["hash"] as? String {
                print("session hash:\(hash)")
                hash1 = hash;
            }
            if let entryPoint = argsType["entry_point"] as? String {
                print("entryPoint:\(entryPoint)")
                entryPoint1 = entryPoint
            }
            var runtimesArgList:[RuntimeArg] = [RuntimeArg]();
            
            if let args = argsType["args"] as? [AnyObject] {
                var counter:Int = 0;
                for arg in args {
                    counter += 1;
                   // print("arg:\(arg)")
                    if let arg0 = arg[0] as? String {
                        print("counter:\(counter), ---- arg0:\(arg0)")
                        if let arg1 = arg[1] as? [String:Any] {
                            var runtimeArg:RuntimeArg = RuntimeArg();
                            var arg:DeployArgItem = runtimeArg.textToArgObject(input: arg1);
                            runtimeArg.item0 = arg0;
                            runtimeArg.argsItem = arg;
                            runtimesArgList.append(runtimeArg);
                        }
                    }
                }
            }
            //TAKE THE VERSION HERE
            retExecutionDeployItem = .StoredVersionedContractByHash(hash1, 2 , entryPoint1, runtimesArgList)
        }
       
        
        /*
         StoredVersionedContractByName {
             name: String,
             version: Option<ContractVersion>, // defaults to highest enabled version
             entry_point: String,
             #[serde(with = "HexForm::<Vec<u8>>")]
             args: Vec<u8>,
         },
         */
        if let argsType = from["StoredVersionedContractByName"] as? [String:Any] {
            print("executableDeployItem is StoredVersionedContractByName,StoredVersionedContractByName:\(argsType)")
            var hash1:String = "";
            var entryPoint1:String = "";
            if let hash = argsType["hash"] as? String {
                print("session hash:\(hash)")
                hash1 = hash;
            }
            if let entryPoint = argsType["entry_point"] as? String {
                print("entryPoint:\(entryPoint)")
                entryPoint1 = entryPoint
            }
            var runtimesArgList:[RuntimeArg] = [RuntimeArg]();
            
            if let args = argsType["args"] as? [AnyObject] {
                var counter:Int = 0;
                for arg in args {
                    counter += 1;
                   // print("arg:\(arg)")
                    if let arg0 = arg[0] as? String {
                        print("counter:\(counter), ---- arg0:\(arg0)")
                        if let arg1 = arg[1] as? [String:Any] {
                            var runtimeArg:RuntimeArg = RuntimeArg();
                            var arg:DeployArgItem = runtimeArg.textToArgObject(input: arg1);
                            runtimeArg.item0 = arg0;
                            runtimeArg.argsItem = arg;
                            runtimesArgList.append(runtimeArg);
                        }
                    }
                }
            }
            //TAKE THE VERSION HERE
            retExecutionDeployItem = .StoredVersionedContractByName(hash1, 2 , entryPoint1, runtimesArgList)
        }
        /*
         Transfer {
             #[serde(with = "HexForm::<Vec<u8>>")]
             args: Vec<u8>,
         },
         */
        if let argsType = from["Transfer"] as? [String:Any] {
            print("executableDeployItem is Transfer,Transfer:\(argsType)")
            var runtimesArgList:[RuntimeArg] = [RuntimeArg]();
            if let args = argsType["args"] as? [AnyObject] {
                var counter:Int = 0;
                for arg in args {
                    counter += 1;
                   // print("arg:\(arg)")
                    if let arg0 = arg[0] as? String {
                        print("counter:\(counter), ---- arg0:\(arg0)")
                        if let arg1 = arg[1] as? [String:Any] {
                            var runtimeArg:RuntimeArg = RuntimeArg();
                            var arg:DeployArgItem = runtimeArg.textToArgObject(input: arg1);
                            runtimeArg.item0 = arg0;
                            runtimeArg.argsItem = arg;
                            runtimesArgList.append(runtimeArg);
                        }
                    }
                    
                }
            }
            retExecutionDeployItem = .Transfer(runtimesArgList)
        }
        return retExecutionDeployItem
    }
    /*
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
      
    }*/
}
