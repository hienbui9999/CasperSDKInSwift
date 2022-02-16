import Foundation
/**
 Class represents the ContractPackage
 */

public class ContractPackage {
    ///Accesss key as in URef
    public var access_key:URef!
    ///A list of ContractVersion
    public var versions:[ContractVersion]!
    ///A list of DisableVersion
    public var disabled_versions:[DisableVersion]!
    ///A list of Group
    public var groups:[Groups]!
}
