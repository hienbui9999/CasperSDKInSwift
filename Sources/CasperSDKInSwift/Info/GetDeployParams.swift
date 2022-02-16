import Foundation
/**
 Class supports the getting of GetDeployParams from Json String - build the param for POST method sending to RPC method
 */

public class GetDeployParams {
    public var deploy_hash:String!
    /**
        Get param as Data  from deploy_hash atrribute
        - Parameter : none
        - Returns: Data  to  build the param for POST method sending to RPC method
        */

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
            NSLog("Error:\(error)")
        }
        return Data()
    }
}
