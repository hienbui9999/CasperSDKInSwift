
import Foundation

//let CASPER_ID : Int32 = 1;
//let methodURL:String = "http://65.21.227.180:7777/rpc";


enum CasperMethodError:Error {
    case invalidURL
    case parseError
    case methodNotFound
    case unknown
    case getDataBackError
}

public class CasperSDK {
    //public private(set) var text = "Hello, World!"
    
    let CASPER_ID : Int32 = 1;
    var methodURL:String = "http://65.21.227.180";
    var port:UInt32 = 7777;
    public func setMethodUrl(url:String) {
        methodURL = url;
        HttpHandler.methodURL = methodURL;
    }
    public func setMethodUrl(url:String,port:UInt32 = 7777) {
        self.methodURL = url + ":" + String(port) + "/rpc";
        HttpHandler.methodURL = methodURL;
    }
    
    public init(url:String="http://65.21.227.180",port:UInt32=7777) {
        self.methodURL = url + ":" + String(port) + "/rpc";
        self.port = port
        HttpHandler.methodURL = methodURL;
    }
   
    @available(iOS 15.0.0, *)
    public func getStateRootHash(blockHash:String = "",height:UInt64 = 0) async throws->String {
        //var params = "[]"
        if blockHash != "" {
            do {
                let jsonParams : [[String:Any]] = [["Hash":blockHash]] as [[String:Any]];
//                let jsonParams : [[String:Any]] = [["Height":height]] as [[String:Any]];
                let stateRootHash = try await GetStateRootHash.getStateRootHash(params: jsonParams);
                return stateRootHash;
            } catch {
               // print("In CasperSDK, Error get state root hash:\(error)")
                throw error
            }
        } else if height != 0 {
            do {
                let jsonParams : [[String:Any]] = [["Height":height]] as [[String:Any]];
                let stateRootHash = try await GetStateRootHash.getStateRootHash(params: jsonParams);
                return stateRootHash;
            } catch {
               // print("In CasperSDK, Error get state root hash:\(error)")
                throw error
            }
        } else {
            do {
                let jsonParams : String = "[]"
                let stateRootHash = try await GetStateRootHash.getStateRootHash(params: jsonParams);
                return stateRootHash;
            } catch {
               // print("In CasperSDK, Error get state root hash:\(error)")
                throw error
            }
        }
        
      //  throw CasperMethodError.unknown;
    }
   
    @available(iOS 15.0.0, *)
    public func getPeers() async throws -> GetPeersResult {
        let getPeers:GetPeers = GetPeers();
        do {
            let getPeersResult = try  await  getPeers.getPeers()
            return getPeersResult;
        } catch {
            //print("Error")
            throw error;
        }
    }
    public func getDeploy(deployHash:String) async throws -> GetDeployResult {
        let getDeploy:GetDeploy = GetDeploy();
        do {
            let getDeployResult = try await getDeploy.getDeploy(deployHash:deployHash)
            return getDeployResult;
        } catch {
            print("Error get Deploy: \(error)")
            throw error
        }
    }
    public func getStatus() async throws -> GetStatusResult {
        let getStatus : GetStatus = GetStatus();
        do {
            let getStatusResult : GetStatusResult = try await getStatus.getStatus();
            return getStatusResult;
        } catch {
            print("Error get Status:\(error)")
            throw error
        }
    }
    public func getBlock(blockHash:String="") async throws -> GetBlockResult {
        print("blockHash:\(blockHash)")
        let getBlock : GetBlock = GetBlock();
        if blockHash != "" {
            do {
                let jsonParams : [[String:Any]] = [["Hash":blockHash]] as [[String:Any]];
//                let jsonParams : [[String:Any]] = [["Height":height]] as [[String:Any]];
                let getBlockResult : GetBlockResult = try await getBlock.getBlock(params: jsonParams);
                return getBlockResult;
            } catch {
                print("In CasperSDK, Error get state root hash:\(error)")
                throw error
            }
        } else {
            do {
                let getBlockResult : GetBlockResult = try await getBlock.getBlock(params: "[]");
                return getBlockResult;
            } catch {
                print("Error get Status:\(error)")
                throw error
            }
        }
    }
}
