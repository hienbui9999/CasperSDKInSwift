
import Foundation

let CASPER_ID : Int32 = 1;
let methodURL:String = "http://65.21.227.180:7777/rpc";

enum GetStateRootHashError: Error {
    case invalidURL
    case parseError
    case methodNotFound
}
enum CasperMethodError:Error {
    case invalidURL
    case parseError
    case methodNotFound
}

public class CasperSDKInSwift {
    //public private(set) var text = "Hello, World!"

    public init() {
    }
    public func getStateRootHash() {
        let getState:GetStateRootHash = GetStateRootHash();
        getState.handle_request();
    }
    @available(iOS 15.0.0, *)
    public func getPeers() async throws -> GetPeersResult {
        let getPeers:GetPeers = GetPeers();
        do {
            let getPeersResult = try  await  getPeers.getPeers2()
            return getPeersResult;
        } catch {
            print("Error")
            throw CasperMethodError.invalidURL;
        }
    }
   
}
