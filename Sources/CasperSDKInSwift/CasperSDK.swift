
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

/**
 Enumeration type represents the RPC method call
 */

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
/**
 Class represents the CasperSDK. This class is the source for calling PRC methods
 */

public class CasperSDK {
    ///Method URL of the RPC call
    var methodURL:String = "https://node-clarity-testnet.make.services/rpc";
    ///RPC method call name
    var methodCall:CasperMethodCall = .chainGetStateRootHash;
    ///HttpHandler  for POST request when call RPC
    var httpHandler:HttpHandler = HttpHandler();
    /**
       Set the URL for RPC method call , which can be test net or main net
       - Parameter : url for RPC method call
       - Returns: none
       */

    public func setMethodUrl(url:String) {
        methodURL = url;
        HttpHandler.methodURL = methodURL;
    }
    /**
       Init function with predefined  URL for RPC method call , which can be test net or main net
       - Parameter : url for RPC method call
       - Returns: none
       */
    public init(url:String) {
        self.methodURL = url;
        HttpHandler.methodURL = methodURL;
    }
    /**
       Get State Root Hash RPC call
       - Parameter : GetStateRootHashParam, which contains a BlockIdentifier
       - Returns: none. The actually process of getting State Root Hash is done in HttpHandler class
       */

    public func getStateRootHash(getStateRootHashParam:GetStateRootHashParam) throws {
        let data = JsonConversion.fromBlockIdentifierToJsonData(input: getStateRootHashParam.block_identifier, method: .chainGetStateRootHash)
        do {
            try httpHandler.handleRequest(method: methodCall, params: data)
        } catch {
            throw error
        }
    }
    /**
     info_get_peers RPC call
       - Parameter : none
       - Returns: none. The actually process of getting peer list is done in HttpHandler class
       */
    
    public func getPeers() throws {
        methodCall = .infoGetPeer
        httpHandler.methodCall = .infoGetPeer
        do {
            try httpHandler.handleRequest(method: methodCall, params:JsonConversion.generatePostDataNoParam(method: .infoGetPeer))
        } catch {
            throw error
        }
    }
    /**
     info_get_deploy RPC call
       - Parameter : GetDeployParams
       - Returns: none. The actually process of getting GetDeployResult is done in HttpHandler class
       */
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
    /**
     info_get_status RPC call
       - Parameter : none
       - Returns: none. The actually process of getting GetStatusResult is done in HttpHandler class
       */
    public func getStatus() throws {
        methodCall = .infoGetStatus
        httpHandler.methodCall = .infoGetStatus
        do {
            try httpHandler.handleRequest(method: methodCall, params:JsonConversion.generatePostDataNoParam(method: .infoGetStatus))
        } catch {
            throw error
        }
    }
    /**
     state_get_dictionary_item RPC call
       - Parameter : GetDictionaryItemParams
       - Returns: none. The actually process of getting GetDictionaryItemResult is done in HttpHandler class
       */
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
    /**
     chain_get_era_info_by_switch_block RPC call
       - Parameter : BlockIdentifier
       - Returns: none. The actually process of getting GetEraInfoResult is done in HttpHandler class
       */
    
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
    
    /**
     state_get_item RPC call
       - Parameter : GetItemParams
       - Returns: none. The actually process of getting GetItemResult is done in HttpHandler class
       */
    
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
    /**
     chain_get_block_transfers RPC call
       - Parameter : BlockIdentifier
       - Returns: none. The actually process of getting GetBlockTransfersResult is done in HttpHandler class
       */
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
    /**
     chain_get_block RPC call
       - Parameter : BlockIdentifier
       - Returns: none. The actually process of getting GetBlockResult is done in HttpHandler class
       */
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
    /**
     state_get_balance RPC call
       - Parameter : GetBalanceParams
       - Returns: none. The actually process of getting GetBalanceResult is done in HttpHandler class
       */
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
    /**
     state_get_auction_info RPC call
       - Parameter : BlockIdentifier
       - Returns: none. The actually process of getting GetAuctionInfoResult is done in HttpHandler class
       */
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
    /**
     account_put_deploy RPC call
       - Parameter : a Deploy object
       - Returns: none. The actually process of getting GetDictionaryItemResult is done in HttpHandler class
       - Throws: CasperMethodCallError.CasperError with code and message according to the error returned by the Casper system
       */
    public func putDeploy(input:Deploy) throws {
        methodCall = .putDeploy
        httpHandler.methodCall = .putDeploy
        do  {
            let data = input.toJsonData();
            try httpHandler.putDeploy(method: methodCall, params: data, httpMethod: "POST",deployHash:input.hash)
        } catch {
            NSLog("Error:\(error)")
            throw error
        }
    }
}
