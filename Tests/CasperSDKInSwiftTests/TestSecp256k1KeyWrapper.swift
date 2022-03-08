import XCTest
import SwiftECC
@testable import CasperSDKInSwift
final class TestSecp256k1KeyWrapper: XCTestCase {
    func testAll()  {
        let folder:String = "Assets/Secp256k1/"
        let readPrivateKeyPemFile:String    = folder + "ReadSwiftPrivateKeySecp256k1.pem"
        let readPublicKeyPemFile:String     = folder + "ReadSwiftPublicKeySecp256k1.pem"
        let writePrivateKeyPemFile:String   = folder + "WriteSwiftPrivateKeySecp256k1.pem"
        let writePublicKeyPemFile:String    = folder + "WriteSwiftPublicKeySecp256k1.pem"

        let secp256k1 : Secp256k1Crypto = Secp256k1Crypto();
        do {
            //PRIVATE KEY TEST
            //Read private key from Pem file
            let secp256k1PrivateKey =  try secp256k1.readPrivateKeyFromFile(pemFileName: readPrivateKeyPemFile)
            NSLog("Private key of secp256k1 read from Pem file:")
            NSLog(secp256k1PrivateKey.pem)
            
            //Write private key to Pem file
            let isSuccess = try secp256k1.writePrivateKeyToPemFile(privateKeyToWrite: secp256k1PrivateKey, fileName: writePrivateKeyPemFile)
            XCTAssert(isSuccess == true)
            
            //PUBLIC KEY TEST
            //Read public key from Pem file
            let secp256k1PublicKey =  try secp256k1.readPublicKeyFromFile(pemFileName: readPublicKeyPemFile)
            NSLog("Public key of secp256k1 read from Pem file:")
            NSLog(secp256k1PublicKey.pem)
            
            //Write private key to Pem file
            let isWritePublicSuccess = try secp256k1.writePublicKeyToPemFile(publicKeyToWrite: secp256k1PublicKey, fileName: writePublicKeyPemFile)
            XCTAssert(isWritePublicSuccess == true)
            
            //Key pair generation
            let (privateKey,publicKey) = secp256k1.secp256k1GenerateKey()
            
            NSLog("Private key of secp256k1 from key pair")
            NSLog(privateKey.pem)
            
            NSLog("Public key of secp256k1 from key pair")
            NSLog(publicKey.pem)
            
            //sign a message
            let message = "0252118f32ce5404139db55d6128db1ff87bd1ce458e2f13bf33a9eae9c31b60";
            //create signature
            let signature = secp256k1.signMessage(messageToSign: Data(message.hexaBytes),withPrivateKey: privateKey)
            let signatureS = signature.s.data.hexEncodedString();
            XCTAssert(signatureS.count == 64)
            let signatureR = signature.r.data.hexEncodedString();
            XCTAssert(signatureR.count == 64)
            let fullSignature = "02" + signatureR + signatureS;
            XCTAssert(fullSignature.count == 130)
            //check signature valid
            let isValidSignature = secp256k1.verifyMessage(withPublicKey: publicKey, signature: signature, plainMessage: Data(message.hexaBytes));
            XCTAssert(isValidSignature == true)
            
            //NEGATIVE PATH
            
            //Verify over a different message
            let message2:String = "Hello world!"
            let isValidSignature2 = secp256k1.verifyMessage(withPublicKey: publicKey, signature: signature, plainMessage: Data(message2.hexaBytes));
            XCTAssert(isValidSignature2 == false)
            
            //Verify with wrong public key
            let (privateKey2,publicKey2) = secp256k1.secp256k1GenerateKey()
            let isValidSignature3 = secp256k1.verifyMessage(withPublicKey: publicKey2, signature: signature, plainMessage: Data(message.hexaBytes));
            XCTAssert(isValidSignature3 == false)
            
            //Generate signature with wrong private key but verify with correct public key
            let signature2 = secp256k1.signMessage(messageToSign: Data(message.hexaBytes),withPrivateKey: privateKey2)
            let isValidSignature4 = secp256k1.verifyMessage(withPublicKey: publicKey, signature: signature2, plainMessage: Data(message.hexaBytes));
            XCTAssert(isValidSignature4 == false)
            
        } catch {
            NSLog("Error secp256k1:\(error)")
        }
    }
}
