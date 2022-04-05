import Foundation
/**
 Class for Account object
 */
public class Account {
    /// Account hash
    public var accountHash: AccountHash = AccountHash()
    /// List of NamedKey
    public var namedKeys: [NamedKey]=[NamedKey]()
    /// Main purse
    public var mainPurse: URef=URef()
    /// List of AssociatedKey
    public var associatedKeys: [AssociatedKey] = [AssociatedKey]()
    /// Action threshold
    public var actionThresholds: ActionThresholds = ActionThresholds()
}
