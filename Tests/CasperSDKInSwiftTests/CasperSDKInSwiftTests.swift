import XCTest
@testable import CasperSDKInSwift

final class CasperSDKInSwiftTests: XCTestCase {
    @available(iOS 15.0.0, *)
    func testExample() async throws {
        // This is an example of a functional test case.
        //MAKE INSTANCE OF CASPER SWIFT SDK
        let casperSDK:CasperSDK = CasperSDK(url:"http://65.21.227.180",port:7777);
        print("-------------------------------***********************************-------------------------------")
        print("-------------------------------TEST WITH chain_get_state_root_hash-------------------------------")
        print("-------------------------------***********************************-------------------------------")
        //TEST 1 - CALLING METHOD WITH BLOCK_HASH AS PARAMS
        //block at this address
        //https://testnet.cspr.live/block/0BFbA69919eE66BA9b58faf843D95924d9C10927d5ac84df1F633381AE58aB71
        //params for sending block_hash="0BFbA69919eE66BA9b58faf843D95924d9C10927d5ac84df1F633381AE58aB71"
        //expected value back state_root_hash: 1C8De10CFFEf46EEdd1Ec424d260102814d8111C8EB2607818f9c06455F6ff83
        var blockHash:String = "0BFbA69919eE66BA9b58faf843D95924d9C10927d5ac84df1F633381AE58aB71";
        do {
            print("chain_get_state_root_hash - TEST 1 - chain_get_state_root_hash WITH BLOCK_HASH AS PARAMS")
            let stateRootHash = try await casperSDK.getStateRootHash(blockHash:blockHash);
            print("TEST WITH chain_get_state_root_hash------------- with block hash =\(blockHash) in sending request, ---------VALUE BACK:\(stateRootHash)")
            XCTAssertEqual(stateRootHash,"1C8De10CFFEf46EEdd1Ec424d260102814d8111C8EB2607818f9c06455F6ff83","state_root_hash not correct")
        } catch {
            print("TEST WITH chain_get_state_root_hash------------- with block hash =\(blockHash) in sending request,-------------Error:\(error)")
        }
        //TEST 2: CALLING METHOD WITH BLOCK HEIGHT AS PARAMS
        //block at this address
        //https://testnet.cspr.live/block/0BFbA69919eE66BA9b58faf843D95924d9C10927d5ac84df1F633381AE58aB71
        //params for sending Height = 405903
        //expected value back state_root_hash: 1C8De10CFFEf46EEdd1Ec424d260102814d8111C8EB2607818f9c06455F6ff83
        var blockHeight:UInt64 = 405903;
        do {
            print("chain_get_state_root_hash - TEST 2 - WITH BLOCK_HEIGHT AS PARAMS")
            let stateRootHash = try await casperSDK.getStateRootHash(blockHash:"",height: blockHeight);
            print("TEST WITH chain_get_state_root_hash------------- with block height = \(blockHeight) in sending request, ----------VALUE BACK:\(stateRootHash)")
            XCTAssertEqual(stateRootHash,"1C8De10CFFEf46EEdd1Ec424d260102814d8111C8EB2607818f9c06455F6ff83","state_root_hash not correct")
        } catch {
            print("TEST WITH chain_get_state_root_hash-------------Error:\(error)")
        }
       // TEST 3: CALLIING METHOD WITHOUT ANY PARAMS
        do {
            print("chain_get_state_root_hash - TEST 3 - WITH NO PARAMS")
            //TEST CALL chain_get_state_root_hash WITH NO PARAMETER SENDING TO REQUEST
            let stateRootHashNoParam = try await casperSDK.getStateRootHash();
            print("TEST-------------chain_get_state_root_hash with no param in sending request VALUE BACK:\(stateRootHashNoParam)")
            //assert the result back is a string of 64 characters
            XCTAssertEqual(stateRootHashNoParam.count,64,"Data back should be 64 length string")
        }
        catch {
            print("TEST-------------Error chain_get_state_root_hash:\(error)")
        }
        
        //TEST 4: CALLING METHOD WITH INVALID URL
        print("chain_get_state_root_hash - TEST 4 - WITH FAKE URL, example  https://www.google.com/")
        casperSDK.setMethodUrl(url: "https://www.google.com/")
        do {
            let stateRootHashNoParam2 = try await casperSDK.getStateRootHash();
            print("------------stateRootHash:\(stateRootHashNoParam2)")
        } catch {
            XCTAssertEqual(error as! CasperMethodError,CasperMethodError.invalidURL)
            print("TEST-------------Error chain_get_state_root_hash:\(error)")
        }
      //  casperSDK.setMethodUrl(url: "https://node-clarity-testnet.make.services/rpc");
        //SET THE REQUEST URL TO CORRECT
        casperSDK.setMethodUrl(url: "http://65.21.227.180",port:7777);
        //TEST 5: CALLIING METHOD WITH FAKE BLOCK_HASH
        do {
            print("chain_get_state_root_hash - TEST 5 - WITH FAKE BLOCK_HASH AS PARAMS")
            //TEST CALL chain_get_state_root_hash WITH WRONG BLOCK_HASH PARAMETER SENDING TO REQUEST
            blockHash = "61b2b477130E444192420fD621aCCAaD00e9db2bCecEc72171B769580d02dCE6";//THIS IS FAKE BLOCK_HASH
            let stateRootHash = try await casperSDK.getStateRootHash(blockHash:blockHash);
            print("TEST WITH chain_get_state_root_hash------------- with block hash =\(blockHash) in sending request, ---------VALUE BACK:\(stateRootHash)");//THIS PRINT SHOULD NEVER BE CALLED, SINCE IT WILL JUMP TO CATCH
        } catch {
            XCTAssertEqual(error as! GetStateRootHashError,GetStateRootHashError.blockNotFound,"Block not found")
            print("TEST WITH chain_get_state_root_hash------------- with block hash =\(blockHash) in sending request,-------------Error:\(error)")
        }
        //TEST 6: CALLING METHOD WITH FAKE BLOCK HEIGHT
        do {
            print("chain_get_state_root_hash - TEST 6 - WITH WRONG BLOCK_HEIGHT AS PARAMS")
            blockHeight = 12340204920492949
            //TEST CALL chain_get_state_root_hash WITH WRONG BLOCK_HEIGHT PARAMETER SENDING TO REQUEST
            let stateRootHash = try await casperSDK.getStateRootHash(blockHash:"",height: blockHeight);
            print("TEST WITH chain_get_state_root_hash------------- with block hash =\(blockHash) in sending request, ---------VALUE BACK:\(stateRootHash)");//THIS PRINT SHOULD NEVER BE CALLED, SINCE IT WILL JUMP TO CATCH
        } catch {
            XCTAssertEqual(error as! GetStateRootHashError,GetStateRootHashError.blockNotFound,"Block not found")
            print("TEST WITH chain_get_state_root_hash------------- with block HEIGHT =\(blockHeight) in sending request,-------------Error:\(error)")
        }
        print("--------------------------DONE WITH TEST CHAIN_GET_STATE_ROOT_HASH ---------------------------")
        //info_get_peer - TEST 1 - CALL TO CORRECT REQUEST URL
        do {
            print("-------------------------------***********************************-------------------------------")
            print("-------------------------------TEST WITH info_get_peer-------------------------------")
            print("-------------------------------***********************************-------------------------------")
            print("-------------------------info_get_peer - TEST 1: -----------------------------------------------------")
            let getPeerResult = try await casperSDK.getPeers();
            let peerEntryList = getPeerResult.getPeerMap().getPeerEntryList();
            let totalPeer = peerEntryList.count;
            print("Total peer back:\(totalPeer)")
            if totalPeer > 10 {
                print("-------------------------JUST PRINT 10 FIRST PEERS--------------------------------")
                for i in 0...9 {
                    let onePeer:PeerEntry = peerEntryList[i];
                    print("Peer number \(i+1), id:\(onePeer.getNodeId()), address:\(onePeer.getAddress())")
                }
                print("-------------------------JUST PRINT 10 LAST PEERS--------------------------------")
                let startPrintPeer2:Int = totalPeer-10;
                for i in startPrintPeer2 ..< totalPeer {
                    let onePeer:PeerEntry = peerEntryList[i];
                    print("Peer number \(i+1), id:\(onePeer.getNodeId()), address:\(onePeer.getAddress())")
                }
            }
        } catch {
            XCTAssertEqual(error as! CasperMethodError,CasperMethodError.invalidURL,"The error must be CasperMethodError.invalidURL")
            print("TEST-------------Error info_get_peer:\(error)")
        }
        
        //info_get_peer - TEST 2 - CALL TO WRONG REQUEST URL
        //SETUP THE WRONG REQUEST URL
        casperSDK.setMethodUrl(url: "https://www.google.com/")
        //START THE TEST
        print("------------------------------------------------------------------------------")
        print("-------------------------info_get_peer - TEST 2: -----------------------------------------------------")
        print("START TEST INFO_GET_PEER WITH WRONG URL, SUCH AS POINT TO https://www.google.com/")
        do {
            let getPeerResult = try await casperSDK.getPeers();
            let _ = getPeerResult.getPeerMap().getPeerEntryList();
        } catch {
            XCTAssertEqual(error as! CasperMethodError,CasperMethodError.invalidURL,"The error must be CasperMethodError.invalidURL")
            print("TEST-------------Error info_get_peer:\(error)")
        }
        print("--------------------------DONE WITH TEST PEER---------------------------")
        
        //SET THE URL BACK TO GOOD
        casperSDK.setMethodUrl(url: "http://65.21.227.180",port:7777);
    }
}
