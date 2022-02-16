import Foundation
/**
 Class represents the GetStatusResult, in which the peer list is declared in a PeerMap object
 */

public class GetStatusResult {
    public var api_version:ProtocolVersion = ProtocolVersion();
    public var build_version:String = "";
    public var chainspec_name:String = "";
    public var last_added_block_info:MinimalBlockInfo = MinimalBlockInfo();
    ///The  peer list, retrieve from attribute [PeerEntry]  in PeerMap object
    public var peers:PeerMap = PeerMap();
    public var next_upgrade:NextUpgrade = NextUpgrade();
    public var our_public_signing_key :String = ""
    public var round_length:String = "";
    public var starting_state_root_hash:String = "";
    public var uptime : String = "";
}
