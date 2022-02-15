import Foundation
/**
 class represent the GetBlockTransfersResult
 */
public class GetBlockTransfersResult {
    ///the Casper api version
    public var api_version:ProtocolVersion=ProtocolVersion()
    //the block hash of the block
    public var block_hash:String = ""
    //the transfer list of the block
    public var transfers:[Transfer]?
}
