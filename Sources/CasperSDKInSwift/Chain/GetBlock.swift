import Foundation
/**
 Class for GetBlock from Json String
 */
class GetBlock {
    /**
     Get block from Json string
     - Parameter : a Json String represents the Block object
     - Throws: CasperMethodCallError.CasperError with code and message according to the error returned by the Casper system
     - Returns: GetBlockResult object
     */
    public static func getBlock(from:[String:Any]) throws -> GetBlockResult {
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
                throw CasperMethodCallError.CasperError(code: code, message: message,methodCall: "chain_get_block")
            }
        }
        do {
            let getBlockResult : GetBlockResult = GetBlockResult();
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
                return getBlockResult;
            }
            else {
                throw CasperMethodError.parseError
           }
        } catch {
            throw CasperMethodError.parseError
        }
        
    }
}
