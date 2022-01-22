import Foundation
/*
 {
     "id": 1,
     "jsonrpc": "2.0",
     "method": "state_get_item",
     "params": [
         "55364b5e333574cb4b1be3efc2662e5f6816df70a890cd165c2d09242bf5941b",
         "account-hash-c3ee84a05a222e512b9fb93997458e5fce70aa7dfed8bb19f0871bf7b0230154"
     ]
 }
 */
public class GetItemParams {
    public var state_root_hash:String?
    public var key:String?
    public var path:[String]?
}
