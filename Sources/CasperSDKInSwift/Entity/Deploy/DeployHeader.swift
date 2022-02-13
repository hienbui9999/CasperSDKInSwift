import Foundation

public class DeployHeader {
    public var account:String = "";
    public var body_hash:String = "";
    public var chain_name:String = "";
    public var gas_price:UInt64 = 0;
    public var timestamp:String = "";
    public var ttl:String = "";
    public var dependencies:[String] = [String]();

    public static func getDeployHeader(from:[String:Any])->DeployHeader {
        let retDeploy:DeployHeader = DeployHeader();
        if let account = from["account"] as? String {
            retDeploy.account = account;
        }
        if let bodyHash = from["body_hash"] as? String {
           retDeploy.body_hash = bodyHash;
        }
        if let chainName = from["chain_name"] as? String {
            retDeploy.chain_name = chainName;
        }
        if let gasPrice = from["gas_price"] as? UInt64 {
            retDeploy.gas_price = gasPrice;
        }
        if let timeStamp = from["timestamp"] as? String {
            retDeploy.timestamp = timeStamp;
        }
        if let ttl = from["ttl"] as? String {
            retDeploy.ttl = ttl;
        }
        if let dependencies = from["dependencies"] as? [String] {
            for dependency in dependencies {
                retDeploy.dependencies.append(dependency)
            }
        }
        return retDeploy
    }
}
