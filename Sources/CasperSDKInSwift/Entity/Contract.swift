import Foundation
public class Contract {
    public var contract_package_hash:String!
    public var contract_wasm_hash:String!
    public var named_keys:[NamedKey]!
    public var entry_points:[EntryPoint]!
    public var protocol_version:ProtocolVersion!
}
