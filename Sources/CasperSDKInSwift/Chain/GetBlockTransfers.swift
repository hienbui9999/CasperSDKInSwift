import Foundation

public class GetBlockTransfers {
    public static func getResult(from:[String:Any]) throws -> GetBlockTransfersResult {
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
                throw CasperMethodCallError.CasperError(code: code, message: message,methodCall: "chain_get_block_transfers")
            }
            let ret : GetBlockTransfersResult = GetBlockTransfersResult();
            if let result = from["result"] as? [String:Any] {
                if let api_version = result["api_version"] as? String {
                    ret.api_version = ProtocolVersion.strToProtocol(from: api_version)
                }
                if let block_hash = result["block_hash"] as? String {
                    ret.block_hash = block_hash
                }
                if let transfers = result["transfers"] as? [[String:Any]] {
                    ret.transfers = [Transfer]();
                    for transfer in transfers {
                        let oneTransfer = Transfer.fromJsonToTransfer(from: transfer)
                        ret.transfers!.append(oneTransfer)
                    }
                }
            }
            return ret;
        } catch {
            throw error
        }
    }
}
