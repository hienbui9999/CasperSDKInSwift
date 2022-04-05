import Foundation
/**
 Class represents the GetItemParams, used for sending parameter when call state_get_item RPC method
 */

public class GetItemParams {
    public var stateRootHash: String?
    public var key: String?
    public var path: [String]?
}
