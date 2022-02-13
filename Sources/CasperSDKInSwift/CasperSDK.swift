
import Foundation
public enum CasperError:Error {
    case invalidNumber
    case NONE
}
public enum CasperMethodError:Error {
    case invalidURL
    case invalidParams
    case parseError
    case methodNotFound
    case unknown
    case getDataBackError
    case NONE
}

public enum CasperMethodCallError:Error {
    case CasperError(code:Int,message:String,methodCall:String)
    case None
}

public enum CasperMethodCall:String {
    case chainGetStateRootHash          = "chain_get_state_root_hash"
    case infoGetPeer                    = "info_get_peers"
    case infoGetDeploy                  = "info_get_deploy"
    case infoGetStatus                  = "info_get_status"
    case chainGetBlockTransfer          = "chain_get_block_transfers"
    case chainGetBlock                  = "chain_get_block"
    case chainGetEraInfoBySwitchBlock   = "chain_get_era_info_by_switch_block"
    case stateGetItem                   = "state_get_item"
    case stateGetDictionaryItem         = "state_get_dictionary_item"
    case stateGetBalance                = "state_get_balance"
    case stateGetAuctionInfo            = "state_get_auction_info"
    case putDeploy                      = "account_put_deploy"
}
let CASPER_ID : Int32 = 1;
let CASPER_RPC_VERSION:String = "2.0"
public class CasperSDK {
    var methodURL:String = "https://node-clarity-testnet.make.services/rpc";
    var methodCall:CasperMethodCall = .chainGetStateRootHash;
    var httpHandler:HttpHandler = HttpHandler();
    public func setMethodUrl(url:String) {
        methodURL = url;
        HttpHandler.methodURL = methodURL;
    }
    public init(url:String) {
        self.methodURL = url;
        HttpHandler.methodURL = methodURL;
    }
    
    public func getStateRootHash(getStateRootHashParam:GetStateRootHashParam) throws {
        let data = JsonConversion.fromBlockIdentifierToJsonData(input: getStateRootHashParam.block_identifier, method: .chainGetStateRootHash)
        do {
            try httpHandler.handleRequest(method: methodCall, params: data)
        } catch {
            throw error
        }
    }
    
    //2.call for method info_get_peers
    public func getPeers() throws {
        methodCall = .infoGetPeer
        httpHandler.methodCall = .infoGetPeer
        do {
            try httpHandler.handleRequest(method: methodCall, params:JsonConversion.generatePostDataNoParam(method: .infoGetPeer))
        } catch {
            throw error
        }
    }
    //3.call for method info_get_deploy
    public func getDeploy(getDeployParam:GetDeployParams) throws {
        methodCall = .infoGetDeploy
        httpHandler.methodCall = .infoGetDeploy
        do {
            let params = getDeployParam.toJsonData()
            try httpHandler.handleRequest(method: methodCall, params: params)
        } catch {
            throw error
        }
    }
    //get status
    public func getStatus() throws {
        methodCall = .infoGetStatus
        httpHandler.methodCall = .infoGetStatus
        do {
            try httpHandler.handleRequest(method: methodCall, params:JsonConversion.generatePostDataNoParam(method: .infoGetStatus))
        } catch {
            throw error
        }
    }
    //get state dictionary item
    public func getDictionaryItem(from:GetDictionaryItemParams) throws {
        methodCall = .stateGetDictionaryItem
        httpHandler.methodCall = .stateGetDictionaryItem
        do {
            let jsonData = try from.toJsonData()
            try httpHandler.handleRequest(method: methodCall, params: jsonData )
        } catch {
            throw error
        }
    }
    //get era by switch block
    public func getEraBySwitchBlock(input:BlockIdentifier) throws {
        methodCall = .chainGetEraInfoBySwitchBlock
        httpHandler.methodCall = .chainGetEraInfoBySwitchBlock
        do {
            let params = JsonConversion.fromBlockIdentifierToJsonData(input: input, method: .chainGetEraInfoBySwitchBlock)
            try httpHandler.handleRequest(method: methodCall, params: params)
        } catch {
            throw error
        }
    }
    //state_get_item
    public func getItem(input:GetItemParams) throws {
        methodCall = .stateGetItem
        httpHandler.methodCall = .stateGetItem
        do {
            let params = JsonConversion.fromGetStateItemToJsonData(input:input)
            try httpHandler.handleRequest(method: methodCall, params: params)
        } catch {
            throw error
        }
    }
    //chain_get_block_transfers
    public func getBlockTransfers(input:BlockIdentifier) throws {
        methodCall = .chainGetBlockTransfer
        httpHandler.methodCall = .chainGetBlockTransfer
        do {
            let jsonData = JsonConversion.fromBlockIdentifierToJsonData(input:input,method: .chainGetBlockTransfer)
            try httpHandler.handleRequest(method: methodCall, params: jsonData)
        } catch {
            throw error
        }
    }
    //chain_get_block
    public func getBlock(input:BlockIdentifier) throws {
        methodCall = .chainGetBlock
        httpHandler.methodCall = .chainGetBlock
        do {
            let jsonData = JsonConversion.fromBlockIdentifierToJsonData(input: input, method: .chainGetBlock)
            try httpHandler.handleRequest(method: methodCall, params: jsonData)
        } catch {
            throw error
        }
    }
    public func getStateBalance(input:GetBalanceParams) throws {
        methodCall = .stateGetBalance
        httpHandler.methodCall = .stateGetBalance
        do {
            let jsonData = JsonConversion.fromGetBalanceParamsToJsonData(input: input)
            try httpHandler.handleRequest(method: methodCall, params: jsonData)
        } catch {
            throw error
        }
    } 
    public func getAuctionInfo(input:BlockIdentifier) throws {
        methodCall = .stateGetAuctionInfo
        httpHandler.methodCall = .stateGetAuctionInfo
        do {
            let paramJsonData = JsonConversion.fromBlockIdentifierToJsonData(input: input, method: .stateGetAuctionInfo)
            try httpHandler.handleRequest(method: methodCall, params: paramJsonData)
        } catch {
            throw error
        }
    }
    //M4 put deploy
    public func putDeploy(input:Deploy) throws {
        methodCall = .putDeploy
        httpHandler.methodCall = .putDeploy
        do  {
            //let data = DeployUtil.fromDeployToJson(deploy:input)
           // try httpHandler.handleRequest(method: methodCall, params: data, httpMethod: "PUT")
        } catch {
            throw error
        }
    }
}
