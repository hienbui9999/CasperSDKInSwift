//
//  File.swift
//  
//
//  Created by Hien on 25/12/2021.
//

import Foundation
public class Deploy { //5 items
    public var hash:String = "";
    public var approvals:[DeployApprovalItem] = [DeployApprovalItem]();
    public var header:DeployHeader = DeployHeader();
    public var payment:ExecutableDeployItem?;
    public var session:ExecutableDeployItem?;
    public func printMe () {
        switch payment {
        case .ModuleBytes(let moduleBytes, let runtimeArgs) :
            print("Payment is modulebytes")
            let count = runtimeArgs.count;
            //print("module byte:\(moduleBytes),totalElement:\(count)")
            break;
        case .StoredContractByHash(let hash, let entryPoint , let runtimeArgs):
            print("Payment is storedCOntractByHash")
            let count = runtimeArgs.count;
            print("StoredContractByHash, hash:\(hash), entryPoint:\(entryPoint), totalRunTimeArgs:\(count)")
            break;
        default:
            break;
        }
        switch session {
        case .ModuleBytes(let moduleBytes, let runtimeArgs) :
            print("session is modulebytes")
            let count = runtimeArgs.count;
            print("module byte, too long,totalElement:\(count)")
            for arg in runtimeArgs {
                arg.printMe()
            }
            break;
        case .StoredContractByHash(let hash, let entryPoint , let runtimeArgs):
            print("session is storedcontracbyHash")
            let count = runtimeArgs.count;
            print("StoredContractByHash, hash:\(hash), entryPoint:\(entryPoint), totalRunTimeArgs:\(count)")
            var counter:Int = 1;
            for arg in runtimeArgs {
                print("item \(counter)")
                counter += 1
                arg.printMe()
            }
            break;
        case .Transfer(let runtimeArgs) :
            print("session is Transfer")
            let count = runtimeArgs.count;
            print("module byte, too long,totalElement:\(count)")
            for arg in runtimeArgs {
                arg.printMe()
            }
            break;
        default:
            break;
        }
    }
}
public class DeployApprovalItem {
    public var signature:String = "";//130 chars
    public var signer:String = "";//01d9bf2148748a85c89da5aad8ee0b0fc2d105fd39d41a4c796536354f0ae2900c
}


