import Foundation

public class EraSummary {
    public var block_hash:String=""
    public var era_id:UInt64=0
    public var stored_value:StoredValue = .None
    public var state_root_hash:String = ""
    public var merkle_proof:String = ""
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
