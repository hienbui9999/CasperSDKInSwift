import Foundation
/**
 Class represents the Transfer
 */

public class Transfer{
    public var amount:U512Class!
    public var deploy_hash:String!
    public var from:String!
    public var gas:U512Class!
    public var source:URef!
    public var target:URef!
    public var to:String?
    public var id:UInt64?
    /**
       Get Transfer object from Json string
       - Parameter : a Json String represents the Transfer object
       - Returns: Transfer object
       */

    public static func fromJsonToTransfer(from:[String:Any])->Transfer {
        let transfer:Transfer = Transfer();
        if let deploy_hash = from["deploy_hash"] as? String {
            transfer.deploy_hash = deploy_hash
        }
        if let fromHash = from["from"] as? String {
            transfer.from = fromHash
        }
        if let to = from["to"] as? String {
            transfer.to = to
        }
        if let source = from["source"] as? String {
            transfer.source = URef.fromStringToUref(from: source)
        }
        if let target = from["target"] as? String {
            transfer.target = URef.fromStringToUref(from: target)
        }
        if let amount = from["amount"] as? String {
            transfer.amount = U512Class.fromStringToU512(from: amount)
        }
        if let gas = from["gas"] as? String {
            transfer.gas = U512Class.fromStringToU512(from: gas)
        }
        if let id = from["id"] as? UInt64 {
            transfer.id = id
        }
        return transfer
    }
}
