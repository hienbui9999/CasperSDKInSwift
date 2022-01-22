import Foundation

public class ValidatorWeight {
    public var public_key:PublicKey = PublicKey();//PublicKey
    public var weight:U512Class = U512Class();//U512
    public func printMe() {
        print("public_key:\(public_key.value)")
        print("weight:\(weight.valueInStr)")
    }
}
