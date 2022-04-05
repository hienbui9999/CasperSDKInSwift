import Foundation
/**
 Class represents the GetBlockTransfersResult
 */
public class GetBlockTransfersResult {
    // /the Casper api version
    public var apiVersion: ProtocolVersion=ProtocolVersion()
    // the block hash of the block
    public var blockHash: String = ""
    // the transfer list of the block
    public var transfers: [Transfer]?
}
