import Foundation
/*
 Failure {
        effect: ExecutionEffect,
        transfers: Vec<TransferAddr>,
        cost: U512,
        error_message: String,
    },
 */
/*
 Success {
       effect: ExecutionEffect,
       transfers: Vec<TransferAddr>,
       cost: U512,
   },
 */
public enum ExecutionResult {
    case Failure(ExecutionEffect,[TransferAddr], U512Class,String)
    case Success(ExecutionEffect,[TransferAddr],U512Class);
    case None
}
public class ExecutionResultHelper {
    public static func getExecutionResult(from:[String:Any])-> ExecutionResult {
        var retExecutionResult:ExecutionResult = .None
        if let success = from["Success"] as? [String:Any] {
            var retCost:U512Class = U512Class();
            var transferAddresses:[TransferAddr] = [TransferAddr]()
            var executionEffect:ExecutionEffect = ExecutionEffect();
            
            //cost
            if let cost = success["cost"] as? String {
                print("Cost in success:\(cost)")
                retCost = U512Class.fromStringToU512(from: cost)
            }
            
            //transfer
            if let transfersJson = success["transfers"] as? [String] {
                var counter:Int = 0;
                print("total transfer:\(transfersJson.count)")
                for transfer in transfersJson {
                    counter += 1;
                    print("transfer number :\(counter) value:\(transfer)")
                    let oneTrans : TransferAddr = TransferAddr.fromStrToTranferAddr(from: transfer)
                    transferAddresses.append(oneTrans)
                }
            }
            
            //ExecutionEffect
            if let effect = success["effect"] as? [String:Any] {
                executionEffect = ExecutionEffect.getExecutionEffect(from: effect);
            }
            return .Success(executionEffect, transferAddresses, retCost)
        } else  if let failure = from["Failure"] as? [String:Any] {
            //https://testnet.cspr.live/deploy/c452047f7029a20c9636f5bd2e7256c723c67a86079395bf9a4d0863c0df9675
            var retCost:U512Class = U512Class();
            var transferAddresses:[TransferAddr] = [TransferAddr]()
            var errorMessage:String = ""
            var executionEffect:ExecutionEffect = ExecutionEffect();
            if let cost = failure["cost"] as? String {
                print("In failure, cost:\(cost)")
                retCost = U512Class.fromStringToU512(from: cost)
            }
            if let error_message = failure["error_message"] as? String {
                print("In failure, error message:\(error_message)")
                errorMessage = error_message
            }
            if let transfersJson = failure["transfers"] as? [String] {
                var counter:Int = 0;
                print("Total transfer address:\(transfersJson.count)")
                for transfer in transfersJson {
                    counter += 1;
                    print("Transfer number :\(counter) value:\(transfer)")
                    let oneTrans : TransferAddr = TransferAddr.fromStrToTranferAddr(from: transfer)
                    transferAddresses.append(oneTrans)
                }
            }
            //get ExecutionEffect
            if let effect = failure["effect"] as? [String:Any] {
                executionEffect = ExecutionEffect.getExecutionEffect(from: effect);
            }
            return .Failure(executionEffect, transferAddresses, retCost, errorMessage)
        }
        return retExecutionResult;
    }
    
}
