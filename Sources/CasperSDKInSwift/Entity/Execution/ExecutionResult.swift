import Foundation
/**
 Enumeration type represents the ExecutionResult
 */

public enum ExecutionResult {
    case failure(effect: ExecutionEffect, transfers: [TransferAddr], cost: U512Class, error_message: String)
    case success(effect: ExecutionEffect, transfers: [TransferAddr], cost: U512Class)
    case none
}
/**
 Class provides the supported method for  getting the ExecutionResult
 */

public class ExecutionResultHelper {
    /**
       Get ExecutionResult object from Json string
       - Parameter : a Json String represents the ExecutionResult object
       - Returns: ExecutionResult object
       */

    public static func getExecutionResult(from: [String: Any]) -> ExecutionResult {
        let retExecutionResult: ExecutionResult = .none
        /// Check if the result is Success then return the ExecutionResult as Success type
        if let success = from["Success"] as? [String: Any] {
            var retCost: U512Class = U512Class()
            var transferAddresses: [TransferAddr] = [TransferAddr]()
            var executionEffect: ExecutionEffect = ExecutionEffect()
            /// Getting cost
            if let cost = success["cost"] as? String {
                retCost = U512Class.fromStringToU512(from: cost)
            }
            /// Getting TransferAddr
            if let transfersJson = success["transfers"] as? [String] {
                var counter: Int = 0
                for transfer in transfersJson {
                    counter += 1
                    let oneTrans: TransferAddr = TransferAddr.fromStrToTranferAddr(from: transfer)
                    transferAddresses.append(oneTrans)
                }
            }
            // Getting ExecutionEffect
            if let effect = success["effect"] as? [String: Any] {
                executionEffect = ExecutionEffect.getExecutionEffect(from: effect)
            }
            return .success(effect: executionEffect, transfers: transferAddresses, cost: retCost)
        }
        /// Check if the result is Failure then return the ExecutionResult as Failure type
        else  if let failure = from["Failure"] as? [String: Any] {
            var retCost: U512Class = U512Class()
            var transferAddresses: [TransferAddr] = [TransferAddr]()
            var errorMessage: String = ""
            var executionEffect: ExecutionEffect = ExecutionEffect()
            if let cost = failure["cost"] as? String {
                retCost = U512Class.fromStringToU512(from: cost)
            }
            if let errorMessage1 = failure["error_message"] as? String {
                errorMessage = errorMessage1
            }
            /// Getting TransferAddr
            if let transfersJson = failure["transfers"] as? [String] {
                var counter: Int = 0
                for transfer in transfersJson {
                    counter += 1
                    let oneTrans: TransferAddr = TransferAddr.fromStrToTranferAddr(from: transfer)
                    transferAddresses.append(oneTrans)
                }
            }
            /// Getting ExecutionEffect
            if let effect = failure["effect"] as? [String: Any] {
                executionEffect = ExecutionEffect.getExecutionEffect(from: effect)
            }
            return .failure(effect: executionEffect, transfers: transferAddresses, cost: retCost, error_message: errorMessage)
        }
        return retExecutionResult
    }

}
