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
   - Parameter : Pem file name and URL
   - Returns: ECPrivateKey of type secp256k1
   */
    public func readPrivateKeyFromFile(pemFileName:String) throws -> ECPrivateKey{
        let bundleMain = Bundle.main
        let bundleDoingTest = Bundle(for: type(of: self ))
        let thisSourceFile = URL(fileURLWithPath: #file)
        let thisDirectory = thisSourceFile.deletingLastPathComponent()
        let resourceURL = thisDirectory.appendingPathComponent(pemFileName)
        do {
            var text2 = try String(contentsOf: resourceURL, encoding: .utf8)
            if !text2.contains(prefixPemPrivateStr) && !text2.contains(prefixPemPrivateECStr){
                throw PemFileHandlerError.InvalidPemKeyPrefix
            }
            if !text2.contains(suffixPemPrivateStr) && !text2.contains(suffixPemPrivateECStr) {
                throw PemFileHandlerError.InvalidPemKeySuffix
            }
            if text2.contains(prefixPemPrivateStr) {
                text2 = text2.replacingOccurrences(of:prefixPemPrivateStr,with:prefixPemPrivateECStr)
                text2 = text2.replacingOccurrences(of:suffixPemPrivateStr,with:suffixPemPrivateECStr);
            }
            let privateKey = try ECPrivateKey.init(pem: text2)
            return privateKey
        } catch {
            throw PemFileHandlerError.InvalidPemKeyFormat
        }
    }
    public func readPublicKeyFromFile(pemFileName:String) throws -> ECPublicKey {
        let thisSourceFile = URL(fileURLWithPath: #file)
        let thisDirectory = thisSourceFile.deletingLastPathComponent()
        let resourceURL = thisDirectory.appendingPathComponent(pemFileName)
        do {
        var text2 = try String(contentsOf: resourceURL, encoding: .utf8)
            if !text2.contains(prefixPemPublicStr) && !text2.contains(prefixPemPublicECStr){
                throw PemFileHandlerError.InvalidPemKeyPrefix
            }
            if !text2.contains(suffixPemPublicStr) && !text2.contains(suffixPemPublicECStr) {
                throw PemFileHandlerError.InvalidPemKeySuffix
            }
            if text2.contains(prefixPemPublicStr) {
                text2 = text2.replacingOccurrences(of:prefixPemPublicECStr,with:prefixPemPublicStr)
                text2 = text2.replacingOccurrences(of:suffixPemPublicECStr,with:suffixPemPublicStr);
            }
            text2 = text2.trimmingCharacters(in: .whitespaces)
            let publicKey = try ECPublicKey.init(pem: text2)
            return publicKey
        } catch {
            throw PemFileHandlerError.InvalidPemKeyFormat
        }
       
    }
    
    public func writePrivateKeyToPemFile(privateKeyToWrite:ECPrivateKey,fileName:String) throws -> Bool{
        let text = privateKeyToWrite.pem
        let thisSourceFile = URL(fileURLWithPath: #file)
        let thisDirectory = thisSourceFile.deletingLastPathComponent()
        let fileURL = thisDirectory.appendingPathComponent(fileName)
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
            } catch {
                NSLog("Secp256k1 Private key file does not exist, about to create new one!")
            }
            NSLog("Delete auto generated Secp256k1 private file.")
        }
        do {
            try text.write(to: fileURL, atomically: false, encoding: .utf8)
            return true;
        }
        catch {
            throw PemFileHandlerError.WritePemFileError
        }
    }
   
    public func writePublicKeyToPemFile(publicKeyToWrite:ECPublicKey,fileName:String) throws -> Bool{
        let text = publicKeyToWrite.pem
        let bundleMain = Bundle.main
        let bundleDoingTest = Bundle(for: type(of: self ))
        let thisSourceFile = URL(fileURLWithPath: #file)
        let thisDirectory = thisSourceFile.deletingLastPathComponent()
        let fileURL = thisDirectory.appendingPathComponent(fileName)
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
            } catch {
                NSLog("Secp256k1 Public key file does not exist, about to create new one!")
            }
            NSLog("Delete auto generated Secp256k1 public file.")
        }
        do {
            try text.write(to: fileURL, atomically: false, encoding: .utf8)
            return true
        }
        catch {
            throw PemFileHandlerError.WritePemFileError
        }
       
    }
    public func secp256k1GenerateKey() -> (ECPrivateKey,ECPublicKey) {
        let domain = Domain.instance(curve: .EC256k1)
        let (publicKey,privateKey) = domain.makeKeyPair();
        return (privateKey,publicKey);
    }
    public func signMessage(messageToSign:Data,withPrivateKey:ECPrivateKey) -> ECSignature {
        let signature = withPrivateKey.sign(msg: messageToSign)
        //print(signature.r.data.hexEncodedString() + signature.s.data.hexEncodedString())
        return signature
    }
    public func verifyMessage(withPublicKey:ECPublicKey,signature:ECSignature,plainMessage:Data) -> Bool{
        let trueMessage = withPublicKey.verify(signature: signature, msg: plainMessage.bytes);
        return trueMessage
    }
    
    public func readPrivateKeyFromFileLocalDocuments(pemFileName:String) throws -> ECPrivateKey{
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(pemFileName)
            do {
                var text2 = try String(contentsOf: fileURL, encoding: .utf8)
                if !text2.contains(prefixPemPrivateStr) && !text2.contains(prefixPemPrivateECStr){
                    throw PemFileHandlerError.InvalidPemKeyPrefix
                }
                if !text2.contains(suffixPemPrivateStr) && !text2.contains(suffixPemPrivateECStr) {
                    throw PemFileHandlerError.InvalidPemKeySuffix
                }
                if text2.contains(prefixPemPrivateStr) {
                    text2 = text2.replacingOccurrences(of:prefixPemPrivateStr,with:prefixPemPrivateECStr)
                    text2 = text2.replacingOccurrences(of:suffixPemPrivateStr,with:suffixPemPrivateECStr);
                }
                let privateKey = try ECPrivateKey.init(pem: text2)
                return privateKey
            } catch {
                throw PemFileHandlerError.InvalidPemKeyFormat
            }
        } else {
            NSLog("File not found")
            throw PemFileHandlerError.ReadPemFileNotFound
        }
    }
    public func writePrivateKeyToPemFileInDocumentsFolder(privateKeyToWrite:ECPrivateKey,fileName:String) throws -> Bool{
        let text = privateKeyToWrite.pem
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(fileName)
            do {
                try text.write(to: fileURL, atomically: false, encoding: .utf8)
                return true;
            }
            catch {
                throw PemFileHandlerError.WritePemFileError
               
            }
        } else {
            throw PemFileHandlerError.WritePemFileError
        }
    }
    public func writePublicKeyToPemFileInDocumentsFolder(publicKeyToWrite:ECPublicKey,fileName:String) throws -> Bool{
        let text = publicKeyToWrite.pem
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(fileName)
            do {
                try text.write(to: fileURL, atomically: false, encoding: .utf8)
                return true
            }
            catch {
                throw PemFileHandlerError.WritePemFileError
            }
        } else {
            throw PemFileHandlerError.WritePemFileError
        }
    }
    public func readPublicKeyFromFileLocalDocuments(pemFileName:String) throws -> ECPublicKey{
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(pemFileName)
            do {
                var text2 = try String(contentsOf: fileURL, encoding: .utf8)
                if !text2.contains(prefixPemPublicStr) && !text2.contains(prefixPemPublicECStr){
                    throw PemFileHandlerError.InvalidPemKeyPrefix
                }
                if !text2.contains(suffixPemPublicStr) && !text2.contains(suffixPemPublicECStr) {
                    throw PemFileHandlerError.InvalidPemKeySuffix
                }
                if text2.contains(prefixPemPublicStr) {
                    text2 = text2.replacingOccurrences(of:prefixPemPublicStr,with:prefixPemPublicECStr)
                    text2 = text2.replacingOccurrences(of:suffixPemPublicStr,with:suffixPemPublicECStr);
                }
                print("Public text file in pem:\(text2)")
                let publicKey = try ECPublicKey.init(pem: text2.string)
                return publicKey
            } catch {
                throw PemFileHandlerError.InvalidPemKeyFormat
            }
        } else {
            NSLog("File not found")
            throw PemFileHandlerError.ReadPemFileNotFound
        }
    }
}


