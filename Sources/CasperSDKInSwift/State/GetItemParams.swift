import Foundation
/**
 Class represents the GetItemParams, used for sending parameter when call state_get_item RPC method
 */

public class GetItemParams {
    public var state_root_hash:String?
    public var key:String?
    public var path:[String]?
}
