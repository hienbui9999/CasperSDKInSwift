import Foundation

public class DeployInfo {
    public var deploy_hash:String=""
    public var transfers: [String]=[String]()
    public var from:String=""
    public var source: URef=URef()
    public var gas:U512Class=U512Class()
    
    public static func fromJsonToDeployInfo(from:[String:Any]) -> DeployInfo {
        var oneDeployInfo : DeployInfo = DeployInfo();
        if let deployHash:String = from["deploy_hash"] as? String {
            oneDeployInfo.deploy_hash = deployHash
        }
        if let deployFrom : String = from["from"] as? String {
            oneDeployInfo.from = deployFrom
        }
        if let gas = from["gas"] as? String {
            oneDeployInfo.gas = U512Class.fromStringToU512(from: gas);
        }
        if let source:String = from["source"] as? String {
            oneDeployInfo.source = URef.fromStringToUref(from: source)
        }
        if let transfers = from["transfers"] as? [String] {
            //oneDeployInfo.transfers = [String]();
            for transfer in transfers {
                oneDeployInfo.transfers.append(transfer)
            }
        }
        return oneDeployInfo
    }
    
}
