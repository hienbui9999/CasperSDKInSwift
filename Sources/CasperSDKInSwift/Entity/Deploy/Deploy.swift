import Foundation
/**
 Class for Deploy object
 */
public class Deploy {
    ///Deploy hash
    public var hash:String = "";
    ///List of DeployApprovalItem
    public var approvals:[DeployApprovalItem] = [DeployApprovalItem]();
    ///Deploy Header
    public var header:DeployHeader = DeployHeader();
    ///Deploy Payment, which is object of class ExecutableDeployItem
    public var payment:ExecutableDeployItem?;
    ///Deploy Session, which is object of class ExecutableDeployItem
    public var session:ExecutableDeployItem?;
    /**
        Function to get  json data from Deploy object
       - Parameter : none
       - Returns: json data representing the current deploy object, in form of [String:Any], used to send to http method to implement the account_put_deploy RPC call
     */
    public func toJsonData()->Data {
        let headerJson:[String:Any] = ["account":header.account,"timestamp":header.timestamp,"ttl":header.ttl,"gas_price":header.gas_price,"body_hash":header.body_hash,"dependencies":[],"chain_name":header.chain_name]
        //for session
        let paymentJson = ExecutableDeployItemHelper.toJson(input:payment!)//["ModuleBytes":jsonPayment];
        let sessionJson = ExecutableDeployItemHelper.toJson(input:session!)// ["Transfer":argsJsonSession]
        let approvalJson:[String:Any] = ["signer":approvals[0].signer,"signature":approvals[0].signature]//approvals[0].signature]
        let approvalJsons:[AnyObject] = [approvalJson as AnyObject]
        let params:[String:Any] = ["hash":hash,"header":headerJson,"payment":paymentJson,"session":sessionJson,"approvals":approvalJsons];
        let paramReal:[AnyObject] = [params as AnyObject]
        let obj:[String:Any] = ["jsonrpc":CASPER_RPC_VERSION,"id":CASPER_ID,"method":"account_put_deploy","params":paramReal]
        let encode = JSONEncoder()
        encode.outputFormatting = .prettyPrinted
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
           // let jsonString = String(data: jsonData, encoding: String.Encoding.ascii)!
           //print(jsonString);
            return jsonData
        }
        catch {
            NSLog("Error:\(error)")
        }
        return Data()
    }
}
public class DeployUtil {
    //return the deploy_hash
    public static func getDeployResult(from:[String:Any]) throws -> String{
        if let error = from["error"] as AnyObject? {
            var code:Int!
            var message:String!
            if let code1 = error["code"] as? Int {
                code = code1
            }
            if let message1 = error["message"] as? String {
                message = message1
            }
            throw CasperMethodCallError.CasperError(code: code, message: message,methodCall: "account_put_deploy")
        }
        if let result = from["result"] as? [String:Any] {
            if let deploy_hash = result["deploy_hash"] as? String {
               return deploy_hash
            }
        }
        return "NONE"
    }
}
public class NamedArgJson :Codable {
    public var cl_type:String;
    public var bytes:String;
    public var parsed:String;
}
/**
 Class for DeployApprovalItem object
 */
public class DeployApprovalItem {
    ///signature  of the Approval
    public var signature:String = "";
    ///singer  of the Approval
    public var signer:String = "";
}


