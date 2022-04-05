import Foundation
/**
 Class represents the GetBalanceResult
 */

public class GetBalanceResult {
    public var apiVersion: ProtocolVersion = ProtocolVersion()
    public var balanceValue: U512Class = U512Class()
    public var merkleProof: String = ""
}
