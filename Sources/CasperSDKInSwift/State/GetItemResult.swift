import Foundation
/**
 Class represents the GetItemResult, the result retrieved back when call state_get_item RPC method
 */

public class GetItemResult {
    public var api_version:ProtocolVersion!
    public var stored_value:StoredValue!
    public var merkle_proof:String!
}
