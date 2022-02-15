import Foundation
/**
 Class for Deploy Header object
 */
public class DeployHeader {
    ///Deploy Header  account hash
    public var account:String = "";
    ///Deploy Header body hash
    public var body_hash:String = "";
    ///Deploy Header  chain name
    public var chain_name:String = "";
    ///Deploy Header gas price, in UInt64 format
    public var gas_price:UInt64 = 0;
    ///Deploy Header  timestamp
    public var timestamp:String = "";
    ///Deploy Header  time to live, in format of "1day", "2h", "30m" ...
    public var ttl:String = "";
    ///Deploy Header list of dependencies
    public var dependencies:[String] = [String]();
    /**
     Get deploy header from Json string
     - Parameter : a Json String represent the deploy header object
     - Returns: DeployHeader object
     */
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
