import Foundation
/**
 Class represents the UnbondingPurse
 */

public class UnbondingPurse {
    public var bondingPurse: URef!
    public var amount: U512Class!
    public var validatorPublicKey: PublicKey!
    public var unbonderPublicKey: PublicKey!
    public var eraOfCreation: UInt64=0
}
