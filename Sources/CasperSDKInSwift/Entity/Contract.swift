import Foundation
/**
 Class represents the Contract
 */

public class Contract {
    ///Contract package hash
    public var contract_package_hash:String!
    ///Contract wasm hash
    public var contract_wasm_hash:String!
    ///A list of NamedKey
    public var named_keys:[NamedKey]!
    ///A list of EntryPoint
    public var entry_points:[EntryPoint]!
    ///Protocol version
    public var protocol_version:ProtocolVersion!
}
