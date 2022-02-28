import Foundation
import secp256k1
import CryptoKit
//manual from this https://github.com/bitcoin-core/secp256k1/tree/master/include
public class Secp256k1Crypto {
    public func secp256k1GenerateKey() {
        ///private generation using Swift built in library
        let privateKey = P256.Signing.PrivateKey.init(compactRepresentable: true).rawRepresentation;
        //print("private key for P256 is:\(privateKey.base64EncodedString())")
        //print("private key bytes count:\(privateKey.bytes.count)")
        print(privateKey.bytes)
        ///context for handling public key generation and  signing
        let ctx = secp256k1_context_create(UInt32(SECP256K1_CONTEXT_SIGN));
        let signature : UnsafeMutablePointer<secp256k1_ecdsa_signature> = UnsafeMutablePointer<secp256k1_ecdsa_signature>.allocate(capacity: 1);
        var messageToSignInHexa : String = "020e0000006361737065722d6578616d706c65130000006578616d706c652d656e7472792d706f696e7401000000080000007175616e7469747904000000e803000001050100000006000000616d6f756e7404000000e803000001";
        messageToSignInHexa = "01d9bf2148748a85c89da5aad8ee0b0fc2d105fd39d41a4c796536354f0ae2900ca856a4d37501000080ee36000000000001000000000000004811966d37fe5674a8af4001884ea0d9042d1c06668da0c963769c3a01ebd08f0100000001010101010101010101010101010101010101010101010101010101010101010e0000006361737065722d6578616d706c65";
        let messageToSignHexaToArray:[UInt8] = messageToSignInHexa.hexaData.reversed()
        let messageToSignArray = messageToSignInHexa.bytes;
        let messageToSign : UnsafePointer<UInt8> = UnsafePointer(messageToSignArray);
        ///public key generation
          var pk_secp256k1_pubkey : UnsafeMutablePointer<secp256k1_pubkey> = UnsafeMutablePointer<secp256k1_pubkey>.allocate(capacity: 1);
        if ctx != nil {
            privateKey.withUnsafeBytes { (unsafeBytes) in
                let privateKeyBytes = unsafeBytes.bindMemory(to: UInt8.self).baseAddress!
                ///check private key valid
                let validPrivateKey = secp256k1_ec_seckey_verify(ctx!,privateKeyBytes);
                ///make the public key available through the call function
                let result = secp256k1_ec_pubkey_create(ctx!,pk_secp256k1_pubkey,privateKeyBytes);
                ///print the public key back, now in tuple type
                let publicKey = pk_secp256k1_pubkey.pointee.data;
                ///public key from tuple to array
                var array :[UInt8] = withUnsafeBytes(of:publicKey) {
                    buf in
                    [UInt8] (buf)
                }
                ///sign a message
                var signatureSForm : UnsafeMutablePointer<secp256k1_ecdsa_signature> = UnsafeMutablePointer<secp256k1_ecdsa_signature>.allocate(capacity: 1);
                let resultSign = secp256k1_ecdsa_sign(ctx!,signature,messageToSign,privateKeyBytes,nil,nil);
                let changeSignatureToSFormSuccess =  secp256k1_ecdsa_signature_normalize(ctx!,signatureSForm,signature);
               
            }
            
        } else {
            NSLog("Context creation failed")
        }
        let ctx2 = secp256k1_context_create(UInt32(SECP256K1_CONTEXT_VERIFY))
        if ctx2 != nil {
         
            let resultVerifyMessage = secp256k1_ecdsa_verify(ctx2!,signature,messageToSign,pk_secp256k1_pubkey);
            var arraySignedMessage :[UInt8] = withUnsafeBytes(of:signature.pointee.data) {
                buf in
                [UInt8] (buf)
            }
           // print("02" + arraySignedMessage.data.hexEncodedString())
        }
        
    }
}
