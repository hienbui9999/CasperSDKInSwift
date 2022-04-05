import Foundation
/**
 Class represents the GetItemResult, the result retrieved back when call state_get_item RPC method
 */

public class GetItemResult {
    public var apiVersion: ProtocolVersion!
    public var storedValue: StoredValue!
    public var merkleProof: String!
}
