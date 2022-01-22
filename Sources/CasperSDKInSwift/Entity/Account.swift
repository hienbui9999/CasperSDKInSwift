import Foundation
public class Account {
    public var account_hash:AccountHash = AccountHash()
    public var named_keys:[NamedKey]=[NamedKey]()
    public var main_purse:URef=URef();
    public var associated_keys:[AssociatedKey] = [AssociatedKey]()
    public var action_thresholds: ActionThresholds = ActionThresholds()
}
