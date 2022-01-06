import XCTest
@testable import CasperSDKInSwift

final class CasperSDKInSwiftTests: XCTestCase {
    func testAll() throws {
        //Make instance of Casper Swift SDK with the predefined URL for sending POST request
        let casperSDK:CasperSDK = CasperSDK(url:"https://node-clarity-testnet.make.services/rpc");
        //You can change to URL for sending POST request by running this code, with the specific url like this
        //casperSDK.setMethodUrl(url: "http://65.21.227.180:7777/rpc");
        
        //THIS IS TEST FOR CALLING METHOD chain_info_get_state_root_hash
        //instantiate the parameter object for calling method
        let getStateRootHashParam:GetStateRootHashParam = GetStateRootHashParam();
        //TEST 1: CALLING METHOD WITH BLOCK HASH AS PARAMS
        do {
            getStateRootHashParam.blockHash = "0BFbA69919eE66BA9b58faf843D95924d9C10927d5ac84df1F633381AE58aB71"
            try casperSDK.getStateRootHash(getStateRootHashParam: getStateRootHashParam)
            //for ther state_root_hash back, refer to HttpHandler file with method handleRequest, in the call
            //let stateRootHash = try GetStateRootHash.getStateRootHash(from: responseJSON);
            //you can print the result back at that place
        } catch {
            throw error
        }
        //TEST 2: CALLING METHOD WITH BLOCK HEIGHT AS PARAMS
        do {
            getStateRootHashParam.blockHeight = 405903
            getStateRootHashParam.blockHash = ""
            try casperSDK.getStateRootHash(getStateRootHashParam: getStateRootHashParam)
            //for ther state_root_hash back, refer to HttpHandler file with method handleRequest, in the call
            //let stateRootHash = try GetStateRootHash.getStateRootHash(from: responseJSON);
            //you can print the result back at that place
        } catch {
            throw error
        }
        //TEST 3: CALLING METHOD WITH PARAMS SET TO []
        do {
            getStateRootHashParam.blockHeight = 0
            getStateRootHashParam.blockHash = ""
            try casperSDK.getStateRootHash(getStateRootHashParam: getStateRootHashParam)
            //for ther state_root_hash back, refer to HttpHandler file with method handleRequest, in the call
            //let stateRootHash = try GetStateRootHash.getStateRootHash(from: responseJSON);
            //you can print the result back at that place
        } catch {
            throw error
        }
        //THIS IS TEST FOR CALLING METHOD info_get_peers
        do {
            try casperSDK.getPeers()
            //for a list of peers back, refer to HttpHandler file with method handleRequest, in the call
            //let getPeer:GetPeersResult = try GetPeers.getPeers(from: responseJSON)
            //you can print the result back at that place
        } catch {
            throw error
        }
      
    }
}
