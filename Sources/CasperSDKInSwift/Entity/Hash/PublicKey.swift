import Foundation
/*
 pub enum PublicKey {
     System,
     Ed25519(PublicKey),
     Secp256k1(Secp256k1PublicKey),
 }
 */
/**
 Class represents the PublicKey
 */
public class PublicKey {
    public var value:String=""
    /**
       Build PublicKey object from string
       - Parameter : a  String represents the PublicKey object
       - Returns: PublicKey object
       */
    public static func strToPublicKey(from:String)->PublicKey {
        let ret:PublicKey = PublicKey();
        ret.value = from;
        return ret;
    }
}
