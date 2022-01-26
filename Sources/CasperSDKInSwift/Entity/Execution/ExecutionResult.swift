import Foundation

public enum ExecutionResult {
    case Failure(effect:ExecutionEffect,transfers:[TransferAddr], cost:U512Class,error_message:String)
    case Success(effect:ExecutionEffect,transfers:[TransferAddr],cost:U512Class);
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
                retCost = U512Class.fromStringToU512(from: cost)
            }
            
            //transfer
            if let transfersJson = success["transfers"] as? [String] {
                var counter:Int = 0;
                for transfer in transfersJson {
                    counter += 1;
                    let oneTrans : TransferAddr = TransferAddr.fromStrToTranferAddr(from: transfer)
                    transferAddresses.append(oneTrans)
                }
            }
            //ExecutionEffect
            if let effect = success["effect"] as? [String:Any] {
                executionEffect = ExecutionEffect.getExecutionEffect(from: effect);
            }
            return .Success(effect:executionEffect, transfers:transferAddresses, cost:retCost)
        } else  if let failure = from["Failure"] as? [String:Any] {
            var retCost:U512Class = U512Class();
            var transferAddresses:[TransferAddr] = [TransferAddr]()
            var errorMessage:String = ""
            var executionEffect:ExecutionEffect = ExecutionEffect();
            if let cost = failure["cost"] as? String {
                retCost = U512Class.fromStringToU512(from: cost)
            }
            if let error_message = failure["error_message"] as? String {
                errorMessage = error_message
            }
            if let transfersJson = failure["transfers"] as? [String] {
                var counter:Int = 0;
                for transfer in transfersJson {
                    counter += 1;
                    let oneTrans : TransferAddr = TransferAddr.fromStrToTranferAddr(from: transfer)
                    transferAddresses.append(oneTrans)
                }
            }
            //get ExecutionEffect
            if let effect = failure["effect"] as? [String:Any] {
                executionEffect = ExecutionEffect.getExecutionEffect(from: effect);
            }
            return .Failure(effect:executionEffect,transfers: transferAddresses, cost:retCost, error_message:errorMessage)
        }
        return retExecutionResult;
    }
    
}
