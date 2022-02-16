import Foundation
/**
 Class supports the getting of GetDeployResult from Json String
 */

class GetDeploy {
    /**
       Get GetDeployResult object from Json string
       - Parameter : a Json String represents the GetDeployResult object
       - Throws: CasperMethodCallError.CasperError with code and message according to the error returned by the Casper system
       - Returns: GetDeployResult object
       */

    public static func getDeploy(from:[String:Any]) throws -> GetDeployResult{
        let getDeploy:GetDeployResult = GetDeployResult();
        do {
            if let error = from["error"] as AnyObject? {
                var code:Int!
                var message:String!
                if let code1 = error["code"] as? Int {
                    code = code1
                }
                if let message1 = error["message"] as? String {
                    message = message1
                }
                throw CasperMethodCallError.CasperError(code: code, message: message,methodCall: "info_get_deploy")
            }
          
            if let resultJson = from["result"] as? [String:Any] {
                if let api_version = resultJson["api_version"] as? String {
                    getDeploy.api_version = ProtocolVersion.strToProtocol(from: api_version)
                }
                if let deployJson = resultJson["deploy"] as? [String:Any] {
                    if let approvals = deployJson["approvals"] as? [AnyObject] {
                        let totalApproval = approvals.count
                        for approval in approvals {
                            let oneApproval:DeployApprovalItem = DeployApprovalItem();
                            if let signature = approval["signature"] as? String {
                                if let signer = approval["signer"] as? String {
                                    oneApproval.signature = signature;
                                    oneApproval.signer = signer
                                }
                            }
                            getDeploy.deploy.approvals.append(oneApproval);
                        }
                    }
                   
                    if let hash = deployJson["hash"] as? String {
                        getDeploy.deploy.hash = hash;
                    }
                   
                    if let header = deployJson["header"] as? [String:Any] {//7 items
                        getDeploy.deploy.header =  DeployHeader.getDeployHeader(from: header)
                    }
                    if let paymentJson = deployJson["payment"] as? [String:Any] {
                        getDeploy.deploy.payment = ExecutableDeployItemHelper.getExecutableDeployItem(from: paymentJson);
                    }
                    if let sessionJson = deployJson["session"] as? [String:Any] {
                        getDeploy.deploy.session = ExecutableDeployItemHelper.getExecutableDeployItem(from: sessionJson);
                    }
                    let executionResult = JsonExecutionResult.getExecutionResult(from: resultJson);
                    getDeploy.execution_results = executionResult
                }
            }
        } catch {
            throw error;
        }
        return getDeploy;
    }
    
    
}
