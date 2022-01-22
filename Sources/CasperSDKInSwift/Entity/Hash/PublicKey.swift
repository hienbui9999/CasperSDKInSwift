import Foundation
/*
 pub enum PublicKey {
     System,
     Ed25519(PublicKey),
     Secp256k1(Secp256k1PublicKey),
 }
 */
public class PublicKey {
    public var value:String=""
    public static func strToPublicKey(from:String)->PublicKey {
        let ret:PublicKey = PublicKey();
        ret.value = from;
        return ret;
    }
}
