
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

# Documentation for classes and methods


* [List of classes and methods](./Docs/Help.md)

-  [Get State Root Hash](./Docs/Help.md#i-get-state-root-hash)

-  [Get Peer List](./Docs/Help.md#ii-get-network-peers-list)

-  [Get Deploy](./Docs/Help.md#iii-get-deploy)

-  [Get Node Status](./Docs/Help.md#iv-get-node-status)

-  [Get Block Transfer](./Docs/Help.md#v-get-blocktransfers)

-  [Get Block](./Docs/Help.md#vi-get-block)

-  [Get EraInfo By Switch Block](./Docs/Help.md#vii-get-erainfo-by-switch-block)

-  [Get State Item](./Docs/Help.md#viii-get-stateitem)

-  [Get Dictionary Item](./Docs/Help.md#ix-get-dictionaryitem)

- *[Get Balance](./Docs/Help.md#x-get-balance)

- *[Get Current Auction State] (./Docs/Help.md#x-get-balance)

## Flow of processing:

Instantiate one instance of the CasperSKD, which is defined in file "CasperSDK.swift". In the test section of this project we instantiate it from "CasperSDKInSwiftTests.swift" file and set parameter and call the methods from this file.

The call for each method will then send POST request and get data back from server, this process is done in "HttpHandler" file.

For processing the data back from server (as Json format), base on which method call, the corresponding class and functions will be call to catch and put data in proper data structure, which started from this code line "if self.methodCall == .chainGetStateRootHash {" in "HttpHandler" file.


# Usage examples 

## Create a Client

To query a node, use the CasperSDK as the entry point. Instantiate CasperSDK with the URL address for calling Casper method, like this:

```swift
let casperSDK:CasperSKD = CasperSDK(url:"https://node-clarity-testnet.make.services/rpc");
```

You can change the method url by running this code line

```swift
casperSDK.setMethodUrl(url: "https://node-clarity-mainnet.make.services/rpc")
```

## RPC Calls

### I. Get State Root Hash  

Retrieves  the state root hash String. There are 3 cases for calling this method

1 - call method without any param
2 - call method with BlockHash param
3 - call method with BlockHeight param

And this is the detail for each cases:

1- call method without any param:

``` swift
let getStateRootHashParam:GetStateRootHashParam = GetStateRootHashParam();
do {
    try casperSDK.getStateRootHash(getStateRootHashParam: getStateRootHashParam)
} catch {
    throw error
}
```

2 - call method with BlockHash param - You can test with other block_hash by replacing the below hash in .Hash("") parameter

``` swift
do {
    getStateRootHashParam.block_identifier = .Hash("20e6cf8001a9456e9e202f0923393b1f551470934683800f62d11c1685d4710d")
    try casperSDK.getStateRootHash(getStateRootHashParam: getStateRootHashParam)
} catch {
    throw error
}
```

3 - call method with BlockHeight param - You can test with other block Height by replacing the below Height in the .Height() parameter

``` swift
do {
    getStateRootHashParam.block_identifier = .Height(473861)
    try casperSDK.getStateRootHash(getStateRootHashParam: getStateRootHashParam)
} catch {
    throw error
}
```

### II. Get network peers list  

Retrieves  a list of Peers.

``` swift
       
do {
    try casperSDK.getPeers()
} catch {
    throw error
}
```

### III. Get Deploy

Retrieves a Deploy object.

call parameters :
- deploy hash

``` swift
do {
      let getDeployParam:GetDeployParams = GetDeployParams();
      getDeployParam.deploy_hash = "1b6a2f1a67bc087babe46455f4c6e7775528999fd3a37dbcba5b438f439abda2";
      try casperSDK.getDeploy(getDeployParam: getDeployParam)
} catch {
    throw error
  }
```

###  IV. Get Node Status

Retrieves a NodeStatus object.

``` swift
do {
    try casperSDK.getStatus()
} catch {
    throw error
}
```
### V. Get BlockTransfers

Retrieves Transfert List within a block.

call parameters :

- block_identifier, and enum type which can be either BlockHash or BlockHeight 

Call by BlockHash, you can change the BlockHash in the .Hash("") parameter

``` swift
do {
    let block_identifier : BlockIdentifier = .Hash("ae173969cb6ce3c99439c81e5b803c15797a8559796d980daa99f52beb7192e3")
    try casperSDK.getBlockTransfers(input: block_identifier)
}  catch {
    throw error
}
```

Call by BlockHeight, you can change the BlockHeight in the .Height() parameter

``` swift
do {
    let block_identifier  : BlockIdentifier = .Height(448471)
    try casperSDK.getBlockTransfers(input: block_identifier)
}  catch {
    throw error
}
```

### VI. Get Block 

Retrieves a Block object.

call parameters :

- block_identifier, and enum type which can be either BlockHash or BlockHeight

Call by BlockHash, you can change the BlockHash in the .Hash("") parameter

``` swift
do {
    let block_identifier2 : BlockIdentifier = .Hash("830fd58dd08189981d7535fc9de0606bc789b2c8ef2af895ebce5ffc23c4530e")
    try casperSDK.getBlock(input: block_identifier2)
}  catch {
    throw error
}
```

Call by BlockHeight, you can change the BlockHeight in the .Height() parameter

``` swift
do {
    let block_identifier:BlockIdentifier = .Height(449797)
    try casperSDK.getBlock(input: block_identifier)
}  catch {
    throw error
}
```

### VII. Get EraInfo By Switch Block 

Retrieves an EraSummury object.

call parameters :

- switch  block (last block within an era) hash, which is a block_identifier, and enum type which can be either BlockHash or BlockHeight

Call by BlockHeight, you can change the BlockHeight in the .Height() parameter

``` swift
do {
    let block_identifier:BlockIdentifier = .Height(441636)
    try casperSDK.getEraBySwitchBlock(input: block_identifier)
} catch {
    throw error
}
```

Call by BlockHash, you can change the BlockHash in the .Hash("") parameter

``` swift
do {
    let block_identifier:BlockIdentifier = .Hash("83a86ba2d753d85cdd974cf2bb0f6cb5d446f00c2f7f89b5a5e4fef208b19fcc")
    try casperSDK.getEraBySwitchBlock(input: block_identifier)
} catch {
    throw error
}
```

### VIII. Get StateItem

Retrieves a StoredValue object.

Here is some example of getting different kinds of StoredValue

   #### 1. StoredValue as Contract :

call parameters :

- state root hash
- contract hash

``` swift
do {
    let getStateItemParam:GetItemParams = GetItemParams();
    getStateItemParam.state_root_hash = "83f6dca28102ecf1cf79d2e32172044b2eacf527e47a8781cead3850d01e6328"
    getStateItemParam.key = "hash-b36478fa545160796de902e61ac504b33bc14624eea245a9df525b4d92d150bc"
    try casperSDK.getItem(input: getStateItemParam)
} catch {
    throw error
}
```

  #### 2. StoredValue as account  :

call parameters :

- state root hash
- account hash

``` swift
do {
    let getStateItemParam:GetItemParams = GetItemParams();
    getStateItemParam.state_root_hash = "b31f42523b6799d6d403a3119596c958abf2cdba31066322f01e5fa38ef999aa"
    getStateItemParam.key = "account-hash-ff2ae80f71c1ffcac4921100a21b67ddecf59a30fb86eb6979f47c8838b3b7d3"   
    try casperSDK.getItem(input: getStateItemParam)
} catch {
    throw error
}
```
  #### 3. StoredValue as transfer  :

call parameters :

- state root hash
- transfer hash

``` swift
do {
    let getStateItemParam:GetItemParams = GetItemParams();
   // getStateItemParam.state_root_hash = "1416302b2c637647e2fe8c0b9f7ee815582cc7a323af5823313ff8a8684c8cf8"
   // getStateItemParam.key = "transfer-8218fa8c55c19264e977bf2bae9f5889082aee4d2c4eaf9642478173c37d1ed4"
         try casperSDK.getItem(input: getStateItemParam)
} catch {
    throw error
}
```

  #### 4. StoredValue as DeployInfo  :

call parameters :

- state root hash
- deploy info hash

``` swift
do {
    let getStateItemParam:GetItemParams = GetItemParams();
    getStateItemParam.state_root_hash = "1416302b2c637647e2fe8c0b9f7ee815582cc7a323af5823313ff8a8684c8cf8"
    getStateItemParam.key = "deploy-a49c06f9b2adf02812a7b2fdcad08804a2ce4896ffec7c06c920d417e7e39cfe"
    try casperSDK.getItem(input: getStateItemParam)
} catch {
    throw error
}
```

  #### 5. StoredValue as Bid  :

call parameters :

- state root hash
- bid hash
This example call the main net

``` swift
do {
    casperSDK.setMethodUrl(url: "https://node-clarity-mainnet.make.services/rpc")
    let getStateItemParam:GetItemParams = GetItemParams();
    getStateItemParam.state_root_hash = "647C28545316E913969B032Cf506d5D242e0F857061E70Fb3DF55980611ace86"
    getStateItemParam.key = "bid-24b6D5Aabb8F0AC17D272763A405E9CECa9166B75B745Cf200695E172857c2dD"
     try casperSDK.getItem(input: getStateItemParam)
} catch {
    throw error
}
```

  #### 6. StoredValue as Withdraw  :

call parameters :

- state root hash
- withdraw hash
This example call the test net

``` swift
do {
    casperSDK.setMethodUrl(url: "https://node-clarity-mainnet.make.services/rpc")
    let getStateItemParam:GetItemParams = GetItemParams();
    getStateItemParam.state_root_hash = "d360e2755f7cee816cce3f0eeb2000dfa03113769743ae5481816f3983d5f228"
    getStateItemParam.key = "withdraw-df067278a61946b1b1f784d16e28336ae79f48cf692b13f6e40af9c7eadb2fb1"
     try casperSDK.getItem(input: getStateItemParam)
} catch {
    throw error
}
```

### IX. Get DictionaryItem

Retrieves a CLValue object.

call parameters :

- state root hash
- dictionary_identifier (which an enum type defined in this page https://docs.rs/casper-node/latest/casper_node/rpcs/state/enum.DictionaryIdentifier.html) - there can be 4 possible kinds of value for parameters:

 1 - AccountNamedKey
 
 2 - ContractNamedKey
 
 3 - URef
 
 4 - Dictionary

Call specification in detail for each type: 

  #### 1. dictionary_identifier  parameter as  AccountNamedKey:

``` swift
 do {
     let getDic : GetDictionaryItemParams = GetDictionaryItemParams();
     getDic.state_root_hash = "146b860f82359ced6e801cbad31015b5a9f9eb147ab2a449fd5cdb950e961ca8";
     getDic.dictionary_identifier = DictionaryIdentifier.AccountNamedKey(key: "account-hash-ad7e091267d82c3b9ed1987cb780a005a550e6b3d1ca333b743e2dba70680877", dictionary_name: "dict_name", dictionary_item_key: "abc_name")
         try casperSDK.getDictionaryItem(from: getDic)
 }  catch {
     throw error
 }
 ```
 
   #### 2. dictionary_identifier  parameter as  ContractNamedKey:

``` swift
 do {
     let getDic : GetDictionaryItemParams = GetDictionaryItemParams();
     getDic.state_root_hash = "146b860f82359ced6e801cbad31015b5a9f9eb147ab2a449fd5cdb950e961ca8";
     getDic.dictionary_identifier = DictionaryIdentifier.ContractNamedKey(key: "hash-d5308670dc1583f49a516306a3eb719abe0ba51651cb08e606fcfc1f9b9134cf", dictionary_name: "dictname", dictionary_item_key: "abcname")
    try casperSDK.getDictionaryItem(from: getDic)
 }  catch {
     throw error
 }
 ```
 
   #### 3. dictionary_identifier  parameter as  URef:

``` swift
 do {
     let getDic : GetDictionaryItemParams = GetDictionaryItemParams();
     getDic.state_root_hash = "146b860f82359ced6e801cbad31015b5a9f9eb147ab2a449fd5cdb950e961ca8";
     getDic.dictionary_identifier = DictionaryIdentifier.URef(seed_uref: "uref-30074a46a79b2d80cff437594d2422383f6c754de453b732448cc711b9f7e129-007", dictionary_item_key: "abc_name")
             try casperSDK.getDictionaryItem(from: getDic)
 }  catch {
     throw error
 }
 ```
 
   #### 4. dictionary_identifier  parameter as  Dictionary:

``` swift
 do {
     let getDic : GetDictionaryItemParams = GetDictionaryItemParams();
     getDic.state_root_hash = "146b860f82359ced6e801cbad31015b5a9f9eb147ab2a449fd5cdb950e961ca8";
     getDic.dictionary_identifier = DictionaryIdentifier.Dictionary( "dictionary-5d3e90f064798d54e5e53643c4fce0cbb1024aadcad1586cc4b7c1358a530373")
 }  catch {
     throw error
 }
 ```
### X. Get Balance

Retrieves the balances(in motes) of an account

call parameters :

- state root hash
- account uref hash


``` swift
        
do {
    let getBP : GetBalanceParams = GetBalanceParams();
    getBP.state_root_hash = "8b463b56f2d124f43e7c157e602e31d5d2d5009659de7f1e79afbd238cbaa189";
    getBP.purse_uref = "uref-be1dc0fd639a3255c1e3e5e2aa699df66171e40fa9450688c5d718b470e057c6-007";
    try casperSDK.getStateBalance(input: getBP)
}  catch {
    throw error
}
 ```
 ### XI. Get current auction state

Retrieves an AutionState object.

call parameters :
- block_identifier, and enum type which can be either BlockHash or BlockHeight 

Call by BlockHash, you can change the BlockHash in the .Hash("") parameter

``` swift
do {
    let block_identifier:BlockIdentifier = .Hash("cb8dab9f455538bc6cedb217a6234faeece8ce32c94d053b5b770450290b3a30")
    try casperSDK.getAuctionInfo(input: block_identifier)
} catch {
    
}
```
Call by BlockHeight, you can change the BlockHeight in the .Height() parameter

``` swift
do {
    let block_identifier:BlockIdentifier = .Height(473576)
    try casperSDK.getAuctionInfo(input: block_identifier)
} catch {
    
}
```

