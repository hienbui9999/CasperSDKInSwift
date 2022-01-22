import Foundation
public class GetBlockTransfersResult {
    public var api_version:ProtocolVersion=ProtocolVersion()
    public var block_hash:String = ""
    public var transfers:[Transfer]?
}
