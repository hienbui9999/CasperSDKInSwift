import Foundation
/**
 Class represents the EraSummary
 */

public class EraSummary {
    ///Block hash
    public var block_hash:String=""
    ///Era id
    public var era_id:UInt64=0
    ///Stored value - enumeration type value
    public var stored_value:StoredValue = .None
    ///State root hash
    public var state_root_hash:String = ""
    ///Merkle proof string
    public var merkle_proof:String = ""
    /**
        Get EraSummary object from Json string
        - Parameter : a Json String represents the EraSummary object
        - Returns: EraSummary object
        */

    public static func getEraSummaryFromJson(from:[String:Any]) -> EraSummary {
        let retResult:EraSummary = EraSummary();
        if let block_hash = from["block_hash"] as? String {
            retResult.block_hash = block_hash
        }
        if let eraId = from["era_id"] as? UInt64{
            retResult.era_id = eraId
        }
        if let storedValue = from["stored_value"] as? [String:Any]{
            retResult.stored_value = StoredValueHelper.getStoredValue(from: storedValue)
        }
        if let stateRootHash = from["state_root_hash"] as? String {
            retResult.state_root_hash = stateRootHash
        }
        if let merkleProof = from["merkle_proof"] as? String {
            retResult.merkle_proof = merkleProof;
        }
        return retResult 
    }
}
