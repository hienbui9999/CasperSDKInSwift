import Foundation

public class GetDeployParams {
    public var deploy_hash:String!
    public func toJsonData()->Data {
        let params:[String] = [deploy_hash]
        let obj:[String:Any] = ["jsonrpc":CASPER_RPC_VERSION,"id":CASPER_ID,"method":"info_get_deploy","params":params]
        let encode = JSONEncoder()
        encode.outputFormatting = .prettyPrinted
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
            return jsonData
        }
        catch {
            print("Error:\(error)")
        }
        return Data()
    }
}
