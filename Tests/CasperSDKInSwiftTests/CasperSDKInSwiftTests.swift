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
        print("-------------------------------***********************************-------------------------------")
        print("-------------------------------TEST WITH chain_get_state_root_hash-------------------------------")
        print("-------------------------------***********************************-------------------------------")

        let casperSDK:CasperSDK = CasperSDK(url:"http://65.21.227.180",port:7777);
        var blockHash:String = "5d9F29103ba85e04358Ced6d504D201d9A32ffB7789Dc1B0E426d500CEDfdBCA";
        var blockHeight:UInt64 = 10;
        do {
            print("TEST 1 TEST 1 TEST 1 - WITH BLOCK_HASH AS PARAMS")
            //TEST CALL chain_get_state_root_hash WITH BLOCK_HASH PARAMETER SENDING TO REQUEST
            let stateRootHash = try await casperSDK.getStateRootHash(blockHash:blockHash);
            print("TEST WITH chain_get_state_root_hash------------- with block hash =\(blockHash) in sending request, ---------VALUE BACK:\(stateRootHash)")
        } catch {
            print("TEST WITH chain_get_state_root_hash------------- with block hash =\(blockHash) in sending request,-------------Error:\(error)")
        }
        do {
            print("TEST 2 TEST 2 TEST 2 - WITH BLOCK_HEIGHT AS PARAMS")
            //TEST CALL chain_get_state_root_hash WITH BLOCK_HEIGHT PARAMETER SENDING TO REQUEST
            let stateRootHash = try await casperSDK.getStateRootHash(blockHash:"",height: blockHeight);
            print("TEST WITH chain_get_state_root_hash------------- with block height = \(blockHeight) in sending request, ----------VALUE BACK:\(stateRootHash)")
        } catch {
            print("TEST WITH chain_get_state_root_hash-------------Error:\(error)")
        }
        do {
            print("TEST 3 TEST 3 TEST 3 - WITH NO PARAMS")
            //TEST CALL chain_get_state_root_hash WITH NO BLOCK_HASH PARAMETER SENDING TO REQUEST
            let stateRootHashNoParam = try await casperSDK.getStateRootHash();
            print("TEST-------------chain_get_state_root_hash with no param in sending request VALUE BACK:\(stateRootHashNoParam)")
        }
        catch {
            print("TEST-------------Error chain_get_state_root_hash:\(error)")
        }
        //TEST CALL chain_get_state_root_hash to invalid url
        print("TEST 4 TEST 4 TEST 4 - WITH FAKE URL, example ")
        print("TEST-------------chain_get_state_root_hash call fake url to casper rpc.....")
        casperSDK.setMethodUrl(url: "https://www.google.com/")
      //  casperSDK.setMethodUrl(url: "https://node-clarity-testnet.make.services/rpc");
        do {
            let stateRootHashNoParam2 = try await casperSDK.getStateRootHash();
            print("------------stateRootHash:\(stateRootHashNoParam2)")
        } catch {
            print("TEST-------------Error chain_get_state_root_hash:\(error)")
            //if error == CasperMethodError.invalidURL {
             //   print("Invalid url")
            //}
        }
        casperSDK.setMethodUrl(url: "https://node-clarity-testnet.make.services/rpc");
        do {
            print("TEST 5 TEST 5 TEST 5 - WITH FAKE BLOCK_HASH AS PARAMS")
            //TEST CALL chain_get_state_root_hash WITH BLOCK_HASH PARAMETER SENDING TO REQUEST
            blockHash = "61b2b477130E444192420fD621aCCAaD00e9db2bCecEc72171B769580d02dCE6"
            let stateRootHash = try await casperSDK.getStateRootHash(blockHash:blockHash);
            print("TEST WITH chain_get_state_root_hash------------- with block hash =\(blockHash) in sending request, ---------VALUE BACK:\(stateRootHash)")
        } catch {
            print("TEST WITH chain_get_state_root_hash------------- with block hash =\(blockHash) in sending request,-------------Error:\(error)")
        }
        do {
            print("TEST 6 TEST 6 TEST 6 - WITH WRONG BLOCK_HEIGHT AS PARAMS")
            blockHeight = 12340204920492949
            //TEST CALL chain_get_state_root_hash WITH BLOCK_HASH PARAMETER SENDING TO REQUEST
            //blockHash = "61b2b477130E444192420fD621aCCAaD00e9db2bCecEc72171B769580d02dCE6"
            let stateRootHash = try await casperSDK.getStateRootHash(blockHash:"",height: blockHeight);
            print("TEST WITH chain_get_state_root_hash------------- with block hash =\(blockHash) in sending request, ---------VALUE BACK:\(stateRootHash)")
        } catch {
            print("TEST WITH chain_get_state_root_hash------------- with block hash =\(blockHash) in sending request,-------------Error:\(error)")
        }

        do {
            print("-------------------------------***********************************-------------------------------")
            print("-------------------------------TEST WITH info_get_peer-------------------------------")
            print("-------------------------------***********************************-------------------------------")
            let getPeerResult = try await casperSDK.getPeers();
            let peerEntryList = getPeerResult.getPeerMap().getPeerEntryList();
            let totalPeer = peerEntryList.count;
            print("Total peer back:\(totalPeer)")
            if totalPeer > 10 {
                print("---------JUST PRINT 10 FIRST PEERS----------------")
                for i in 0...9 {
                    let onePeer:PeerEntry = peerEntryList[i];
                    print("Peer number \(i+1), id:\(onePeer.getNodeId()), address:\(onePeer.getAddress())")
                }
            }
        } catch {
            print("TEST-------------Error info_get_peer:\(error)")
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
