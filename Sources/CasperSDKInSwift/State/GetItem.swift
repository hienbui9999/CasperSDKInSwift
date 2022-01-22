import Foundation

class GetItem {
    
    public static func getItem(from:[String:Any]) ->GetItemResult {
        let retItem:GetItemResult = GetItemResult();
        if let result = from["result"] as? [String:Any] {
            if let api_version = result["api_version"] as? String {
                retItem.api_version = ProtocolVersion.strToProtocol(from: api_version)
            }
            if let storedValue = result["stored_value"] as? [String:Any] {
                retItem.stored_value = StoredValueHelper.getStoredValue(from: storedValue)
            }
            if let merkle_proof = result["merkle_proof"] as? String {
                retItem.merkle_proof = merkle_proof;
            }
        }
        return retItem;
    }
}
