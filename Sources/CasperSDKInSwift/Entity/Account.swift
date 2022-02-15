import Foundation
/**
 Class for Account object
 */
public class Account {
    ///Account hash
    public var account_hash:AccountHash = AccountHash()
    ///List of NamedKey
    public var named_keys:[NamedKey]=[NamedKey]()
    ///Main purse
    public var main_purse:URef=URef();
    ///List of AssociatedKey
    public var associated_keys:[AssociatedKey] = [AssociatedKey]()
    ///Action threshold 
    public var action_thresholds: ActionThresholds = ActionThresholds()
}
