import Foundation
/**
 Class represents the JsonEraReport
 */

public class JsonEraReport {
    /// List of equivocator in PublicKey format
    public var equivocators: [PublicKey] = [PublicKey]()
    /// List of inactiveValidator in PublicKey format
    public var inactiveValidators: [PublicKey] = [PublicKey]()
    /// List of reward
    public var rewards: [Reward] = [Reward]()
}
