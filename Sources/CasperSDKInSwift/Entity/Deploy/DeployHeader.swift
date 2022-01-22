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
        if let account = from["account"] as? String {//1
            print("deploy header account:\(account)")
            retDeploy.account = account;
        }
        if let bodyHash = from["body_hash"] as? String {//2
            print("deploy header body_hash:\(bodyHash)")
           retDeploy.body_hash = bodyHash;
        }
        if let chainName = from["chain_name"] as? String {//3
            print("deploy header chain_name:\(chainName)")
            retDeploy.chain_name = chainName;
        }
        if let gasPrice = from["gas_price"] as? UInt64 {//4
            print("deploy header gas_price:\(gasPrice)")
            retDeploy.gas_price = gasPrice;
        }
        if let timeStamp = from["timestamp"] as? String {//5
            print("deploy header timestamp:\(timeStamp)");
            retDeploy.timestamp = timeStamp;
        }
        if let ttl = from["ttl"] as? String {//6
            print("deploy header ttl:\(ttl)");
            retDeploy.ttl = ttl;
        }
        if let dependencies = from["dependencies"] as? [String] {
            for dependency in dependencies {
                print("deploy header dependency:\(dependency)")
                retDeploy.dependencies.append(dependency)
            }
        }
        return retDeploy
    }
}
