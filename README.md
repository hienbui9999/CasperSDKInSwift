
# casper-swift-sdk

Swift sdk library for interacting with a CSPR node.

## What is casper-swift-sdk ?

SDK  to streamline the 3rd party Swift client integration processes. Such 3rd parties include exchanges & app developers. 

## System requirement


The SDK use Swift 5.0 and support device running IOS from 10.0, MacOS from 10.4.4, WatchOS from 5.3, tvOS from 12.3


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

In Project Targets select the project General setting, Scroll to “Frameworks, Libraries, and Embedded Content”, choose “+”, then “Add Other…”, then “Add Package Dependency”, parse the link https://github.com/hienbui9999/CasperSDKInSwift to “Search or Enter package URL” search box, then press the “Add package” button.

Now you can call the Casper RPC methods through the CasperSDK class.

Just put the following code

"import CasperSDKInSwift"

at the beginning of the file to refer for CasperSDK instance and call the method request


## How To: Query a node ?

To query a node, use the CasperSDK as the entry point. Instantiate CasperSDK with the URL address for calling Casper method, like this:

```swift
let casperSdk:CasperSKD = CasperSDK(url:"http://65.21.227.180:7777/rpc");
```

Once we have the instance of `CasperSDK`, any implemented query method can be executed on it. For example if we want to get information about the state root hash or get peers, use the following code snippet (The code below test several scenarios for calling method with different parameters):

```swift
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
```
