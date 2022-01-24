
# casper-swift-sdk manual on classes and methods
This is the documentation for the following methods call for Casper RPC

1) chain_get_state_root_hash

2) info_get_peers

3) info_get_deploy

4) info_get_status

5) chain_get_block_transfers

6) chain_get_block

7) chain_get_era_info_by_switch_block

8) state_get_item

9) state_get_dictionary_item

10) state_get_balance

11) state_get_auction_info


# Classes and methods in detail 

## RPC Calls

### I. Get State Root Hash  

#### 1. Method declaration

```swift
        public func getStateRootHash(getStateRootHashParam:GetStateRootHashParam)
```

#### 2. Input: GetStateRootHashParam object, which consist of a BlockIdentifier enum object, with value of either .Hash(String) or Height(UInt64) or None (if send method without any parameter to get the latest state_root_hash)

#### 3. Method flow detail:

- input getStateRootHashParam of type GetStateRootHashParam will be used to make json data for post method 

```swift
let data = JsonConversion.fromBlockIdentifierToJsonData(input: getStateRootHashParam.block_identifier, method: .chainGetStateRootHash)
```

- Then json data will be sent to the  httpHandler object of HttpHandler class with the method call and json data just generated.

```swift
httpHandler.handleRequest(method: methodCall, params: data)
```

In the handleRequest function the state root hash is retrieved by running this code line

```swift
let stateRootHash = try GetStateRootHash.getStateRootHash(from: responseJSON);
```


### II. Get network peers list  

#### 1. Method declaration

```swift
public func getPeers()
```

#### 2. Input: None

#### 3. Method flow detail:

- Call to  httpHandler object of HttpHandler class.

```swift
httpHandler.handleRequest(method: methodCall, params: data)
```

In the handleRequest function the peer list is retrieved by running this code line

```swift
let getPeer:GetPeersResult = try GetPeers.getPeers(from: responseJSON)
```


### III. Get Deploy

#### 1. Method declaration

```swift
public func getDeploy(getDeployParam:GetDeployParams)
```

#### 2. Input: GetDeployParams object, which consist of a deploy_hash string 

#### 3. Method flow detail:

- input getDeployParam of type GetDeployParams will be used to make json data for post method 

```swift
let params = getDeployParam.toJsonData()
```

- Then json data will be sent to the  httpHandler object of HttpHandler class with the method call and json data just generated.

```swift
httpHandler.handleRequest(method: methodCall, params: data)
```

In the handleRequest function the GetDeployResult is retrieved by running this code line

```swift
let getDeployResult : GetDeployResult = try GetDeploy.getDeploy(from: responseJSON)
```

###  IV. Get Node Status

#### 1. Method declaration

```swift
public func getStatus()
```

#### 2. Input: None

#### 3. Method flow detail:

- Call to  httpHandler object of HttpHandler class.

```swift
httpHandler.handleRequest(method: methodCall, params: data)
```

In the handleRequest function the GetStatusResult is retrieved by running this code line

```swift
let getStatusResult:GetStatusResult = try GetStatus.getStatus(from:responseJSON)
```

### V. Get BlockTransfers

#### 1. Method declaration

```swift
public func getBlockTransfers(input:BlockIdentifier)
```

#### 2. Input: BlockIdentifier enum object, with value of either .Hash(String) or Height(UInt64) 

#### 3. Method flow detail:

- input of type BlockIdentifier will be used to make json data for post method 

```swift
let jsonData = JsonConversion.fromBlockIdentifierToJsonData(input:input,method: .chainGetBlockTransfer)
```

- Then json data will be sent to the  httpHandler object of HttpHandler class with the method call and json data just generated.

```swift
httpHandler.handleRequest(method: methodCall, params: data)
```

In the handleRequest function the GetBlockTransfersResult is retrieved by running this code line

```swift
let getBlockTransferResult:GetBlockTransfersResult = try GetBlockTransfers.getResult(from: responseJSON)
```

### VI. Get Block 

#### 1. Method declaration

```swift
public func getBlock(input:BlockIdentifier)
```

#### 2. Input: BlockIdentifier enum object, with value of either .Hash(String) or Height(UInt64) 

#### 3. Method flow detail:

- input of type BlockIdentifier will be used to make json data for post method 

```swift
let jsonData = JsonConversion.fromBlockIdentifierToJsonData(input: input, method: .chainGetBlock)
```

- Then json data will be sent to the  httpHandler object of HttpHandler class with the method call and json data just generated.

```swift
httpHandler.handleRequest(method: methodCall, params: data)
```

In the handleRequest function the GetBlockResult is retrieved by running this code line

```swift
let getBlockResult:GetBlockResult = try GetBlock.getBlock(from: responseJSON)
```

### VII. Get EraInfo By Switch Block 

#### 1. Method declaration

```swift
public func getEraBySwitchBlock(input:BlockIdentifier)
```

#### 2. Input: BlockIdentifier enum object, with value of either .Hash(String) or Height(UInt64) 

#### 3. Method flow detail:

- input of type BlockIdentifier will be used to make json data for post method 

```swift
let params = JsonConversion.fromBlockIdentifierToJsonData(input: input, method: .chainGetEraInfoBySwitchBlock)
```

- Then json data will be sent to the  httpHandler object of HttpHandler class with the method call and json data just generated.

```swift
httpHandler.handleRequest(method: methodCall, params: data)
```

In the handleRequest function the GetEraInfoResult is retrieved by running this code line

```swift
let eraResult:GetEraInfoResult = try GetEraInfoBySwitchBlock.getResult(from: responseJSON)
```

### VIII. Get StateItem

#### 1. Method declaration

```swift
    public func getItem(input:GetItemParams)
```

#### 2. Input: GetItemParams which is defined as

```swift
 public class GetItemParams {
    public var state_root_hash:String?
    public var key:String?
    public var path:[String]?
}
```

#### 3. Method flow detail:

- input of type GetItemParams will be used to make json data for post method 

```swift
let params = JsonConversion.fromGetStateItemToJsonData(input:input)
```

- Then json data will be sent to the  httpHandler object of HttpHandler class with the method call and json data just generated.

```swift
httpHandler.handleRequest(method: methodCall, params: data)
```

In the handleRequest function the GetItemResult is retrieved by running this code line

```swift
let getStateItemResult: GetItemResult =  GetItem.getItem(from:responseJSON)
```

### IX. Get DictionaryItem

#### 1. Method declaration

```swift
public func getDictionaryItem(from:GetDictionaryItemParams)
```

#### 2. Input: GetDictionaryItemParams which is defined as

```swift
public class GetDictionaryItemParams : Codable {
    var state_root_hash:String!;
    var dictionary_identifier: DictionaryIdentifier!;
}
```

in which DictionaryIdentifier is an enum defined as

```swift
public enum DictionaryIdentifier : Codable {
    case AccountNamedKey(key:String,dictionary_name:String,dictionary_item_key:String)
    case ContractNamedKey(key:String,dictionary_name:String,dictionary_item_key:String)
    case URef(seed_uref:String,dictionary_item_key:String)
    case Dictionary(String)
}
```

#### 3. Method flow detail:

- input of type GetDictionaryItemParams will be used to make json data for post method 

```swift
let jsonData = try from.toJsonData() // from is the GetDictionaryItemParams object
```

- Then json data will be sent to the  httpHandler object of HttpHandler class with the method call and json data just generated.

```swift
httpHandler.handleRequest(method: methodCall, params: data)
```

In the handleRequest function the GetDictionaryItemResult is retrieved by running this code line

```swift
let getDictionaryItemResult : GetDictionaryItemResult = try GetDictionaryItemResult.getResult(from: responseJSON)
```

### X. Get Balance

#### 1. Method declaration

```swift
public func getStateBalance(input:GetBalanceParams)
```

#### 2. Input: GetBalanceParams which is defined as

```swift
 public class GetBalanceParams {
    public var state_root_hash:String = ""
    public var purse_uref:String = ""
}
```

#### 3. Method flow detail:

- input of type GetBalanceParams will be used to make json data for post method 

```swift
let jsonData = JsonConversion.fromGetBalanceParamsToJsonData(input: input)
```

- Then json data will be sent to the  httpHandler object of HttpHandler class with the method call and json data just generated.

```swift
httpHandler.handleRequest(method: methodCall, params: jsonData)
```

In the handleRequest function the GetBalanceResult is retrieved by running this code line

```swift
let getBalanceResult:GetBalanceResult = try GetBalance.getStateBalanceFromJson(from: responseJSON)
```

 ### XI. Get current auction state
 
 
#### 1. Method declaration

```swift
public func getAuctionInfo(input:BlockIdentifier)
```

#### 2. Input: BlockIdentifier enum object, with value of either .Hash(String) or Height(UInt64) 

#### 3. Method flow detail:

- input of type BlockIdentifier will be used to make json data for post method 

```swift
let paramJsonData = JsonConversion.fromBlockIdentifierToJsonData(input: input, method: .stateGetAuctionInfo)
```

- Then json data will be sent to the  httpHandler object of HttpHandler class with the method call and json data just generated.

```swift
httpHandler.handleRequest(method: methodCall, params: jsonData)
```

In the handleRequest function the GetBalanceResult is retrieved by running this code line

```swift
let getAuctionInfo:GetAuctionInfoResult = try GetAuctionInfo.getAuctionInfo(from: responseJSON)
```
