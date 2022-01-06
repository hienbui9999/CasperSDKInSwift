import Foundation

class GetDeploy {
    let methodStr : String = "info_get_deploy"
    let methodURL : String = "http://65.21.227.180:7777/rpc"
    let deployHashFix:String = "5FE66F884b71bCd23BE54ce0Aaae9a8ae3e63Baf5F9Bf633383337DcEBECC060"
    public func getDeploy(json:[String:Any]) throws -> GetDeployResult{
        let getDeploy:GetDeployResult = GetDeployResult();
        let methodStr : String = "info_get_deploy";
        do {
            if let error = json["error"] as AnyObject? {
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
                  
                }
                if let deployStrBack = result["deploy"] as? [String:Any] {
                    if let approvals = deployStrBack["approvals"] as? [AnyObject] {
                        let totalApproval = approvals.count
                        for approval in approvals {
                            let oneApproval:DeployApprovalItem = DeployApprovalItem();
                            if let signature = approval["signature"] as? String {
                                if let signer = approval["signer"] as? String {
                                    oneApproval.signature = signature;
                                    oneApproval.signer = signer
                                }
                            }
                            getDeploy.deploy.approvals.append(oneApproval);
                        }
                    }
                   
                    if let hash = deployStrBack["hash"] as? String {
                        getDeploy.deploy.hash = hash;
                    }
                   
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
                    
                    if let payment = deployStrBack["payment"] as? [String:Any] {
                        print("payment:\(payment)")
                        getDeploy.deploy.payment = getExecutableDeployItem(from: payment);
                    }
                   
                    if let session = deployStrBack["session"] as? [String:Any] {
                        getDeploy.deploy.session = getExecutableDeployItem(from: session);
                    }

                    let executionResult = getExecutionResult(from: result);
                    
                }
            }
        } catch {
            throw error;
        }
        return getDeploy;
    }
    public func getExecutionResult(from:[String:Any]) -> [JsonExecutionResult] {
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
                                counter += 1;
                            }
                        }
                        if let effect = success["effect"] as? [String:Any] {
                            if let operations = effect["operations"] as? [AnyObject] {
                                let totalOperations = operations.count
                            }
                            if let transforms = effect["transforms"] as? [AnyObject] {
                                let totalTransform = transforms.count;
                                var counter:UInt = 0;
                                for transform in transforms {
                                    counter += 1;
                                    if let key = transform["key"] as? String {
                                        if let transformValue = transform["transform"] as? String {
                                            if transformValue == "Identity" {
                                               
                                            }
                                        }
                                        //type is among WriteCLValue,AddUInt512, WriteDeployInfo ...
                                        else if let transformValue = transform["transform"] as? AnyObject {
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
            var oneDeployInfo : DeployInfo = DeployInfo();
            if let deployHash:String = transformWriteDeployInfo["deploy_hash"] as? String {
                oneDeployInfo.deployHash = deployHash
            }
            if let deployFrom : String = transformWriteDeployInfo["from"] as? String {
                oneDeployInfo.from = deployFrom
            }
            if let gas = transformWriteDeployInfo["gas"] as? String {
                oneDeployInfo.gas = gas;
            }
            if let source:String = transformWriteDeployInfo["source"] as? String {
                oneDeployInfo.source = source
            }
            if let transfers = transformWriteDeployInfo["transfers"] as? [String] {
                for transfer in transfers {
                    oneDeployInfo.transfers?.append(transfer)
                }
            }
            retValue = .WriteDeployInfo(oneDeployInfo)
        }
        else if let transformWriteCLValue = from["WriteCLValue"] as? [String:Any] {
        
        }
        return retValue;
    }
    
    public func getExecutableDeployItem(from:[String:Any]) -> ExecutableDeployItem {
        var retExecutionDeployItem:ExecutableDeployItem = .NONE;
        if let argsType = from["ModuleBytes"] as? [String:Any] {
            print("executableDeployItem is module bytes")
            var moduleBytesStr = "";
            if let module_bytes = argsType["module_bytes"] as? String {
                moduleBytesStr = module_bytes;
            }
            var runtimesArgList:[RuntimeArg] = [RuntimeArg]();
            
            if let args = argsType["args"] as? [AnyObject] {
                var counter:Int = 0;
                for arg in args {
                    counter += 1;
                    if let arg0 = arg[0] as? String {
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
     
        if let argsType = from["StoredContractByHash"] as? [String:Any] {
            var hash1:String = "";
            var entryPoint1:String = "";
            if let hash = argsType["hash"] as? String {
                hash1 = hash;
            }
            if let entryPoint = argsType["entry_point"] as? String {
                entryPoint1 = entryPoint
            }
            var runtimesArgList:[RuntimeArg] = [RuntimeArg]();
            
            if let args = argsType["args"] as? [AnyObject] {
                var counter:Int = 0;
                for arg in args {
                    counter += 1;
                    if let arg0 = arg[0] as? String {
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
            retExecutionDeployItem = .StoredContractByHash(hash1, entryPoint1, runtimesArgList)
        }
     
        if let argsType = from["StoredContractByName"] as? [String:Any] {
            var hash1:String = "";
            var entryPoint1:String = "";
            if let hash = argsType["hash"] as? String {
                hash1 = hash;
            }
            if let entryPoint = argsType["entry_point"] as? String {
                entryPoint1 = entryPoint
            }
            var runtimesArgList:[RuntimeArg] = [RuntimeArg]();
            
            if let args = argsType["args"] as? [AnyObject] {
                var counter:Int = 0;
                for arg in args {
                    counter += 1;
                    if let arg0 = arg[0] as? String {
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
        
        if let argsType = from["StoredVersionedContractByHash"] as? [String:Any] {
            var hash1:String = "";
            var entryPoint1:String = "";
            if let hash = argsType["hash"] as? String {
                hash1 = hash;
            }
            if let entryPoint = argsType["entry_point"] as? String {
                entryPoint1 = entryPoint
            }
            var runtimesArgList:[RuntimeArg] = [RuntimeArg]();
            
            if let args = argsType["args"] as? [AnyObject] {
                var counter:Int = 0;
                for arg in args {
                    counter += 1;
                    if let arg0 = arg[0] as? String {
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
            retExecutionDeployItem = .StoredVersionedContractByHash(hash1, 2 , entryPoint1, runtimesArgList)
        }
       
        if let argsType = from["StoredVersionedContractByName"] as? [String:Any] {
            var hash1:String = "";
            var entryPoint1:String = "";
            if let hash = argsType["hash"] as? String {
                hash1 = hash;
            }
            if let entryPoint = argsType["entry_point"] as? String {
                entryPoint1 = entryPoint
            }
            var runtimesArgList:[RuntimeArg] = [RuntimeArg]();
            
            if let args = argsType["args"] as? [AnyObject] {
                var counter:Int = 0;
                for arg in args {
                    counter += 1;
                   // print("arg:\(arg)")
                    if let arg0 = arg[0] as? String {
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
            retExecutionDeployItem = .StoredVersionedContractByName(hash1, 2 , entryPoint1, runtimesArgList)
        }
       
        if let argsType = from["Transfer"] as? [String:Any] {
            var runtimesArgList:[RuntimeArg] = [RuntimeArg]();
            if let args = argsType["args"] as? [AnyObject] {
                var counter:Int = 0;
                for arg in args {
                    counter += 1;
                    if let arg0 = arg[0] as? String {
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
}
