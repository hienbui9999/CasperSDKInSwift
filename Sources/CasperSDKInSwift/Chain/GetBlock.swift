import Foundation

class GetBlock {
    
    public static func getBlock(from:[String:Any]) throws -> GetBlockResult {
        let getBlockResult : GetBlockResult = GetBlockResult();
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
                throw CasperMethodCallError.CasperError(code: code, message: message)
            }
            
            if let result = from["result"] as? [String:Any] {
                if let apiVersion = result["api_version"] as? String {
                    getBlockResult.apiVersion = apiVersion
                } else {
                   
                }
                if let block = result["block"] as? [String:Any] {
                    let getBlock:JsonBlock = JsonBlock();
                    getBlockResult.block = getBlock;
                    if let hash = block["hash"] as? String {
                        getBlock.hash = hash;
                    }
                    //getting block header
                    if let blockHeaderJson = block["header"] as? [String:Any] {
                        getBlock.header = JsonBlockHeader.getBlockHeader(from: blockHeaderJson);
                    }
                    //getting block body
                    if let blockBodyJson = block["body"] as? [String:Any] {
                        getBlock.body = JsonBlockBody.getBlockBody(from: blockBodyJson)
                    }
                    //getting proof
                    if let proofs = block["proofs"] as? [AnyObject] {
                        getBlock.proofs = JsonProof.getJsonProofs(jsonProofs: proofs)
                    }
                }
            }
            else {
                throw CasperMethodError.parseError
           }
        } catch {
        }
        return getBlockResult;
    }
}
