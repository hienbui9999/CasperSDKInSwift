
import Foundation
class GetBlockTransfers:RpcWithOptionalParams {
    let methodStr : String = "chain_get_block_transfers"
    let methodURL : String = "http://65.21.227.180:7777/rpc"
    func handle_request () {
        let parameters = ["id": 1, "method": methodStr,"params":"[]","jsonrpc":"2.0"] as [String : Any]
            let url = URL(string: methodURL)!
            let session = URLSession.shared
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            } catch let error {
                print(error.localizedDescription)
            }
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            request.addValue("application/json", forHTTPHeaderField: "Accept")
            let task = session.dataTask(with: request as URLRequest, completionHandler: {
                data, response, error in
                    guard error == nil else {
                    return
                }
                guard let data = data else {
                    return
                }
                do {
                   
                    if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                       
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            })
            task.resume()
    }
}
