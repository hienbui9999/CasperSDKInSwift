
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
let CASPER_ID : Int32 = 1;
public class CasperSDK {
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
    //call for method info_get_peers
    public func getPeers() throws {
        methodCall = .infoGetPeer
        httpHandler.methodCall = .infoGetPeer
        do {
            try httpHandler.handleRequest(method: methodCall, params: "[]")
        } catch {
            throw error
        }
    }
    //call for method info_get_state_root_hash
    public func getStateRootHash(getStateRootHashParam:GetStateRootHashParam) throws {
        methodCall = .chainGetStateRootHash
        let defaultParams:String = "[]"
        var jsonParams:[[String:Any]]?
        //check if the params is the block_hash
        if let blockHash = getStateRootHashParam.blockHash {
            if blockHash != "" {
                jsonParams = [["Hash":blockHash]] as [[String:Any]];
            }
        }
        //check if the param is the block_height
        if let blockHeight = getStateRootHashParam.blockHeight {
            if blockHeight != 0 {
                jsonParams = [["Height":blockHeight]] as [[String:Any]];
            }
        }
        //if get state root hash with params such as block_hash or height
        if let jp = jsonParams{
            do {
                try httpHandler.handleRequest(method: methodCall, params: jp)
            } catch {
                throw error
            }
        } else { // if get state root hash without any params, then use the default param with value []
            do {
                try httpHandler.handleRequest(method: methodCall, params: defaultParams)
            } catch {
                throw error
            }
        }
    }
}
