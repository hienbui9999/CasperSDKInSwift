import Foundation
/**
 Class represents the EraSummary
 */

public class EraSummary {
    /// Block hash
    public var blockHash: String=""
    /// Era id
    public var eraId: UInt64=0
    /// Stored value - enumeration type value
    public var storedValue: StoredValue = .none
    /// State root hash
    public var stateRootHash: String = ""
    /// Merkle proof string
    public var merkleProof: String = ""
    /**
        Get EraSummary object from Json string
        - Parameter : a Json String represents the EraSummary object
        - Returns: EraSummary object
        */

    public static func getEraSummaryFromJson(from: [String: Any]) -> EraSummary {
        let retResult: EraSummary = EraSummary()
        if let blockHash1 = from["block_hash"] as? String {
            retResult.blockHash = blockHash1
        }
        if let eraId = from["era_id"] as? UInt64 {
            retResult.eraId = eraId
        }
        if let storedValue = from["stored_value"] as? [String: Any] {
            retResult.storedValue = StoredValueHelper.getStoredValue(from: storedValue)
        }
        if let stateRootHash = from["state_root_hash"] as? String {
            retResult.stateRootHash = stateRootHash
        }
        if let merkleProof = from["merkle_proof"] as? String {
            retResult.merkleProof = merkleProof
        }
        return retResult
    }

}
