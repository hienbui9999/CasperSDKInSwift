import Foundation
/**
 Class represents the Contract
 */

public class Contract {
    public var contract_package_hash:String!
    public var contract_wasm_hash:String!
    ///A list of NamedKey
    public var named_keys:[NamedKey]!
    ///A list of EntryPoint
    public var entry_points:[EntryPoint]!
    public var protocol_version:ProtocolVersion!
}
