
# casper-swift-sdk manual on classes and methods, serialization

This is the documentation for the method call for Casper RPC and the serialization for Casper Domain Specific Objects

The RPC methods are listed as below:

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

The serialization work is done with the following work:

- Build CLType primitives structure

- Build CLValue structure

- Build Casper Domain Specific Objects

- Serialization of Casper Domain Specific Objects

# Classes and methods in detail 

## RPC Calls

### I. Get State Root Hash  

#### 1. Method declaration

```swift
        public func getStateRootHash(getStateRootHashParam:GetStateRootHashParam)
```

#### 2. Input & Output: 

Input: GetStateRootHashParam object, which consist of a BlockIdentifier enum object, with value of either .Hash(String) or Height(UInt64) or None (if send method without any parameter to get the latest state_root_hash)

Base on the input, the folowing output is possible:

- Input: Hash(block_hash) with correct block_hash of a block, Output: the state root hash of the block with the specific hash of the input

- Input: Hash(block_hash) with wrong block_hash or non-exist block_hash, Output: the state root hash of the latest block

- Input: Height(block_height) with correct block_height, Output: the state root hash of the block with the specific height of the input 

- Input: Height(block_height) with wrong block_height, such as the value is too big, Output: A block not found Error is thrown.

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

#### 2. Input & Output: 

- Input: None

- Output: List of peer defined in class GetPeersResult, which contain a list of PeerEntry - a class contain of nodeId and address.


#### 3. Method flow detail:

- Call to  httpHandler object of HttpHandler class.

```swift
httpHandler.handleRequest(method: methodCall, params: data)
```

In the handleRequest function the peer list is retrieved by running this code line

```swift
let getPeer:GetPeersResult = try GetPeers.getPeers(from: responseJSON)
```

You can then retrieve all the peer through the getPeer object (of class GetPeersResult), for example this following code log out all retrieved peers:

```swift
let peerEntries:[PeerEntry] = getPeer.getPeerMap().getPeerEntryList()
for peerEntry in peerEntries {
    NSLog("Peer address:\(peerEntry.address)")
    NSLog("Peer id:\(peerEntry.nodeID)")
}
```

### III. Get Deploy

#### 1. Method declaration

```swift
public func getDeploy(getDeployParam:GetDeployParams)
```

#### 2. Input & Output: 

- Input: GetDeployParams object, which consist of a deploy_hash string 

- Output: The GetDeployResult class object, which represent all information the deploy should contain.

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

You can then retrieve information such as:

- getDeployResult.api_version

- getDeployResult.deploy

- getDeployResult.execution_results

In which from getDeployResult.deploy you can retrieve information such as:

-  getDeployResult.deploy.hash

- getDeployResult.deploy.header

- getDeployResult.deploy.payment

- getDeployResult.deploy.session

- getDeployResult.deploy.approvals


From getDeployResult.execution_results you can retrieve information such as:

- getDeployResult.execution_results.first.block_hash

- getDeployResult.execution_results.first.result


###  IV. Get Node Status

#### 1. Method declaration

```swift
public func getStatus()
```

#### 2. Input & Output

- Input: None

- Output: GetStatusResult object, which contain all information of a node status

#### 3. Method flow detail:

- Call to  httpHandler object of HttpHandler class.

```swift
httpHandler.handleRequest(method: methodCall, params: data)
```

In the handleRequest function the GetStatusResult is retrieved by running this code line

```swift
let getStatusResult:GetStatusResult = try GetStatus.getStatus(from:responseJSON)
```

You can then get the state root hash or peer entry list by taking the following attribute of the returning object: 

- getStatusResult.starting_state_root_hash for the state root hash
                        
- getStatusResult.peers.getPeerEntryList() for the peer entry list


### V. Get BlockTransfers

#### 1. Method declaration

```swift
public func getBlockTransfers(input:BlockIdentifier)
```

#### 2. Input & Output: 

- Input: BlockIdentifier enum object, with value of either .Hash(String) or Height(UInt64) 

- Output: GetBlockTransfersResult object, which contain all information of block transfer

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

You can then get the information of the GetBlockTransfersResult by using the following properties:

- getBlockTransferResult.api_version

- getBlockTransferResult.block_hash

- getBlockTransferResult.transfers


### VI. Get Block 

#### 1. Method declaration

```swift
public func getBlock(input:BlockIdentifier)
```

#### 2. Input & Output: 

- Input: BlockIdentifier enum object, with value of either .Hash(String) or Height(UInt64) 

- Output: GetBlockResult object, which contain all information of a block

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

From this you can get the block information by using the following properties:

- getBlockResult.apiVersion

- getBlockResult.block.hash

- getBlockResult.block.header

- getBlockResult.block.body

- getBlockResult.block.proofs
     

### VII. Get EraInfo By Switch Block 

#### 1. Method declaration

```swift
public func getEraBySwitchBlock(input:BlockIdentifier)
```

#### 2. Input & Output: 

- Input: BlockIdentifier enum object, with value of either .Hash(String) or Height(UInt64) 

- Output: GetEraInfoResult object 

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

You can then retrieve information such as:

- eraResult.api_version

- eraResult.era_summary.block_hash

- eraResult.era_summary.era_id

- eraResult.era_summary.stored_value

- eraResult.era_summary.state_root_hash

- eraResult.era_summary.merkle_proof


### VIII. Get StateItem

#### 1. Method declaration

```swift
    public func getItem(input:GetItemParams)
```

#### 2. Input & Output: GetItemParams which is defined as

- Input: 

```swift
 public class GetItemParams {
    public var state_root_hash:String?
    public var key:String?
    public var path:[String]?
}
```

Output: GetItemResult object

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

You can then retrieve information such as:

- getStateItemResult.api_version

- getStateItemResult.stored_value

- getStateItemResult.merkle_proof
 

### IX. Get DictionaryItem

#### 1. Method declaration

```swift
public func getDictionaryItem(from:GetDictionaryItemParams)
```

#### 2. Input & Output: GetDictionaryItemParams which is defined as

- Input: 

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

- Output: GetDictionaryItemResult object


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

You can then retrieve information such as:

- getDictionaryItemResult.api_version

- getDictionaryItemResult.dictionary_key

- getDictionaryItemResult.stored_value

- getDictionaryItemResult.merkle_proof


### X. Get Balance

#### 1. Method declaration

```swift
public func getStateBalance(input:GetBalanceParams)
```

#### 2. Input & Output : 

- Input: GetBalanceParams which is defined as

```swift
 public class GetBalanceParams {
    public var state_root_hash:String = ""
    public var purse_uref:String = ""
}
```

- Output: GetBalanceResult object

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

You can then retrieve information such as:

- getBalanceResult.api_version

- getBalanceResult.balance_value

- getBalanceResult.merkle_proof


 ### XI. Get current auction state
 
#### 1. Method declaration

```swift
public func getAuctionInfo(input:BlockIdentifier)
```

#### 2. Input & Output:

- Input: BlockIdentifier enum object, with value of either .Hash(String) or Height(UInt64) 

- Output: GetAuctionInfoResult object

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

You can then retrieve information such as:

- getAuctionInfo.api_version

- getAuctionInfo.auction_state.state_root_hash

- getAuctionInfo.auction_state.block_height

- getAuctionInfo.auction_state.era_validators


# CLType, CLValue, Casper Domain Specific Objects and Serialization 

## CLType

 Implemented in enumeration type, declared as below code:

```swift
public enum CLType {
    case Bool
    case I32
    case I64
    case U8
    case U32
    case U64
    case U128
    case U256
    case U512
    case Unit
    case String
    case Key
    case URef
    case PublicKey
    case BytesArray(UInt32);
    indirect case Result(CLType,CLType)
    indirect case Option(CLType)
    indirect case List(CLType)
    indirect case FixedList(CLType)
    indirect case Map(CLType,CLType)
    indirect case Tuple1(CLType)
    indirect case Tuple2(CLType,CLType)
    indirect case Tuple3(CLType,CLType,CLType)
    case CLAny
    case NONE
}
```

## CLValue

Implemented in enumeration type with name CLValueWrapper, declared as below code:

```swift
public enum CLValueWrapper {
    case Bool(Bool)
    case I32(Int32)
    case I64(Int64)
    case U8(UInt8)
    case U32(UInt32)
    case U64(UInt64)
    case U128(U128Class)
    case U256(U256Class)
    case U512(U512Class)
    case Unit(String)
    case String(String)
    case Key(String)
    case URef(String)
    case PublicKey(String)
    case BytesArray(String)
    indirect case OptionWrapper(CLValueWrapper)
    indirect case ListWrapper([CLValueWrapper])
    indirect case FixedListWrapper([CLValueWrapper])
    indirect case ResultWrapper(String,CLValueWrapper)
    indirect case MapWrapper([CLValueWrapper],[CLValueWrapper])
    indirect case Tuple1Wrapper(CLValueWrapper)
    indirect case Tuple2Wrapper(CLValueWrapper,CLValueWrapper)
    indirect case Tuple3Wrapper(CLValueWrapper,CLValueWrapper,CLValueWrapper)
    case AnyCLValue(AnyObject)
    case NULL
    case NONE
}
```

This CLValue enumeration data structure contain both the type of CLType and the corresponding value for CLType. For example if CLValueWrapper has the value of .String("Hello, World!") then the CLType is String and the value is "Hello, World!"

If CLValueWrapper has the value of .ListWrapper([UInt32(1),UInt32(2),UInt32(3)]) then the CLType is List and the value is a list of 3 UInt32 elements with value [1,2,3]

### Casper Domain Specific Objects: 

Are built with corresponding Swift classes, and in Entity folder

### Serialization

The serialization for CLType, CLValue and Deploy (which consists of Deploy Header, Deploy Session, Deploy Payment, Approvals) is implemented based on the document at this address: https://casper.network/docs/design/serialization-standard#serialization-standard-state-keys

For CLType and CLValue, the serialization is done within class CLTypeSerializeHelper, which consists of two main methods:

 - CLTypeSerialize is for CLType serialization
 
 - CLValueSerialize is for CLValue serialization
 
 For Deploy and Deploy related objects (Deploy Header, Deploy Session, Deploy Payment, Approvals) is done within file DeploySerialization.swift, in which there are classes for the serialization work
  
- DeploySerialization class is for Deploy Serialization

- DeployHeaderSerialization class is for Deploy Header Serialization

- ExecutableDeployItemSerializaton class is for Session and Payment Serialization

- DeployApprovalSerialization class is for Approval Serialization
