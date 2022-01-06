
import Foundation

enum CasperMethodError:Error {
    case invalidURL
    case parseError
    case methodNotFound
    case unknown
    case getDataBackError
}
enum CasperMethodCall:String {
    case chainGetStateRootHash          = "chain_get_state_root_hash"
    case infoGetPeer                    = "info_get_peers"
    case infoGetDeploy                  = "info_get_deploy"
    case infoGetStatus                  = "info_get_status"
    case chainGetBlockTransfer          = "chain_get_block_transfer"
    case chainGetEraInfoBySwitchBlock   = "chain_get_era_info_by_switch_block"
    case stateGetItem                   = "state_get_item"
    case stateGetDictionaryItem         = "state_get_dictionary_item"
    case stateGetBalance                = "state_get_balance"
    case stateGetAuctionInfo            = "state_get_auction_info"
}

public class CasperSDK {
    let CASPER_ID : Int32 = 1;
    var methodURL:String = "http://65.21.227.180:7777/rpc";
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
    public func getPeers() throws {
        methodCall = .infoGetPeer
        httpHandler.methodCall = .infoGetPeer
        do {
            try httpHandler.handleRequest(method: methodCall, params: "[]")
        } catch {
            throw error
        }
    }
    public func getStateRootHash(getStateRootHashParam:GetStateRootHashParam) throws {
       methodCall = .chainGetStateRootHash
        if let blockHash = getStateRootHashParam.blockHash {
            let jsonParams : [[String:Any]] = [["Hash":blockHash]] as [[String:Any]];
            do {
                try httpHandler.handleRequest(method: methodCall, params: jsonParams)
            } catch {
                throw error
            }
        }
        if let blockHeight = getStateRootHashParam.blockHeight {
            do {
                let jsonParams : [[String:Any]] = [["Height":blockHeight]] as [[String:Any]];
                try httpHandler.handleRequest(method: methodCall, params: jsonParams)
            } catch {
                throw error
            }
        }
        else {
            do {
                let jsonParams :String = "[]"
                try httpHandler.handleRequest(method: methodCall, params: jsonParams)
            } catch {
                throw error
            }
        }
        //TEST FOR GET PEER
        httpHandler.methodCall = .infoGetPeer
        do {
            let jsonParams :String = "[]"
            try httpHandler.handleRequest(method: methodCall, params: jsonParams)
        } catch {
            throw error
        }
    }
   /*
    public func getPeers() throws -> GetPeersResult {
        let getPeers:GetPeers = GetPeers();
        do {
            let getPeersResult = getPeers.getPeers()
            return getPeersResult;
        } catch {
            //print("Error")
            throw error;
        }
    }*/
    
}
