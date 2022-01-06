import XCTest
@testable import CasperSDKInSwift

final class CasperSDKInSwiftTests: XCTestCase {
    func testAll() throws {
        //Make instance of Casper Swift SDK with the predefined URL for sending POST request
        let casperSDK:CasperSDK = CasperSDK(url:"http://65.21.227.180:7777/rpc");
        //You can change to URL for sending POST request by running this code, with the specific url like this
        //casperSDK.setMethodUrl(url: "https://node-clarity-testnet.make.services/rpc");
        
        //THIS IS TEST FOR CALLING METHOD chain_info_get_state_root_hash
        //instantiate the parameter object for calling method
        var getStateRootHashParam:GetStateRootHashParam = GetStateRootHashParam();
        //TEST 1: CALLING METHOD WITH BLOCK HASH AS PARAMS
        do {
            getStateRootHashParam.blockHash = "0BFbA69919eE66BA9b58faf843D95924d9C10927d5ac84df1F633381AE58aB71"
            try casperSDK.getStateRootHash(getStateRootHashParam: getStateRootHashParam)
        } catch {
            throw error
        }
        //TEST 2: CALLING METHOD WITH BLOCK HEIGHT AS PARAMS
        do {
            getStateRootHashParam.blockHeight = 405903
            getStateRootHashParam.blockHash = ""
            try casperSDK.getStateRootHash(getStateRootHashParam: getStateRootHashParam)
        } catch {
            throw error
        }
        //TEST 3: CALLING METHOD WITH PARAMS SET TO []
        do {
            getStateRootHashParam.blockHeight = 0
            getStateRootHashParam.blockHash = ""
            try casperSDK.getStateRootHash(getStateRootHashParam: getStateRootHashParam)
        } catch {
            throw error
        }
        //GET PEERS
        do {
            try casperSDK.getPeers()
            
        } catch {
            throw error
        }
      
    }
}
