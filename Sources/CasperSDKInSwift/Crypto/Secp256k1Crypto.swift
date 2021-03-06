import Foundation
import SwiftECC
/**
 Secp256k1 wrapper class. This class allow user to do the following task in secp256k1 encryption:
 - Generate private key, public key
 - Load private key, public key from Pem file
 - Write private key, public key to Pem file
 - Sign message
 - Verify message
 */
public class Secp256k1Crypto {
/**
   Read Private key from a Pem file.
   - Parameter: Pem file name and URL
   - Returns: ECPrivateKey of type secp256k1
   */

    public func readPrivateKeyFromFile(pemFileName: String) throws -> ECPrivateKey {
       
        let thisSourceFile = URL(fileURLWithPath: #file)
        let thisDirectory = thisSourceFile.deletingLastPathComponent()
        let resourceURL = thisDirectory.appendingPathComponent(pemFileName)
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
            let domain = Domain.instance(curve: .EC256k1)
            
            let privateKey2 = try ECPrivateKey.init(domain: domain, s: privateKey.s)
            return privateKey2
        } catch {
            throw PemFileHandlerError.invalidPemKeyFormat
        }
    }

    public func readPublicKeyFromFile(pemFileName: String) throws -> ECPublicKey {
        let thisSourceFile = URL(fileURLWithPath: #file)
        let thisDirectory = thisSourceFile.deletingLastPathComponent()
        let resourceURL = thisDirectory.appendingPathComponent(pemFileName)
        do {
        var text2 = try String(contentsOf: resourceURL, encoding: .utf8)
            if !text2.contains(prefixPemPublicStr) && !text2.contains(prefixPemPublicECStr) {
                throw PemFileHandlerError.invalidPemKeyPrefix
            }
            if !text2.contains(suffixPemPublicStr) && !text2.contains(suffixPemPublicECStr) {
                throw PemFileHandlerError.invalidPemKeySuffix
            }
            if text2.contains(prefixPemPublicStr) {
                text2 = text2.replacingOccurrences(of: prefixPemPublicECStr, with: prefixPemPublicStr)
                text2 = text2.replacingOccurrences(of: suffixPemPublicECStr, with: suffixPemPublicStr)
            }
            text2 = text2.trimmingCharacters(in: .whitespaces)
            let publicKey = try ECPublicKey.init(pem: text2)
            return publicKey
        } catch {
            throw PemFileHandlerError.invalidPemKeyFormat
        }
    }

    public func writePrivateKeyToPemFile(privateKeyToWrite: ECPrivateKey, fileName: String) throws -> Bool {
        let text = privateKeyToWrite.pem
        let thisSourceFile = URL(fileURLWithPath: #file)
        let thisDirectory = thisSourceFile.deletingLastPathComponent()
        let fileURL = thisDirectory.appendingPathComponent(fileName)
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
            } catch {
               //  NSLog("Secp256k1 Private key file does not exist, about to create new one!")
            }
           //  NSLog("Delete auto generated Secp256k1 private file.")
        }
        do {
            try text.write(to: fileURL, atomically: false, encoding: .utf8)
            return true
        }
        catch {
            throw PemFileHandlerError.writePemFileError
        }
    }

    public func writePublicKeyToPemFile(publicKeyToWrite: ECPublicKey, fileName: String) throws -> Bool {
        let text = publicKeyToWrite.pem
        let thisSourceFile = URL(fileURLWithPath: #file)
        let thisDirectory = thisSourceFile.deletingLastPathComponent()
        let fileURL = thisDirectory.appendingPathComponent(fileName)
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
            } catch {
              //   NSLog("Secp256k1 Public key file does not exist, about to create new one!")
            }
           //  NSLog("Delete auto generated Secp256k1 public file.")
        }
        do {
            try text.write(to: fileURL, atomically: false, encoding: .utf8)
            return true
        }
        catch {
            throw PemFileHandlerError.writePemFileError
        }
    }

    public func secp256k1GenerateKey() -> (ECPrivateKey, ECPublicKey) {
        let domain = Domain.instance(curve: .EC256k1)
        let (publicKey, privateKey) = domain.makeKeyPair()
        return (privateKey, publicKey)
    }

    public func signMessage(messageToSign: Data, withPrivateKey: ECPrivateKey) -> ECSignature {
     /*   let signatureF = withPrivateKey.sign(msg: messageToSign, deterministic: false)
        let signatureF1 = withPrivateKey.sign(msg: messageToSign, deterministic: false)
        let signatureF2 = withPrivateKey.sign(msg: messageToSign, deterministic: false)
        let signatureT = withPrivateKey.sign(msg: messageToSign, deterministic: true)*/
        let signature = withPrivateKey.sign(msg: messageToSign, deterministic: false)
       // withPrivateKey.si
        let domain = Domain.instance(curve: .EC256k1)
        let signature2 = ECSignature.init(domain: domain, r: signature.r, s: signature.s)
        return signature2
    }

    public func verifyMessage(withPublicKey: ECPublicKey, signature: ECSignature, plainMessage: Data) -> Bool {
        let trueMessage = withPublicKey.verify(signature: signature, msg: plainMessage.bytes)
        return trueMessage
    }

    public func readPrivateKeyFromFileLocalDocuments(pemFileName: String) throws -> ECPrivateKey {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(pemFileName)
            do {
                var text2 = try String(contentsOf: fileURL, encoding: .utf8)
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
                return privateKey
            } catch {
                throw PemFileHandlerError.invalidPemKeyFormat
            }
        } else {
            NSLog("Pem file for Private key Secp256k1 not found")
            throw PemFileHandlerError.readPemFileNotFound
        }
    }

    public func writePrivateKeyToPemFileInDocumentsFolder(privateKeyToWrite: ECPrivateKey, fileName: String) throws -> Bool {
        let text = privateKeyToWrite.pem
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(fileName)
            do {
                try text.write(to: fileURL, atomically: false, encoding: .utf8)
                return true
            }
            catch {
                throw PemFileHandlerError.writePemFileError
            }
        } else {
            throw PemFileHandlerError.writePemFileError
        }
    }

    public func writePublicKeyToPemFileInDocumentsFolder(publicKeyToWrite: ECPublicKey, fileName: String) throws -> Bool {
        let text = publicKeyToWrite.pem
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(fileName)
            do {
                try text.write(to: fileURL, atomically: false, encoding: .utf8)
                return true
            }
            catch {
                throw PemFileHandlerError.writePemFileError
            }
        } else {
            throw PemFileHandlerError.writePemFileError
        }
    }

    public func readPublicKeyFromFileLocalDocuments(pemFileName: String) throws -> ECPublicKey {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(pemFileName)
            do {
                var text2 = try String(contentsOf: fileURL, encoding: .utf8)
                if !text2.contains(prefixPemPublicStr) && !text2.contains(prefixPemPublicECStr) {
                    throw PemFileHandlerError.invalidPemKeyPrefix
                }
                if !text2.contains(suffixPemPublicStr) && !text2.contains(suffixPemPublicECStr) {
                    throw PemFileHandlerError.invalidPemKeySuffix
                }
                if text2.contains(prefixPemPublicStr) {
                    text2 = text2.replacingOccurrences(of: prefixPemPublicStr, with: prefixPemPublicECStr)
                    text2 = text2.replacingOccurrences(of: suffixPemPublicStr, with: suffixPemPublicECStr)
                }
                let publicKey = try ECPublicKey.init(pem: text2.string)
                return publicKey
            } catch {
                throw PemFileHandlerError.invalidPemKeyFormat
            }
        } else {
            NSLog("Pem file for Public key Secp256k1 not found")
            throw PemFileHandlerError.readPemFileNotFound
        }
    }

}
