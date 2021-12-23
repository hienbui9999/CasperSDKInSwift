import XCTest
@testable import CasperSDKInSwift

final class CasperSDKInSwiftTests: XCTestCase {
    @available(iOS 15.0.0, *)
    func testExample() async throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
       // XCTAssertEqual(CasperSDKInSwift().text, "Hello, World!")
        //MAKE INSTANCE OF CASPER SWIFT SDK
        let casperSDK:CasperSDKInSwift = CasperSDKInSwift();
        //TEST CALL chain_get_state_root_hash WITH BLOCK_HASH PARAMETER SENDING TO REQUEST
        let blockHash:String = "4F271045c649FA282eB569fc06eb84654D9065b4682293e4e30a03c319ECc2E9";
        let stateRootHash = try await casperSDK.getStateRootHashExtends(blockHash:blockHash);
        print("StateRootHash with block hash param in sending request:\(stateRootHash)")
        //TEST CALL chain_get_state_root_hash WITH NO BLOCK_HASH PARAMETER SENDING TO REQUEST
        let stateRootHashNoParam = try await casperSDK.getStateRootHashExtends();
        print("StateRootHash with no param in sending request:\(stateRootHashNoParam)")
        //TEST CALL chain_get_state_root_hash to invalid url
        casperSDK.setMethodUrl(url: "https://stackoverflow.com/questions/28079123/how-to-check-validity-of-url-in-swift")
        do {
            let stateRootHashNoParam2 = try await casperSDK.getStateRootHashExtends();
        } catch {
            print("Error to url")
        }
    }
}
