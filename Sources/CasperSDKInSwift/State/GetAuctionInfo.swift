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

    public static func getAuctionInfo(from:[String:Any])throws ->GetAuctionInfoResult {
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
                throw CasperMethodCallError.CasperError(code: code, message: message,methodCall: "state_get_auction_info")
            }
        }
        let ret:GetAuctionInfoResult = GetAuctionInfoResult();
        if let result = from["result"] as? [String:Any] {
            if let api_version = result["api_version"]  as? String {
                ret.api_version = ProtocolVersion.strToProtocol(from: api_version)
            }
            if let auctionStateJson = result["auction_state"] as? [String:Any] {
                let rAuctionState : AuctionState = AuctionState ();
                if let state_root_hash = auctionStateJson["state_root_hash"] as? String {
                    rAuctionState.state_root_hash = state_root_hash
                }
                if let block_height = auctionStateJson["block_height"] as? UInt64 {
                    rAuctionState.block_height = block_height
                }
                if let bids = auctionStateJson["bids"] as? [[String:Any]] {
                    for bid in bids {
                        let oneJsonBids : JsonBids = JsonBids.toJsonBids(from: bid)
                        rAuctionState.bids.append(oneJsonBids)
                    }
                }
                if let era_validators = auctionStateJson["era_validators"] as? [[String:Any]] {
                    for era_validator in era_validators {
                        let oneEra = JsonEraValidators.fromJsonToEraValidator(from: era_validator)
                        rAuctionState.era_validators.append(oneEra)
                    }
                }
                ret.auction_state = rAuctionState
            }
        }
       
        return ret;
    }
   
}
