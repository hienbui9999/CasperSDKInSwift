import XCTest
@testable import CasperSDKInSwift
public class TestEd25519KeyWrapper : XCTestCase  {
    public func testAll() {
        let folder:String = "Assets/Ed25519/"
        let readPrivateKeyPemFile:String    = folder + "ReadSwiftPrivateKeyEd25519.pem"
        let readPublicKeyPemFile:String     = folder + "ReadSwiftPublicKeyEd25519.pem"
        let writePrivateKeyPemFile:String   = folder + "WriteSwiftPrivateKeyEd25519.pem"
        let writePublicKeyPemFile:String    = folder + "WriteSwiftPublicKeyEd25519.pem"

        let ed25519Cryto : Ed25519Cryto = Ed25519Cryto();
        do {
            //Read public key from Pem file
            let publicKey = try ed25519Cryto.readPublicKeyFromPemFile(pemFileName: readPublicKeyPemFile)
            print("Ed25519 PublicKey in hexa")
            print(publicKey.rawRepresentation.hexEncodedString())
            //Read private key from Pem file
            let privateKey = try ed25519Cryto.readPrivateKeyFromPemFile(pemFileName: readPrivateKeyPemFile)
            print("Ed25519 PrivateKey in hexa")
            print(privateKey.rawRepresentation.hexEncodedString())
            //Write public key to Pem file
            try ed25519Cryto.writePublicKeyToPemFile(publicKeyToWrite: publicKey, fileName: writePublicKeyPemFile)
            //Write private key to Pem file
            try ed25519Cryto.writePrivateKeyToPemFile(privateKeyToWrite: privateKey, fileName: writePrivateKeyPemFile)
            //Key pair generation
            let (privateKey2,publicKey2) = ed25519Cryto.generateKey()
            print("Key pair generation, private key in hexa")
            print(privateKey2.rawRepresentation.hexEncodedString())
            print("Key pair generation, public key in hexa")
            print(publicKey2.rawRepresentation.hexEncodedString())
            XCTAssert(privateKey2.rawRepresentation.hexEncodedString().count == 64)
            XCTAssert(publicKey2.rawRepresentation.hexEncodedString().count == 64)
            //Sign message
            let message:String = "01dbad8a77a1a00cd070412bee48dd690d3b0ad58933493ad01447a7ee2165b394"
            let signature = try ed25519Cryto.signMessage(messageToSign: Data(message.bytes),withPrivateKey: privateKey2)
            let signatureStr = "01" + signature.hexEncodedString()
            XCTAssert(signatureStr.count == 130)
            
            //Signature verification
            let isSignCorrect = ed25519Cryto.verify(signedMessage: signature, pulicKeyToVerify: publicKey2, originalMessage: Data(message.bytes))
            XCTAssert(isSignCorrect == true)
            
            //NEGATIVE PATH
            
            //Verify over a different message
            let message2:String = "Hello world!"
            let isSignCorrect2 = ed25519Cryto.verify(signedMessage: signature, pulicKeyToVerify: publicKey2, originalMessage: Data(message2.bytes))
            XCTAssert(isSignCorrect2 == false)
            
            //Verify with wrong public key
            let (privateKey3,publicKey3) = ed25519Cryto.generateKey()
            let isSignCorrect3 = ed25519Cryto.verify(signedMessage: signature, pulicKeyToVerify: publicKey3, originalMessage: Data(message.bytes))
            XCTAssert(isSignCorrect3 == false)
            
            //Generate signature with wrong private key but verify with correct public key
            let signature2 = try ed25519Cryto.signMessage(messageToSign: Data(message.bytes),withPrivateKey: privateKey3)
            let isSignCorrect4 = ed25519Cryto.verify(signedMessage: signature2, pulicKeyToVerify: publicKey2, originalMessage: Data(message.bytes))
            XCTAssert(isSignCorrect4 == false)
            
        } catch {
            print("Error:\(error)")
        }
    }
}
