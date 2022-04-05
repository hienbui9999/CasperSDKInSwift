import Foundation
/**
 Class represents the GetBlockTransfers
 */
public class GetBlockTransfers {
    /**
     Get GetBlockTransfersResult from Json string
     - Parameter: a Json String represents the GetBlockTransfersResult object
     - Throws: CasperMethodCallError.CasperError with code and message according to the error returned by the Casper system
     - Returns: GetBlockTransfersResult object
     */

    public static func getResult(from: [String: Any]) throws -> GetBlockTransfersResult {
        do {
            if let error = from["error"] as AnyObject? {
                var code: Int!
                var message: String!
                if let code1 = error["code"] as? Int {
                    code = code1
                }
                if let message1 = error["message"] as? String {
                    message = message1
                }
                throw CasperMethodCallError.casperError(code: code, message: message, methodCall: "chain_get_block_transfers")
            }
            let ret: GetBlockTransfersResult = GetBlockTransfersResult()
            if let result = from["result"] as? [String: Any] {
                if let apiVersion1 = result["api_version"] as? String {
                    ret.apiVersion = ProtocolVersion.strToProtocol(from: apiVersion1)
                }
                if let blockHash1 = result["block_hash"] as? String {
                    ret.blockHash = blockHash1
                }
                if let transfers = result["transfers"] as? [[String: Any]] {
                    ret.transfers = [Transfer]()
                    for transfer in transfers {
                        let oneTransfer = Transfer.fromJsonToTransfer(from: transfer)
                        ret.transfers!.append(oneTransfer)
                    }
                }
            }
            return ret
        } catch {
            throw error
        }
    }

}
