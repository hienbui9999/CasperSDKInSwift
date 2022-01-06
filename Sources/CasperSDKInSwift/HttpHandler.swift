import Foundation
import XCTest
class HttpHandler:XCTestCase {
    static var methodURL:String = "https://node-clarity-testnet.make.services/rpc";
    public var methodCall:CasperMethodCall = .chainGetStateRootHash;
    public func handleRequest(method:CasperMethodCall,params:Any) throws{
        guard let url = URL(string: HttpHandler.methodURL) else {
            throw CasperMethodError.invalidURL
        }
        let json: [String: Any] = ["id": CASPER_ID, "method": method.rawValue,"jsonrpc":"2.0","params":params] as [String:Any]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let expectation = self.expectation(description: "Getting json data from casper")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                if self.methodCall == .chainGetStateRootHash {
                    do {
                        let stateRootHash = try GetStateRootHash.getStateRootHash(from: responseJSON);
                        //This is for testing result back, comment this if you don't want to make test
                         XCTAssertEqual(stateRootHash.count,64,"Error data back, state_root_hash should be 64 length string")
                        NSLog("StateRootHash: %@\n", stateRootHash)
                    }
                    catch {
                    }
                } else if self.methodCall == .infoGetPeer {
                    do {
                        let getPeer:GetPeersResult = try GetPeers.getPeers(from: responseJSON)
                        //This is for testing result back, comment this if you don't want to make test
                        XCTAssert(!getPeer.getPeerMap().getPeerEntryList().isEmpty)
                        let firstPeer = getPeer.getPeerMap().getPeerEntryList().first
                        XCTAssert(!firstPeer!.getAddress().isEmpty)
                        XCTAssert(!firstPeer!.getNodeId().isEmpty)
                        NSLog("Total peers:\(getPeer.getPeerMap().getPeerEntryList().count)\n")
                        NSLog("First peerAddress:\(firstPeer!.getAddress())\n")
                        NSLog("First peerID:\(firstPeer!.getNodeId())\n")
                   } catch {
                   }
                }
            }
            expectation.fulfill()
        }
        task.resume()
        self.waitForExpectations(timeout: 15, handler: nil)
    }
}
