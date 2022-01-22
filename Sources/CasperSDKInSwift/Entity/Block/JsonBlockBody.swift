import Foundation

public class JsonBlockBody {
    public var deployHash:[DeployHash] = [DeployHash]();
    public var proposer:PublicKey = PublicKey();
    public var transferHash:[DeployHash] = [DeployHash]();
    public static func getBlockBody(from:[String:Any]) -> JsonBlockBody {
        let getBlockBody:JsonBlockBody = JsonBlockBody();
        //getting deploy hash list
        if let deployHashes = from["deploy_hashes"] as? [String]{
            for deployHash in deployHashes {
                getBlockBody.deployHash.append(DeployHash.fromStrToHash(from: deployHash))
            }
        }
        //getting transfer hash list
        if let transferHashes = from["transfer_hashes"] as? [String]{
            for transferHash in transferHashes {
                getBlockBody.transferHash.append(DeployHash.fromStrToHash(from: transferHash))
            }
        }
        //getting proposer
        if let proposer = from["proposer"] as? String {
            getBlockBody.proposer = PublicKey.strToPublicKey(from: proposer);
        }
        return getBlockBody;
    }
}
