import Foundation

public class DeployHeader {
    public var account:String = "";
    public var bodyHash:String = "";
    public var chainName:String = "";
    public var gasPrice:UInt64 = 0;
    public var timeStamp:String = "";
    public var ttl:String = "";
    public var dependencies:[String] = [String]();
}
