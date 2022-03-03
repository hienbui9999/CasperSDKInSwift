import Foundation
import CryptoKit
///Enumeration for parse pem file error
public enum PemFileHandlerError:Error {
    case ReadPemFileNotFound
    case ReadPemDirectoryNotFound
    case WritePemFileError
    case InvalidPemKeyFormat
    case InvalidPemKeySuffix
    case InvalidPemKeyPrefix
    case None
}
public enum SignActionError :Error {
    case SignMessageError
    case VerifyMessageError
}
///Enumeration for generate key error
public enum GenerateKeyError:Error {
    case PrivateKeyGenerateError
    case PublicKeyGenerateError
}
///prefix for private key in a pem file
let prefixPemPrivateStr : String = "-----BEGIN PRIVATE KEY-----";
let prefixPemPrivateECStr : String = "-----BEGIN EC PRIVATE KEY-----";
///suffix for private key in a pem file
let suffixPemPrivateStr : String = "-----END PRIVATE KEY-----";
let suffixPemPrivateECStr : String = "-----END EC PRIVATE KEY-----";
///prefix for public key in a pem file
let prefixPemPublicStr : String = "-----BEGIN PUBLIC KEY-----";
let prefixPemPublicECStr : String = "-----BEGIN EC PUBLIC KEY-----";
///suffix for public key in a pem file
let suffixPemPublicStr : String = "-----END PUBLIC KEY-----";
let suffixPemPublicECStr : String = "-----END EC PUBLIC KEY-----";

///Prefix to add for private key in Base64 String. Since the generated keys are in 32 bytes, they need to add prefix to make the full key stored in PEM file
let prefixPrivateKeyStr:String = "MC4CAQAwBQYDK2VwBCIEI";
///Prefix to add for public key in Base64 String. Since the generated keys are in 32 bytes, they need to add prefix to make the full key stored in PEM file
let prefixPublicKeyStr:String = "MCowBQYDK2VwAyEA"
///Prefix to add for private key in Bytes Data Hexa. Since the generated keys are in 32 bytes, they need to add prefix to make the full key stored in PEM file
let prefixPublicKeyData = Data([0x30, 0x2A, 0x30, 0x05, 0x06, 0x03, 0x2B, 0x65, 0x70, 0x03, 0x21, 0x00])
///Prefix to add for public key in Bytes Data Hexa. Since the generated keys are in 32 bytes, they need to add prefix to make the full key stored in PEM file
let prefixPrivateKeyData = Data([0x30, 0x2e, 0x02, 0x01, 0x00, 0x30, 0x05, 0x06, 0x03, 0x2b, 0x65, 0x70, 0x04, 0x22,0x04,0x20])
///Prefix to add for private key in Bytes Data Decimal. Since the generated keys are in 32 bytes, they need to add prefix to make the full key stored in PEM file
let prefixPrivateKeyDataBytes = Data([48, 46, 2, 1, 0, 48, 5, 6, 3, 43, 101, 112, 4, 34, 4, 32])
///Prefix to add for public key in Bytes Data Decimal. Since the generated keys are in 32 bytes, they need to add prefix to make the full key stored in PEM file
let prefixPublicKeyDataBytes = Data([48, 42, 48, 5, 6, 3, 43, 101, 112, 3, 33, 0])
///Prefix to add for private key in Hexa String. Since the generated keys are in 32 bytes, they need to add prefix to make the full key stored in PEM file
let prefixPrivateKeyHexaStr : String = "302e020100300506032b657004220420"
///Prefix to add for public key in Hexa String. Since the generated keys are in 32 bytes, they need to add prefix to make the full key stored in PEM file
let prefixPublicKeyHexaStr : String = "302a300506032b656e032100"
///Class to handle the following actions on Ed25519 encryption:  key generation, read key from PEM file,  write key to PEM file, sign message, verify message
public class Ed25519Cryto {
    public var privateKey:Curve25519.Signing.PrivateKey!
    public var publicKey:Curve25519.Signing.PublicKey!
    ///Generate key pair
    public func generateKey() -> (Curve25519.Signing.PrivateKey,Curve25519.Signing.PublicKey){
        privateKey = Curve25519.Signing.PrivateKey.init();
        publicKey = privateKey.publicKey;
        return (privateKey,publicKey)
    }
    ///Write private key to pem file
    public func writePrivateKeyToPemFile(privateKeyToWrite:Curve25519.Signing.PrivateKey,fileName:String) throws {
        let privateKeyInBase64 = (prefixPrivateKeyData + privateKeyToWrite.rawRepresentation).base64EncodedString()
        var text = "-----BEGIN PRIVATE KEY-----"
        text = text + "\n" + privateKeyInBase64
        text = text + "\n" + "-----END PRIVATE KEY-----"
        let thisSourceFile = URL(fileURLWithPath: #file)
        let thisDirectory = thisSourceFile.deletingLastPathComponent()
        let fileURL = thisDirectory.appendingPathComponent(fileName)
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
            } catch {
                NSLog("Ed25519 Private key file does not exist, about to create new one!")
            }
            NSLog("Delete auto generated Ed25519 private file.")
        }
        do {
            try text.write(to: fileURL, atomically: false, encoding: .utf8)
        }
        catch {
            throw PemFileHandlerError.WritePemFileError
        }
    }
    ///Write public key to pem file
    public func writePublicKeyToPemFile(publicKeyToWrite:Curve25519.Signing.PublicKey,fileName:String) throws {
        let publicKeyInBase64 = (prefixPublicKeyData + publicKeyToWrite.rawRepresentation).base64EncodedString()
        var text = "-----BEGIN PUBLIC KEY-----"
        text = text + "\n" + publicKeyInBase64
        text = text + "\n" + "-----END PUBLIC KEY-----"
        
        let thisSourceFile = URL(fileURLWithPath: #file)
        let thisDirectory = thisSourceFile.deletingLastPathComponent()
        let fileURL = thisDirectory.appendingPathComponent(fileName)
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
            } catch {
                NSLog("Ed25519 Private key file does not exist, about to create new one!")
            }
            NSLog("Delete auto generated Ed25519 private file.")
        }
        do {
            try text.write(to: fileURL, atomically: false, encoding: .utf8)
        }
        catch {
            throw PemFileHandlerError.WritePemFileError
        }
    }
    
    ///Read private key from pem file
    public func readPrivateKeyFromPemFileFromLocal(pemFileName:String) throws -> Curve25519.Signing.PrivateKey {
       
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(pemFileName)
        do {
            let text2 = try String(contentsOf: fileURL, encoding: .utf8)
            if !text2.contains(prefixPemPrivateStr) {
                throw PemFileHandlerError.InvalidPemKeyFormat
            }
            if !text2.contains(suffixPemPrivateStr) {
                throw PemFileHandlerError.InvalidPemKeyFormat
            }
            let element = text2.components(separatedBy: prefixPemPrivateStr)
            let text1 = element[1];
            let textE = text1.components(separatedBy:suffixPemPrivateStr)
            var pemStr = textE[0];
            if pemStr.count > 64 {
                let index = pemStr.index(pemStr.startIndex,offsetBy:65);
                let realPemStr = String(pemStr[..<index]);
                pemStr = realPemStr;
            }
            pemStr = pemStr.trimmingCharacters(in: .whitespacesAndNewlines)
            let pemIndex = pemStr.index(pemStr.startIndex,offsetBy: 21);
            let privateBase64:String = String(pemStr[pemIndex..<pemStr.endIndex])
            let fullPemKeyBase64 = prefixPrivateKeyStr + privateBase64;
            if let privateBase64FromPem = fullPemKeyBase64.base64Decoded {
                let base64ToBytes = privateBase64FromPem.bytes
                let privateBytes = base64ToBytes[prefixPrivateKeyData.count..<base64ToBytes.count];
                do {
                    let privateKey = try Curve25519.Signing.PrivateKey.init(rawRepresentation: privateBytes)
                    return privateKey
                } catch {
                    throw GenerateKeyError.PrivateKeyGenerateError
                }
            } else {
                throw GenerateKeyError.PrivateKeyGenerateError
            }
        }
        catch {
            throw GenerateKeyError.PrivateKeyGenerateError
        }
        } else {
            throw GenerateKeyError.PrivateKeyGenerateError
        }
    }
    
    ///Read private key from pem file
    public func readPrivateKeyFromPemFile(pemFileName:String) throws -> Curve25519.Signing.PrivateKey {
        let thisSourceFile = URL(fileURLWithPath: #file)
        let thisDirectory = thisSourceFile.deletingLastPathComponent()
        let resourceURL = thisDirectory.appendingPathComponent(pemFileName)
        do {
            let text2 = try String(contentsOf: resourceURL, encoding: .utf8)
            if !text2.contains(prefixPemPrivateStr) {
                throw PemFileHandlerError.InvalidPemKeyFormat
            }
            if !text2.contains(suffixPemPrivateStr) {
                throw PemFileHandlerError.InvalidPemKeyFormat
            }
            let element = text2.components(separatedBy: prefixPemPrivateStr)
            let text1 = element[1];
            let textE = text1.components(separatedBy:suffixPemPrivateStr)
            var pemStr = textE[0];
            if pemStr.count > 64 {
                let index = pemStr.index(pemStr.startIndex,offsetBy:65);
                let realPemStr = String(pemStr[..<index]);
                pemStr = realPemStr;
            }
            pemStr = pemStr.trimmingCharacters(in: .whitespacesAndNewlines)
            let pemIndex = pemStr.index(pemStr.startIndex,offsetBy: 21);
            let privateBase64:String = String(pemStr[pemIndex..<pemStr.endIndex])
            let fullPemKeyBase64 = prefixPrivateKeyStr + privateBase64;
            if let privateBase64FromPem = fullPemKeyBase64.base64Decoded {
                let base64ToBytes = privateBase64FromPem.bytes
                let privateBytes = base64ToBytes[prefixPrivateKeyData.count..<base64ToBytes.count];
                do {
                    let privateKey = try Curve25519.Signing.PrivateKey.init(rawRepresentation: privateBytes)
                    return privateKey
                } catch {
                    throw GenerateKeyError.PrivateKeyGenerateError
                }
            } else {
                throw GenerateKeyError.PrivateKeyGenerateError
            }
        }
        catch {
            throw GenerateKeyError.PrivateKeyGenerateError
        }
       
    }
    ///Read public key from pem file
    public func readPublicKeyFromPemFile(pemFileName:String) throws -> Curve25519.Signing.PublicKey{
       // if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
     //       let fileURL = dir.appendingPathComponent(pemFileName)
     //       do {
    //            let text2 = try String(contentsOf: fileURL, encoding: .utf8)
        let thisSourceFile = URL(fileURLWithPath: #file)
        let thisDirectory = thisSourceFile.deletingLastPathComponent()
        let resourceURL = thisDirectory.appendingPathComponent(pemFileName)
        do {
            let text2 = try String(contentsOf: resourceURL, encoding: .utf8)
            if !text2.contains(prefixPemPublicStr) {
                throw PemFileHandlerError.InvalidPemKeyFormat
            }
            if !text2.contains(suffixPemPublicStr) {
                throw PemFileHandlerError.InvalidPemKeyFormat
            }
            let element = text2.components(separatedBy: prefixPemPublicStr)
            let text1 = element[1];
            let textE = text1.components(separatedBy:suffixPemPublicStr)
            var pemStr = String(textE[0]);
            pemStr = pemStr.trimmingCharacters(in: .whitespacesAndNewlines)
            if pemStr.count > 60 {
                let index = pemStr.index(pemStr.startIndex,offsetBy:65);
                let realPemStr = String(pemStr[..<index]);
                pemStr = realPemStr;
            }
            pemStr = pemStr.trimmingCharacters(in: .whitespacesAndNewlines)
            let pemIndex = pemStr.index(pemStr.startIndex,offsetBy: 16);
            let publicBase64:String = String(pemStr[pemIndex..<pemStr.endIndex])
           /* do {
                guard let data = Data(base64EncodedURLSafe: publicBase64) else {
                    throw PemFileHandlerError.InvalidPemKeyFormat
                }
                var publicBytesArray:[UInt8] = [];
                for byte in data {
                    publicBytesArray.append(byte)
                }
                let publicKeyFromPem = try Curve25519.Signing.PublicKey.init(rawRepresentation: publicBytesArray)
                return publicKeyFromPem
            } catch {
                throw GenerateKeyError.PublicKeyGenerateError
            }*/
            if let base64DecodeShort = publicBase64.base64Decoded {
                do {
                    let publicKeyFromPem = try Curve25519.Signing.PublicKey.init(rawRepresentation: base64DecodeShort.bytes)
                    return publicKeyFromPem
                } catch {
                    throw GenerateKeyError.PublicKeyGenerateError
                }
            } else {
                throw PemFileHandlerError.InvalidPemKeyFormat
            }
        }
        catch {
            throw PemFileHandlerError.ReadPemFileNotFound
        }
    }
    
    ///Sign message
    public func signMessage(messageToSign:Data,withPrivateKey:Curve25519.Signing.PrivateKey) throws -> Data {
        do {
            let signMessage = try withPrivateKey.signature(for: messageToSign);
            return signMessage
        } catch {
            throw SignActionError.SignMessageError
        }
    }
    //verify the message base on signed message and public key
    public func verify(signedMessage:Data,pulicKeyToVerify:Curve25519.Signing.PublicKey, originalMessage:Data) -> Bool {
        if pulicKeyToVerify.isValidSignature(signedMessage, for: originalMessage) {
            return true
        } else {
            return false
        }
    }
}
extension StringProtocol {
    var data: Data { Data(utf8) }
    var base64Encoded: Data { data.base64EncodedData() }
    var base64Decoded: Data? { Data(base64Encoded: string) }
}
extension LosslessStringConvertible {
    var string: String { .init(self) }
}
extension Sequence where Element == UInt8 {
    var data: Data { .init(self) }
    var base64Decoded: Data? { Data(base64Encoded: data) }
    var string: String? { String(bytes: self, encoding: .utf8) }
}

extension Data {
  /// A hexadecimal string representation of the bytes.
  func hexEncodedString() -> String {
    let hexDigits = Array("0123456789abcdef".utf16)
    var hexChars = [UTF16.CodeUnit]()
    hexChars.reserveCapacity(count * 2)

    for byte in self {
      let (index1, index2) = Int(byte).quotientAndRemainder(dividingBy: 16)
      hexChars.append(hexDigits[index1])
      hexChars.append(hexDigits[index2])
    }

    return String(utf16CodeUnits: hexChars, count: hexChars.count)
  }
}

extension String {
  /// A data representation of the hexadecimal bytes in this string.
  func hexDecodedData() -> Data {
    // Get the UTF8 characters of this string
    let chars = Array(utf8)

    // Keep the bytes in an UInt8 array and later convert it to Data
    var bytes = [UInt8]()
    bytes.reserveCapacity(count / 2)

    // It is a lot faster to use a lookup map instead of strtoul
    let map: [UInt8] = [
      0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, // 01234567
      0x08, 0x09, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // 89:;<=>?
      0x00, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x00, // @ABCDEFG
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00  // HIJKLMNO
    ]

    // Grab two characters at a time, map them and turn it into a byte
    for i in stride(from: 0, to: count, by: 2) {
      let index1 = Int(chars[i] & 0x1F ^ 0x10)
      let index2 = Int(chars[i + 1] & 0x1F ^ 0x10)
      bytes.append(map[index1] << 4 | map[index2])
    }

    return Data(bytes)
  }
}

extension Data {
    init?(base64EncodedURLSafe string: String, options: Base64DecodingOptions = []) {
        let string = string
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")

        self.init(base64Encoded: string, options: options)
    }
    public var bytes: Array<UInt8> {
      Array(self)
    }
}

extension StringProtocol {
    var hexaData: Data { .init(hexa) }
    var hexaBytes: [UInt8] { .init(hexa) }
    private var hexa: UnfoldSequence<UInt8, Index> {
        sequence(state: startIndex) { startIndex in
            guard startIndex < self.endIndex else { return nil }
            let endIndex = self.index(startIndex, offsetBy: 2, limitedBy: self.endIndex) ?? self.endIndex
            defer { startIndex = endIndex }
            return UInt8(self[startIndex..<endIndex], radix: 16)
        }
    }
}
extension String {
    @inlinable
    public var bytes: Array<UInt8> {
      data(using: String.Encoding.utf8, allowLossyConversion: true)?.bytes ?? Array(utf8)
    }
}
