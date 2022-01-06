
# casper-swift-sdk

Swift sdk library for interacting with a CSPR node.

## What is casper-swift-sdk ?

SDK  to streamline the 3rd party Swift client integration processes. Such 3rd parties include exchanges & app developers. 


## Build and test from terminal 

Go to the SKD root folder.

- Build command in terminal, type this in terminal

swift build

- Test command in terminal, type this in terminal

swift test

- For a full build,test on the SKD, run the following command

swift package clean

swift build

swift test


## Build and test from Xcode IDE

In Project Targets select the project General setting, Scroll to “Frameworks, Libraries, and Embedded Content”, choose “+”, then “Add Other…”, then “Add Package Dependency”, parse the link “https://github.com/hienbui9999/CasperSDKInSwift” to “Search or Enter package URL” search box, then press the “Add package” button.

Now you can call the Casper RPC methods through the CasperSDK class.

Just put the following code

"import CasperSDKInSwift"

at the beginning of the file to refer for CasperSDK instance and call the method request


## How To: Query a node ?

To query a node, use the CasperSDK as the entry point. Instantiate CasperSDK using the `url` and `port` of the node

```swift
let casperSdk:CasperSKD = CasperSdk("http://0.0.0.0:11101");
```

Note: The above url and port hold good for local nctl based nodes. Refer to this [page](https://caspernetwork.readthedocs.io/en/latest/dapp-dev-guide/setup-nctl.html) on how to set it up. If you want to test against a real node use `http://65.21.227.180` as the url and `7777` as the port.

Once we have the instance of `CasperSDK`, any implemented query method can be executed on it. For example if we want to get information about the state root hash, use the following code snippet (The code below test several scenarios for calling method with different parameters):

```swift
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
        //THIS IS TEST FOR CALLING METHOD info_get_peers
        do {
            try casperSDK.getPeers()
        } catch {
            throw error
        }
