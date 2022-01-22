import Foundation

public class GetStatusResult {
    public var api_version:ProtocolVersion = ProtocolVersion();
    public var build_version:String = "";
    public var chainspec_name:String = "";
    public var last_added_block_info:MinimalBlockInfo = MinimalBlockInfo();
    public var peers:PeerMap = PeerMap();
    public var next_upgrade:NextUpgrade = NextUpgrade();
    public var our_public_signing_key :String = ""
    public var round_length:String = "";
    public var starting_state_root_hash:String = "";
    public var uptime : String = "";
}
