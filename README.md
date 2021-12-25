
# casper-swift-sdk

Swift sdk library for interacting with a CSPR node.

## What is casper-swift-sdk ?

SDK  to streamline the 3rd party Swift client integration processes. Such 3rd parties include exchanges & app developers. 

## How To: Install ?
For Xcode
In Project Targets select the project General setting, Scroll to “Frameworks, Libraries, and Embedded Content”, choose “+”, then “Add Other…”, then “Add Package Dependency”, parse the link “https://github.com/hienbui9999/CasperSDKInSwift” to “Search or Enter package URL” search box, then press the “Add package” button.
Now you can call the Casper RPC methods through the CasperSDK class.
Just put 
import CasperSDKInSwift
at the beginning of the file to refer for CasperSDK instance and call the method request

## How To: Query a node ?

To query a node, use the CasperSDK as the entry point. Instantiate CasperSDK using the `url` and `port` of the node

```swift
let casperSdk:CasperSKD = CasperSdk("http://0.0.0.0", 11101);
```

Note: The above url and port hold good for local nctl based nodes. Refer to this [page](https://caspernetwork.readthedocs.io/en/latest/dapp-dev-guide/setup-nctl.html) on how to set it up. If you want to test against a real node use `http://65.21.227.180` as the url and `7777` as the port.

Once we have the instance of `CasperSDK`, any implemented query method can be executed on it. For example if we want to get information about the state root hash, use the following code snippet:

```swift
        let casperSDK:CasperSDK = CasperSDK(url:"http://65.21.227.180",port:7777);
        var blockHash:String = "5d9F29103ba85e04358Ced6d504D201d9A32ffB7789Dc1B0E426d500CEDfdBCA";
        var blockHeight:UInt64 = 10;
        do {
            print("TEST 1 TEST 1 TEST 1 - WITH BLOCK_HASH AS PARAMS")
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
