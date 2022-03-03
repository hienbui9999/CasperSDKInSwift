import XCTest
@testable import CasperSDKInSwift
public class TestEd25519KeyWrapper : XCTestCase  {
    var signatureValue:String = "";
    let accountStr:String = "01dbad8a77a1a00cd070412bee48dd690d3b0ad58933493ad01447a7ee2165b394"
    public func testAll() {
        let ed25519Cryto : Ed25519Cryto = Ed25519Cryto();
        do {
            //let publicKey = try ed25519Cryto.readPublicKeyFromPemFile(pemFileName: "SwiftPublicKeyEd25519.pem")
            let privateKey = try ed25519Cryto.readPrivateKeyFromPemFile(pemFileName: "Assets/Ed25519/Ed25519Key1_secret_key.pem")
            let signedMessage = try ed25519Cryto.signMessage(messageToSign: Data(accountStr.bytes),withPrivateKey: privateKey)
            //test for signature verification
            /*
            let isSignCorrect = ed25519Cryto.verify(signedMessage: signedMessage, pulicKeyToVerify: publicKey, originalMessage: Data(accountStr.bytes))
            signatureValue = "01" + signedMessage.hexEncodedString()
            XCTAssert(isSignCorrect == true)
             */
        } catch {
            print("Error:\(error)")
        }
    }
}
