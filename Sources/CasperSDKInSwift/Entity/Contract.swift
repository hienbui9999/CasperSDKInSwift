import Foundation
/**
 Class represents the Contract
 */

public class Contract {
    /// Contract package hash
    public var contractPackageHash: String!
    /// Contract wasm hash
    public var contractWasmHash: String!
    /// A list of NamedKey
    public var namedKeys: [NamedKey]!
    /// A list of EntryPoint
    public var entryPoints: [EntryPoint]!
    /// Protocol version
    public var protocolVersion: ProtocolVersion!
}
