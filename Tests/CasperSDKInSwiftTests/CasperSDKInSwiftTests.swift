import XCTest
@testable import CasperSDKInSwift

final class CasperSDKInSwiftTests: XCTestCase {
    @available(iOS 15.0.0, *)
    func testExample() async throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
       // XCTAssertEqual(CasperSDKInSwift().text, "Hello, World!")
        let casperSDK:CasperSDKInSwift = CasperSDKInSwift();
        let blockHash:String = "4F271045c649FA282eB569fc06eb84654D9065b4682293e4e30a03c319ECc2E9";
        let stateRootHash = try await casperSDK.getStateRootHashExtends(blockHash:blockHash);
        print("StateRootHash with block hash param in sending request:\(stateRootHash)")
        //test with calling no blockHash
        let stateRootHashNoParam = try await casperSDK.getStateRootHashExtends();
        print("StateRootHash with no param in sending request:\(stateRootHashNoParam)")
    }
}
