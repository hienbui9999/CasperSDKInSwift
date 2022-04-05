import Foundation
/**
 Class represents the EntryPoint
 */

public class EntryPoint {
    /// Name
    public var name: String!
    /// Entry point type
    public var entryPointType: String!
    /// Access
    public var access: String!
    /// ret of CLType
    public var ret: CLType!
    /// Args - a list of NamedCLTypeArg object
    public var args: [NamedCLTypeArg]!
}
