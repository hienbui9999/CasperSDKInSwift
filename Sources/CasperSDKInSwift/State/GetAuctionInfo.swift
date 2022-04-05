import Foundation
/**
 Class supports the getting of GetAuctionInfoResult from Json String
 */

public class GetAuctionInfo {
    /**
       Get GetAuctionInfoResult object from Json string
       - Parameter : a Json String represents the GetAuctionInfoResult object
       - Throws: CasperMethodCallError.CasperError with code and message according to the error returned by the Casper system
       - Returns: GetAuctionInfoResult object
       */

    public static func getAuctionInfo(from: [String: Any])throws -> GetAuctionInfoResult {
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
                throw CasperMethodCallError.casperError(code: code, message: message, methodCall: "state_get_auction_info")
            }
        }
        let ret: GetAuctionInfoResult = GetAuctionInfoResult()
        if let result = from["result"] as? [String: Any] {
            if let apiVersion1 = result["api_version"]  as? String {
                ret.apiVersion = ProtocolVersion.strToProtocol(from: apiVersion1)
            }
            if let auctionStateJson = result["auction_state"] as? [String: Any] {
                let rAuctionState: AuctionState = AuctionState ()
                if let stateRootHash1 = auctionStateJson["state_root_hash"] as? String {
                    rAuctionState.stateRootHash = stateRootHash1
                }
                if let blockHeight1 = auctionStateJson["block_height"] as? UInt64 {
                    rAuctionState.blockHeight = blockHeight1
                }
                if let bids = auctionStateJson["bids"] as? [[String: Any]] {
                    for bid in bids {
                        let oneJsonBids: JsonBids = JsonBids.toJsonBids(from: bid)
                        rAuctionState.bids.append(oneJsonBids)
                    }
                }
                if let eraValidators1 = auctionStateJson["era_validators"] as? [[String: Any]] {
                    for eraValidator1 in eraValidators1 {
                        let oneEra = JsonEraValidators.fromJsonToEraValidator(from: eraValidator1)
                        rAuctionState.eraValidators.append(oneEra)
                    }
                }
                ret.auctionState = rAuctionState
            }
        }
        return ret
    }

}
