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
        let casperSDK:CasperSDK = CasperSDK(url:"http://65.21.227.180:7777/rpc",port:7777);
        do {
            //TEST CALL chain_get_state_root_hash WITH BLOCK_HASH PARAMETER SENDING TO REQUEST
            let blockHash:String = "4F271045c649FA282eB569fc06eb84654D9065b4682293e4e30a03c319ECc2E9";
            let stateRootHash = try await casperSDK.getStateRootHash(blockHash:blockHash);
            print("TEST-------------chain_get_state_root_hash with block hash param in sending request, VALUE BACK:\(stateRootHash)")
        } catch {
            print("TEST-------------Error chain_get_state_root_hash:\(error)")
        }
        //TEST CALL chain_get_state_root_hash WITH NO BLOCK_HASH PARAMETER SENDING TO REQUEST
        let stateRootHashNoParam = try await casperSDK.getStateRootHash();
        print("TEST-------------chain_get_state_root_hash with no param in sending request VALUE BACK:\(stateRootHashNoParam)")
        //TEST CALL chain_get_state_root_hash to invalid url
        print("TEST-------------chain_get_state_root_hash call fake url to casper rpc.....")
        casperSDK.setMethodUrl(url: "https://www.google.com/")
        do {
            let stateRootHashNoParam2 = try await casperSDK.getStateRootHash();
        } catch {
            print("TEST-------------Error chain_get_state_root_hash:\(error)")
            //if error == CasperMethodError.invalidURL {
             //   print("Invalid url")
            //}
        }
       /* print("TEST WITH CALLING TO WRONG NO WORKING URL")
        casperSDK.setMethodUrl(url: "https://1.2.3.4:7777/rpc")
        if casperSDK.methodURL.isValidURL {
            print("url is valid")
        } else {
            print("url is not valid")
        }
        do {
            let stateRootHashNoParam2 = try await casperSDK.getStateRootHashExtends();
        } catch {
            print("Error to url")
        }*/
    }
}
