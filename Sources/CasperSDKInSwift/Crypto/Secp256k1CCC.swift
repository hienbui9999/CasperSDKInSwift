import Foundation
import SwiftECC
import secp256k1
import Security.SecImportExport
class Secp256k1C {
    func signForMessage(message:String) throws -> String {
        var ret:String = ""
        let folder: String = "Assets/Secp256k1/"
        let readPrivateKeyPemFile: String    = folder + "ReadSwiftPrivateKeySecp256k1.pem"
        let thisSourceFile = URL(fileURLWithPath: #file)
        let thisDirectory = thisSourceFile.deletingLastPathComponent()
        let resourceURL = thisDirectory.appendingPathComponent(readPrivateKeyPemFile)
        do {
            var text2 = try String(contentsOf: resourceURL, encoding: .utf8)
            if !text2.contains(prefixPemPrivateStr) && !text2.contains(prefixPemPrivateECStr) {
                throw PemFileHandlerError.invalidPemKeyPrefix
            }
            if !text2.contains(suffixPemPrivateStr) && !text2.contains(suffixPemPrivateECStr) {
                throw PemFileHandlerError.invalidPemKeySuffix
            }
            if text2.contains(prefixPemPrivateStr) {
                text2 = text2.replacingOccurrences(of: prefixPemPrivateStr, with: prefixPemPrivateECStr)
                text2 = text2.replacingOccurrences(of: suffixPemPrivateStr, with: suffixPemPrivateECStr)
            }
            let privateKey = try ECPrivateKey.init(pem: text2)
            let ctx = secp256k1_context_create(UInt32(SECP256K1_CONTEXT_SIGN));
            var pk_secp256k1_pubkey : UnsafeMutablePointer<secp256k1_pubkey> = UnsafeMutablePointer<secp256k1_pubkey>.allocate(capacity: 1);
            let mA:[UInt8] = message.hexaBytes
            let signature : UnsafeMutablePointer<secp256k1_ecdsa_signature> = UnsafeMutablePointer<secp256k1_ecdsa_signature>.allocate(capacity: 1);
            if ctx != nil {
                let validPrivateKey = secp256k1_ec_seckey_verify(ctx!,privateKey.s.asMagnitudeBytes());
                let resultCreatePublicKey = secp256k1_ec_pubkey_create(ctx!,pk_secp256k1_pubkey,privateKey.s.asSignedBytes());
                let resultSign = secp256k1_ecdsa_sign(ctx!,signature,mA,privateKey.s.asSignedBytes(),nil,nil);
                var array: [UInt8] {
                        withUnsafeBytes(of: signature.pointee.data) { buf in
                            [UInt8](buf)
                        }
                    }
                ret = array.data.hexEncodedString()
            }
            //verify message
            let ctx2 = secp256k1_context_create(UInt32(SECP256K1_CONTEXT_VERIFY))
            if ctx2 != nil {
                let resultVerifyMessage = secp256k1_ecdsa_verify(ctx2!,signature,mA,pk_secp256k1_pubkey);
            }
            
        } catch {
            throw PemFileHandlerError.invalidPemKeyFormat
        }
        return ret
    }
    
}
