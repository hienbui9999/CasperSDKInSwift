import Foundation

public enum ExecutableDeployItem {
    case ModuleBytes (module_bytes:Bytes, args: RuntimeArgs)
    case StoredContractByHash(String,String,RuntimeArgs)
    case StoredContractByName(String,String,RuntimeArgs)
    case StoredVersionedContractByHash (String,UInt32?,String,RuntimeArgs)
    case StoredVersionedContractByName(String,UInt32?,String,RuntimeArgs)
    case Transfer(RuntimeArgs)
    case NONE
}
public class ExecutableDeployItemHelper {
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
            retExecutionDeployItem = .StoredContractByHash(hash1, entryPoint1,RuntimeArgs.fromListToRuntimeArgs(from: runtimesArgList))
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
            retExecutionDeployItem = .StoredContractByName(hash1, entryPoint1, RuntimeArgs.fromListToRuntimeArgs(from: runtimesArgList))
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
            retExecutionDeployItem = .StoredVersionedContractByHash(hash1, 2 , entryPoint1, RuntimeArgs.fromListToRuntimeArgs(from: runtimesArgList))
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
            retExecutionDeployItem = .StoredVersionedContractByName(hash1, 2 , entryPoint1, RuntimeArgs.fromListToRuntimeArgs(from: runtimesArgList))
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
            retExecutionDeployItem = .Transfer(RuntimeArgs.fromListToRuntimeArgs(from: runtimesArgList))
        }
        return retExecutionDeployItem
    }
}
