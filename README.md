
# casper-swift-sdk

Swift sdk library for interacting with a CSPR node.

## What is casper-swift-sdk ?

SDK  to streamline the 3rd party Swift client integration processes. Such 3rd parties include exchanges & app developers. 

## How To: Install ?



## How To: Query a node ?

To query a node, use the CasperSDK as the entry point. Instantiate CasperSDK using the `url` and `port` of the node

```swift
let casperSdk:CasperSKD = CasperSdk("http://0.0.0.0", 11101);
```

Note: The above url and port hold good for local nctl based nodes. Refer to this [page](https://caspernetwork.readthedocs.io/en/latest/dapp-dev-guide/setup-nctl.html) on how to set it up. If you want to test against a real node use `http://65.21.227.180` as the url and `7777` as the port.

Once we have the instance of `CasperSDK`, any implemented query method can be executed on it. For example if we want to get information about the state root hash, use the following code snippet:

```swift
        let casperSDK:CasperSDK = CasperSDK(url:"http://65.21.227.180:7777/rpc",port:7777);
        do {
            //TEST CALL chain_get_state_root_hash WITH BLOCK_HASH PARAMETER SENDING TO REQUEST
            let blockHash:String = "4F271045c649FA282eB569fc06eb84654D9065b4682293e4e30a03c319ECc2E9";
            let stateRootHash = try await casperSDK.getStateRootHash(blockHash:blockHash);
            print("TEST-------------chain_get_state_root_hash with block hash param in sending request, VALUE BACK:\(stateRootHash)")
        } catch {
            print("TEST-------------Error chain_get_state_root_hash:\(error)")
        }

        do {
            //TEST CALL chain_get_state_root_hash WITH NO BLOCK_HASH PARAMETER SENDING TO REQUEST
            let stateRootHashNoParam = try await casperSDK.getStateRootHash();
            print("TEST-------------chain_get_state_root_hash with no param in sending request VALUE BACK:\(stateRootHashNoParam)")
        }
        catch {
            print("TEST-------------Error chain_get_state_root_hash:\(error)")
        }
