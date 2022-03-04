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
        
        let clValueJSon:[String:Any] = ["cl_type":"U512","bytes":"0400ca9a3b","parsed":"1000000000"]
        let argJson:[AnyObject] = ["amount" as AnyObject,clValueJSon as AnyObject];
        let argsJson:[AnyObject] = [argJson as AnyObject];

       // let moduleBytesJsonPayment:[String:Any] = ["module_bytes":"","args":argsJson];
        let moduleBytesJsonPayment:[String:Any] = ExecutableDeployItemHelper.toJson(input:payment!)
        //for session
        //arg1
        let clValueJson1:[String:Any] =  ["cl_type":"U512","bytes":"04005ed0b2","parsed":"3000000000"];
        let argJson1:[AnyObject] = ["amount" as AnyObject,clValueJson1 as AnyObject];
        
        //arg2
        let clValueJson2:[String:Any] =  ["cl_type":"PublicKey","bytes":"02021172744b5e6bdc83a591b75765712e068e5d40a3be8ae360274fb26503b4ad38","parsed":"02021172744b5e6bdc83a591b75765712e068e5d40a3be8ae360274fb26503b4ad38"];
        let argJson2:[AnyObject] = ["target" as AnyObject,clValueJson2 as AnyObject];
        
        //arg3
        let optionJson:[String:String] = ["Option":"U64"]
        let clValueJson3:[String:Any] =  ["cl_type":optionJson,"bytes":"010000000000000000","parsed":0];
        let argJson3:[AnyObject] = ["id" as AnyObject,clValueJson3 as AnyObject];
        
       // let argsJsonSession:[AnyObject] = [argJson1 as AnyObject,argJson2 as AnyObject,argJson3 as AnyObject];
        let argsJsonSession:[String:Any] = ExecutableDeployItemHelper.toJson(input:session!)
       // print("session:\(argsJsonSession)")
       // let sessionJsonAll:[String:Any] = ["args":argsJsonSession];
        let paymentJson = ["ModuleBytes":moduleBytesJsonPayment];
        let sessionJson = ["Transfer":argsJsonSession]
        let approvalJson:[String:Any] = ["signer":approvals[0].signer,"signature":approvals[0].signature]//approvals[0].signature]
        let approvalJsons:[AnyObject] = [approvalJson as AnyObject]
        let params:[String:Any] = ["hash":hash,"header":headerJson,"payment":paymentJson,"session":sessionJson,"approvals":approvalJsons];
        let paramReal:[AnyObject] = [params as AnyObject]
        let obj:[String:Any] = ["jsonrpc":CASPER_RPC_VERSION,"id":CASPER_ID,"method":"account_put_deploy","params":paramReal]
        let encode = JSONEncoder()
        encode.outputFormatting = .prettyPrinted
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
            let jsonString = String(data: jsonData, encoding: String.Encoding.ascii)!
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
                print("Error message:\(message)")
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


