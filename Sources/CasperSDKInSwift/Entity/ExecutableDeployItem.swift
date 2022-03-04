import Foundation

/**
 Enumeration type represents the ExecutableDeployItem
 */

public enum ExecutableDeployItem {
    case ModuleBytes (module_bytes:Bytes, args: RuntimeArgs)
    case StoredContractByHash(hash:String,entry_point:String,args:RuntimeArgs)
    case StoredContractByName(name:String,entry_point:String,args:RuntimeArgs)
    case StoredVersionedContractByHash (hash:String,version:UInt32?,entry_point:String,args:RuntimeArgs)
    case StoredVersionedContractByName(name:String,version:UInt32?,entry_point:String,args:RuntimeArgs)
    case Transfer(args:RuntimeArgs)
    case NONE
}

/**
 Class supports the getting of ExecutableDeployItem from Json String
 */

public class ExecutableDeployItemHelper {
    /**
        Function to get  json object from ExecutableDeployItem enum type
       - Parameter : a ExecutableDeployItem enum type  value
       - Returns: json object representing the ExecutableDeployItem enum type value, in form of [String:Any]
     */
    public static func toJson(input:ExecutableDeployItem)->[String:Any] {
        var retValue:[String:Any] = ["":"" as Any]
        switch input {
        case .ModuleBytes(let module_bytes, let args):
            let argsJsonAll = ExecutableDeployItemHelper.argsToJson(args: args)
            retValue = ["module_bytes":module_bytes.value,"args":argsJsonAll];
           // print("moduleBytesJson:\(retValue)")
            return retValue
        case .StoredContractByHash(let hash, let entry_point, let args):
            let argsJsonAll = ExecutableDeployItemHelper.argsToJson(args: args)
            retValue = ["hash":hash,"entry_point":entry_point,"args":argsJsonAll]
            return retValue
        case .StoredContractByName(let name, let entry_point, let args):
            let argsJsonAll = ExecutableDeployItemHelper.argsToJson(args: args)
            retValue = ["name":name,"entry_point":entry_point,"args":argsJsonAll]
            return retValue
        case .StoredVersionedContractByHash(let hash, let version, let entry_point, let args):
            let argsJsonAll = ExecutableDeployItemHelper.argsToJson(args: args)
            retValue = ["hash":hash,"version": version as Any, "entry_point":entry_point,"args":argsJsonAll]
            return retValue
        case .StoredVersionedContractByName(let name, let version, let entry_point, let args):
            let argsJsonAll = ExecutableDeployItemHelper.argsToJson(args: args)
            retValue = ["name":name,"version":version as Any, "entry_point":entry_point,"args":argsJsonAll]
            return retValue
        case .Transfer(let args):
            let argsJsonAll = ExecutableDeployItemHelper.argsToJson(args: args)
             retValue = ["args":argsJsonAll]
            return retValue
        case .NONE:
            break
        }
        return retValue
    }
    /**
       Get ExecutableDeployItem object from Json string
       - Parameter : a Json String represents the ExecutableDeployItem object
       - Returns: ExecutableDeployItem object
       */

    public static func getExecutableDeployItem(from:[String:Any]) -> ExecutableDeployItem {
        var retExecutionDeployItem:ExecutableDeployItem = .NONE;
        if let argsType = from["ModuleBytes"] as? [String:Any] {
            var moduleBytes:Bytes = Bytes();
            if let module_bytes = argsType["module_bytes"] as? String {
                moduleBytes = Bytes.fromStrToBytes(from: module_bytes);
            }
            var runtimesArgList:[NamedArg] = [NamedArg]();
            var retArgs:RuntimeArgs = RuntimeArgs();
            if let args = argsType["args"] as? [AnyObject] {
                var counter:Int = 0;
                for arg in args {
                    counter += 1;
                    let runtimeArg:NamedArg = NamedArg();
                    if let name = arg[0] as? String {
                        runtimeArg.name = name;
                    }
                    if let arg1 = arg[1] as? [String:Any] {
                        let value:CLValue = NamedArg.jsonToCLValue(input: arg1);
                        runtimeArg.argsItem = value;
                        runtimesArgList.append(runtimeArg);
                    }
                }
                retArgs = RuntimeArgs.fromListToRuntimeArgs(from: runtimesArgList)
            }
            retExecutionDeployItem = .ModuleBytes(module_bytes: moduleBytes,args: retArgs)
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
            var runtimesArgList:[NamedArg] = [NamedArg]();
            
            if let args = argsType["args"] as? [AnyObject] {
                var counter:Int = 0;
                for arg in args {
                    counter += 1;
                    let runtimeArg:NamedArg = NamedArg();
                    if let name = arg[0] as? String {
                        runtimeArg.name = name;
                    }
                    if let arg1 = arg[1] as? [String:Any] {
                        let value:CLValue = NamedArg.jsonToCLValue(input: arg1);
                        runtimeArg.argsItem = value;
                        runtimesArgList.append(runtimeArg);
                    }
                }
            }
            retExecutionDeployItem = .StoredContractByHash(hash:hash1, entry_point:entryPoint1,args:RuntimeArgs.fromListToRuntimeArgs(from: runtimesArgList))
        }
     
        if let argsType = from["StoredContractByName"] as? [String:Any] {
            var name:String = "";
            var entryPoint:String = "";
            var runtimesArgList:[NamedArg] = [NamedArg]();
            if let name1 = argsType["name"] as? String {
                name = name1;
            }
            if let entryPoint1 = argsType["entry_point"] as? String {
                entryPoint = entryPoint1
            }
            
            if let args = argsType["args"] as? [AnyObject] {
                var counter:Int = 0;
                for arg in args {
                    counter += 1;
                    let runtimeArg:NamedArg = NamedArg();
                    if let name1 = arg[0] as? String {
                        runtimeArg.name = name1;
                    }
                    if let arg1 = arg[1] as? [String:Any] {
                        let value:CLValue = NamedArg.jsonToCLValue(input: arg1);
                        runtimeArg.argsItem = value;
                        runtimesArgList.append(runtimeArg);
                    }
                }
            }
            retExecutionDeployItem = .StoredContractByName(name:name, entry_point:entryPoint, args:RuntimeArgs.fromListToRuntimeArgs(from: runtimesArgList))
        }
        
        if let argsType = from["StoredVersionedContractByHash"] as? [String:Any] {
            var hash:String = "";
            var version:UInt32?;
            var entryPoint:String = "";
            var runtimesArgList:[NamedArg] = [NamedArg]();
            if let hash1 = argsType["hash"] as? String {
                hash = hash1;
            }
            if let entryPoint1 = argsType["entry_point"] as? String {
                entryPoint = entryPoint1
            }
            if let version1 = argsType["version"] as? UInt32 {
                version = version1
            }
            
            if let args = argsType["args"] as? [AnyObject] {
                var counter:Int = 0;
                for arg in args {
                    counter += 1;
                    let runtimeArg:NamedArg = NamedArg();
                    if let name = arg[0] as? String {
                        runtimeArg.name = name;
                    }
                    if let arg1 = arg[1] as? [String:Any] {
                        let value:CLValue = NamedArg.jsonToCLValue(input: arg1);
                        runtimeArg.argsItem = value;
                        runtimesArgList.append(runtimeArg);
                    }
                }
            }
            retExecutionDeployItem = .StoredVersionedContractByHash(hash:hash, version:version , entry_point:entryPoint, args:RuntimeArgs.fromListToRuntimeArgs(from: runtimesArgList))
        }
       
        if let argsType = from["StoredVersionedContractByName"] as? [String:Any] {
            var name:String = "";
            var entryPoint:String = "";
            var version:UInt32?;
            if let name1 = argsType["name"] as? String {
                name = name1;
            }
            if let entryPoint1 = argsType["entry_point"] as? String {
                entryPoint = entryPoint1
            }
            if let version1 = argsType["version"] as? UInt32 {
                version = version1
            }
            var runtimesArgList:[NamedArg] = [NamedArg]();
            
            if let args = argsType["args"] as? [AnyObject] {
                var counter:Int = 0;
                for arg in args {
                    counter += 1;
                    let runtimeArg:NamedArg = NamedArg();
                    if let name = arg[0] as? String {
                        runtimeArg.name = name;
                    }
                    if let arg1 = arg[1] as? [String:Any] {
                        let value:CLValue = NamedArg.jsonToCLValue(input: arg1);
                        runtimeArg.argsItem = value;
                        runtimesArgList.append(runtimeArg);
                    }
                }
            }
            retExecutionDeployItem = .StoredVersionedContractByName(name:name, version:version , entry_point:entryPoint, args:RuntimeArgs.fromListToRuntimeArgs(from: runtimesArgList))
        }
       
        if let argsType = from["Transfer"] as? [String:Any] {
            var runtimesArgList:[NamedArg] = [NamedArg]();
            if let args = argsType["args"] as? [AnyObject] {
                var counter:Int = 0;
                for arg in args {
                    counter += 1;
                    let runtimeArg:NamedArg = NamedArg();
                    if let name = arg[0] as? String {
                        runtimeArg.name = name;
                    }
                    if let arg1 = arg[1] as? [String:Any] {
                        let value:CLValue = NamedArg.jsonToCLValue(input: arg1);
                        runtimeArg.argsItem = value;
                        runtimesArgList.append(runtimeArg);
                    }
                }
            }
            retExecutionDeployItem = .Transfer(args:RuntimeArgs.fromListToRuntimeArgs(from: runtimesArgList))
        }
        return retExecutionDeployItem
    }
    /**
        Function to get  json object from RuntimeArgs object
       - Parameter : a RuntimeArgs object
       - Returns: json object of Array - list somehow like this
     [[amount, {
         bytes = 04005ed0b2;
         "cl_type" = U512;
         parsed = 04005ed0b2;
     }], [target, {
         bytes = 02021172744b5e6bdc83a591b75765712e068e5d40a3be8ae360274fb26503b4ad38;
         "cl_type" = PublicKey;
         parsed = 02021172744b5e6bdc83a591b75765712e068e5d40a3be8ae360274fb26503b4ad38;
     }], [id, {
         bytes = 010000000000000000;
         "cl_type" =     {
             Option = U64;
         };
         parsed = 010000000000000000;
     }]]
     Because all the ExecutableDeployItemHelper use the RuntimeArgs item then this function is build for all ExecutableDeployItemHelper enum type to use when generate the Json object
       */
    public static func argsToJson(args:RuntimeArgs)->[[AnyObject]] {
        let ret : [[AnyObject]] = [];
        //let totalArg:Int = args.listNamedArg.count;
        if args.listNamedArg.count == 1 {
            do {
                let clValueJson = try args.listNamedArg[0].argsItem.toJsonObj()
                let argJson:[AnyObject] = [args.listNamedArg[0].name as AnyObject,clValueJson as AnyObject];
                let ret : [[AnyObject]] = [argJson]
                return ret
            } catch {
                
            }
        } else if args.listNamedArg.count == 2 {
            do {
                let clValueJson0 = try args.listNamedArg[0].argsItem.toJsonObj()
                let argJson0:[AnyObject] = [args.listNamedArg[0].name as AnyObject,clValueJson0 as AnyObject];
                let clValueJson1 = try args.listNamedArg[0].argsItem.toJsonObj()
                let argJson1:[AnyObject] = [args.listNamedArg[1].name as AnyObject,clValueJson1 as AnyObject];
                let ret : [[AnyObject]] = [argJson0 ,argJson1 ]
                return ret;
            } catch {
                
            }
        } else if args.listNamedArg.count == 3 {
            do {
                let clValueJson0 = try args.listNamedArg[0].argsItem.toJsonObj()
                let argJson0:[AnyObject] = [args.listNamedArg[0].name as AnyObject,clValueJson0 as AnyObject];
                
                let clValueJson1 = try args.listNamedArg[1].argsItem.toJsonObj()
                let argJson1:[AnyObject] = [args.listNamedArg[1].name as AnyObject,clValueJson1 as AnyObject];
                
                let clValueJson2 = try args.listNamedArg[2].argsItem.toJsonObj()
                let argJson2:[AnyObject] = [args.listNamedArg[2].name as AnyObject,clValueJson2 as AnyObject];
                
                let ret : [[AnyObject]] = [argJson0 ,argJson1,argJson2 ]
                return ret;
            } catch {
                
            }
        } else if args.listNamedArg.count == 4 {
            do {
                let clValueJson0 = try args.listNamedArg[0].argsItem.toJsonObj()
                let argJson0:[AnyObject] = [args.listNamedArg[0].name as AnyObject,clValueJson0 as AnyObject];
                
                let clValueJson1 = try args.listNamedArg[1].argsItem.toJsonObj()
                let argJson1:[AnyObject] = [args.listNamedArg[1].name as AnyObject,clValueJson1 as AnyObject];
                
                let clValueJson2 = try args.listNamedArg[2].argsItem.toJsonObj()
                let argJson2:[AnyObject] = [args.listNamedArg[2].name as AnyObject,clValueJson2 as AnyObject];
                
                let clValueJson3 = try args.listNamedArg[3].argsItem.toJsonObj()
                let argJson3:[AnyObject] = [args.listNamedArg[3].name as AnyObject,clValueJson3 as AnyObject];
                
                let ret : [[AnyObject]] = [argJson0,argJson1,argJson2,argJson3]
                return ret;
            } catch {
                
            }
        } else if args.listNamedArg.count == 5 {
            do {
                let clValueJson0 = try args.listNamedArg[0].argsItem.toJsonObj()
                let argJson0:[AnyObject] = [args.listNamedArg[0].name as AnyObject,clValueJson0 as AnyObject];
                
                let clValueJson1 = try args.listNamedArg[1].argsItem.toJsonObj()
                let argJson1:[AnyObject] = [args.listNamedArg[1].name as AnyObject,clValueJson1 as AnyObject];
                
                let clValueJson2 = try args.listNamedArg[2].argsItem.toJsonObj()
                let argJson2:[AnyObject] = [args.listNamedArg[2].name as AnyObject,clValueJson2 as AnyObject];
                
                let clValueJson3 = try args.listNamedArg[3].argsItem.toJsonObj()
                let argJson3:[AnyObject] = [args.listNamedArg[3].name as AnyObject,clValueJson3 as AnyObject];
                
                let clValueJson4 = try args.listNamedArg[4].argsItem.toJsonObj()
                let argJson4:[AnyObject] = [args.listNamedArg[4].name as AnyObject,clValueJson4 as AnyObject];
                
                let ret : [[AnyObject]] = [argJson0,argJson1,argJson2,argJson3, argJson4]
                return ret;
            } catch {
                
            }
        } else if args.listNamedArg.count == 6 {
            do {
                let clValueJson0 = try args.listNamedArg[0].argsItem.toJsonObj()
                let argJson0:[AnyObject] = [args.listNamedArg[0].name as AnyObject,clValueJson0 as AnyObject];
                
                let clValueJson1 = try args.listNamedArg[1].argsItem.toJsonObj()
                let argJson1:[AnyObject] = [args.listNamedArg[1].name as AnyObject,clValueJson1 as AnyObject];
                
                let clValueJson2 = try args.listNamedArg[2].argsItem.toJsonObj()
                let argJson2:[AnyObject] = [args.listNamedArg[2].name as AnyObject,clValueJson2 as AnyObject];
                
                let clValueJson3 = try args.listNamedArg[3].argsItem.toJsonObj()
                let argJson3:[AnyObject] = [args.listNamedArg[3].name as AnyObject,clValueJson3 as AnyObject];
                
                let clValueJson4 = try args.listNamedArg[4].argsItem.toJsonObj()
                let argJson4:[AnyObject] = [args.listNamedArg[4].name as AnyObject,clValueJson4 as AnyObject];
                
                
                let clValueJson5 = try args.listNamedArg[5].argsItem.toJsonObj()
                let argJson5:[AnyObject] = [args.listNamedArg[5].name as AnyObject,clValueJson5 as AnyObject];
                
                let ret : [[AnyObject]] = [argJson0,argJson1,argJson2,argJson3, argJson4,argJson5]
                return ret;
            } catch {
                
            }
        } else if args.listNamedArg.count == 7 {
            do {
                let clValueJson0 = try args.listNamedArg[0].argsItem.toJsonObj()
                let argJson0:[AnyObject] = [args.listNamedArg[0].name as AnyObject,clValueJson0 as AnyObject];
                
                let clValueJson1 = try args.listNamedArg[1].argsItem.toJsonObj()
                let argJson1:[AnyObject] = [args.listNamedArg[1].name as AnyObject,clValueJson1 as AnyObject];
                
                let clValueJson2 = try args.listNamedArg[2].argsItem.toJsonObj()
                let argJson2:[AnyObject] = [args.listNamedArg[2].name as AnyObject,clValueJson2 as AnyObject];
                
                let clValueJson3 = try args.listNamedArg[3].argsItem.toJsonObj()
                let argJson3:[AnyObject] = [args.listNamedArg[3].name as AnyObject,clValueJson3 as AnyObject];
                
                let clValueJson4 = try args.listNamedArg[4].argsItem.toJsonObj()
                let argJson4:[AnyObject] = [args.listNamedArg[4].name as AnyObject,clValueJson4 as AnyObject];
                
                
                let clValueJson5 = try args.listNamedArg[5].argsItem.toJsonObj()
                let argJson5:[AnyObject] = [args.listNamedArg[5].name as AnyObject,clValueJson5 as AnyObject];
                
                let clValueJson6 = try args.listNamedArg[6].argsItem.toJsonObj()
                let argJson6:[AnyObject] = [args.listNamedArg[6].name as AnyObject,clValueJson6 as AnyObject];
                
                let ret : [[AnyObject]] = [argJson0,argJson1,argJson2,argJson3, argJson4,argJson5, argJson6]
                return ret;
            } catch {
                
            }
        }  else if args.listNamedArg.count == 8 {
            do {
                let clValueJson0 = try args.listNamedArg[0].argsItem.toJsonObj()
                let argJson0:[AnyObject] = [args.listNamedArg[0].name as AnyObject,clValueJson0 as AnyObject];
                
                let clValueJson1 = try args.listNamedArg[1].argsItem.toJsonObj()
                let argJson1:[AnyObject] = [args.listNamedArg[1].name as AnyObject,clValueJson1 as AnyObject];
                
                let clValueJson2 = try args.listNamedArg[2].argsItem.toJsonObj()
                let argJson2:[AnyObject] = [args.listNamedArg[2].name as AnyObject,clValueJson2 as AnyObject];
                
                let clValueJson3 = try args.listNamedArg[3].argsItem.toJsonObj()
                let argJson3:[AnyObject] = [args.listNamedArg[3].name as AnyObject,clValueJson3 as AnyObject];
                
                let clValueJson4 = try args.listNamedArg[4].argsItem.toJsonObj()
                let argJson4:[AnyObject] = [args.listNamedArg[4].name as AnyObject,clValueJson4 as AnyObject];
                
                
                let clValueJson5 = try args.listNamedArg[5].argsItem.toJsonObj()
                let argJson5:[AnyObject] = [args.listNamedArg[5].name as AnyObject,clValueJson5 as AnyObject];
                
                let clValueJson6 = try args.listNamedArg[6].argsItem.toJsonObj()
                let argJson6:[AnyObject] = [args.listNamedArg[6].name as AnyObject,clValueJson6 as AnyObject];
                
                let clValueJson7 = try args.listNamedArg[7].argsItem.toJsonObj()
                let argJson7:[AnyObject] = [args.listNamedArg[7].name as AnyObject,clValueJson7 as AnyObject];
                
                let ret : [[AnyObject]] = [argJson0,argJson1,argJson2,argJson3, argJson4,argJson5, argJson6, argJson7]
                return ret;
            } catch {
                
            }
        } else if args.listNamedArg.count == 9 {
            do {
                let clValueJson0 = try args.listNamedArg[0].argsItem.toJsonObj()
                let argJson0:[AnyObject] = [args.listNamedArg[0].name as AnyObject,clValueJson0 as AnyObject];
                
                let clValueJson1 = try args.listNamedArg[1].argsItem.toJsonObj()
                let argJson1:[AnyObject] = [args.listNamedArg[1].name as AnyObject,clValueJson1 as AnyObject];
                
                let clValueJson2 = try args.listNamedArg[2].argsItem.toJsonObj()
                let argJson2:[AnyObject] = [args.listNamedArg[2].name as AnyObject,clValueJson2 as AnyObject];
                
                let clValueJson3 = try args.listNamedArg[3].argsItem.toJsonObj()
                let argJson3:[AnyObject] = [args.listNamedArg[3].name as AnyObject,clValueJson3 as AnyObject];
                
                let clValueJson4 = try args.listNamedArg[4].argsItem.toJsonObj()
                let argJson4:[AnyObject] = [args.listNamedArg[4].name as AnyObject,clValueJson4 as AnyObject];
                
                
                let clValueJson5 = try args.listNamedArg[5].argsItem.toJsonObj()
                let argJson5:[AnyObject] = [args.listNamedArg[5].name as AnyObject,clValueJson5 as AnyObject];
                
                let clValueJson6 = try args.listNamedArg[6].argsItem.toJsonObj()
                let argJson6:[AnyObject] = [args.listNamedArg[6].name as AnyObject,clValueJson6 as AnyObject];
                
                let clValueJson7 = try args.listNamedArg[7].argsItem.toJsonObj()
                let argJson7:[AnyObject] = [args.listNamedArg[7].name as AnyObject,clValueJson7 as AnyObject];
                
                
                let clValueJson8 = try args.listNamedArg[8].argsItem.toJsonObj()
                let argJson8:[AnyObject] = [args.listNamedArg[8].name as AnyObject,clValueJson8 as AnyObject];
                
                let ret : [[AnyObject]] = [argJson0,argJson1,argJson2,argJson3, argJson4,argJson5, argJson6, argJson7,argJson8]
                return ret;
            } catch {
                
            }
        }
        return ret;
    }
}
