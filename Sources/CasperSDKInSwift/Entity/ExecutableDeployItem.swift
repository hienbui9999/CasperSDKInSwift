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
                    var runtimeArg:NamedArg = NamedArg();
                    if let name = arg[0] as? String {
                        runtimeArg.name = name;
                    }
                    if let arg1 = arg[1] as? [String:Any] {
                        var value:CLValue = NamedArg.jsonToCLValue(input: arg1);
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
                    var runtimeArg:NamedArg = NamedArg();
                    if let name = arg[0] as? String {
                        runtimeArg.name = name;
                    }
                    if let arg1 = arg[1] as? [String:Any] {
                        var value:CLValue = NamedArg.jsonToCLValue(input: arg1);
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
                    var runtimeArg:NamedArg = NamedArg();
                    if let name1 = arg[0] as? String {
                        runtimeArg.name = name1;
                    }
                    if let arg1 = arg[1] as? [String:Any] {
                        var value:CLValue = NamedArg.jsonToCLValue(input: arg1);
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
                    var runtimeArg:NamedArg = NamedArg();
                    if let name = arg[0] as? String {
                        runtimeArg.name = name;
                    }
                    if let arg1 = arg[1] as? [String:Any] {
                        var value:CLValue = NamedArg.jsonToCLValue(input: arg1);
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
                    var runtimeArg:NamedArg = NamedArg();
                    if let name = arg[0] as? String {
                        runtimeArg.name = name;
                    }
                    if let arg1 = arg[1] as? [String:Any] {
                        var value:CLValue = NamedArg.jsonToCLValue(input: arg1);
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
                    var runtimeArg:NamedArg = NamedArg();
                    if let name = arg[0] as? String {
                        runtimeArg.name = name;
                    }
                    if let arg1 = arg[1] as? [String:Any] {
                        var value:CLValue = NamedArg.jsonToCLValue(input: arg1);
                        runtimeArg.argsItem = value;
                        runtimesArgList.append(runtimeArg);
                    }
                }
            }
            retExecutionDeployItem = .Transfer(args:RuntimeArgs.fromListToRuntimeArgs(from: runtimesArgList))
        }
        return retExecutionDeployItem
    }
}
