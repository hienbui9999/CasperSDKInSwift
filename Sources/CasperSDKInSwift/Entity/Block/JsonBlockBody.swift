import Foundation
/**
 Class represents the JsonBlockBody
 */
public class JsonBlockBody {
    ///List of DeployHash object
    public var deployHash:[DeployHash] = [DeployHash]();
    ///Proposer attribute, as PublicKey
    public var proposer:PublicKey = PublicKey();
    ///TransferHash - which is a list of DeployHash objects
    public var transferHash:[DeployHash] = [DeployHash]();
    /**
     Get JsonBlockBody object from Json string
     - Parameter : a Json String represents the JsonBlockBody object
     - Returns: JsonBlockBody object
     */
    public static func getBlockBody(from:[String:Any]) -> JsonBlockBody {
        let getBlockBody:JsonBlockBody = JsonBlockBody();
        ///getting deploy hash list
        if let deployHashes = from["deploy_hashes"] as? [String]{
            for deployHash in deployHashes {
                getBlockBody.deployHash.append(DeployHash.fromStrToHash(from: deployHash))
            }
        }
        ///getting transfer hash list
        if let transferHashes = from["transfer_hashes"] as? [String]{
            for transferHash in transferHashes {
                getBlockBody.transferHash.append(DeployHash.fromStrToHash(from: transferHash))
            }
        }
        ///getting proposer
        if let proposer = from["proposer"] as? String {
            getBlockBody.proposer = PublicKey.strToPublicKey(from: proposer);
        }
        return getBlockBody;
    }
}
