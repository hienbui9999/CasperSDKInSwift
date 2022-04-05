import Foundation
/**
 Class represents the ContractPackage
 */

public class ContractPackage {
    /// Accesss key as in URef
    public var accessKey: URef!
    /// A list of ContractVersion
    public var versions: [ContractVersion]!
    /// A list of DisableVersion
    public var disabledVersions: [DisableVersion]!
    /// A list of Group
    public var groups: [Groups]!
}
