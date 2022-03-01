import XCTest
@testable import CasperSDKInSwift
final class TestSecp256k1KeyWrapper: XCTestCase {
    func testAll()  {
        let secp256k1 : Secp256k1Crypto = Secp256k1Crypto();
        do {
            let pemFile:String =  "SwiftSecp256k1SamplePrivateKey.pem"
            try secp256k1.readPrivateKeyFromFile(pemFileName: pemFile)
        } catch {
            NSLog("Error secp256k1:\(error)")
        }
        secp256k1.secp256k1GenerateKey();
    }
}
