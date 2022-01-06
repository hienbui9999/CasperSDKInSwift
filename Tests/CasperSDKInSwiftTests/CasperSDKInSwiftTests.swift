import XCTest
@testable import CasperSDKInSwift

final class CasperSDKInSwiftTests: XCTestCase {
    func testAll() throws {
        let casperSDK:CasperSDK = CasperSDK(url:"https://node-clarity-testnet.make.services/rpc");
        //chain_info_get_state_root_hash
        let getStateRootHashParam:GetStateRootHashParam = GetStateRootHashParam();
        //TEST 1: send block hash as param
        do {
            getStateRootHashParam.blockHash = "0BFbA69919eE66BA9b58faf843D95924d9C10927d5ac84df1F633381AE58aB71"
            try casperSDK.getStateRootHash(getStateRootHashParam: getStateRootHashParam)
        } catch {
            throw error
        }
        //TEST 2: send block height as param
        do {
            getStateRootHashParam.blockHeight = 405903
            getStateRootHashParam.blockHash = ""
            try casperSDK.getStateRootHash(getStateRootHashParam: getStateRootHashParam)
        } catch {
            throw error
        }
        //TEST 3: no param
        do {
            getStateRootHashParam.blockHeight = 0
            getStateRootHashParam.blockHash = ""
            try casperSDK.getStateRootHash(getStateRootHashParam: getStateRootHashParam)
        } catch {
            throw error
        }
        //info_get_peers
        do {
            try casperSDK.getPeers()
        } catch {
            throw error
        }
      
    }
}
