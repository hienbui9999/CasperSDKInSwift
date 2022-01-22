import Foundation

public class ProtocolVersion {
    var protocolString = "";
    var major:Int = 1;
    var minor:Int = 0;
    var patch:Int = 0;
    func serialize() {
        //str like 1.4.2
        let strArr = protocolString.components(separatedBy: ".");
        major = Int(strArr[0]) ?? 1;
        minor = Int(strArr[1]) ?? 0;
        patch = Int(strArr[2]) ?? 0;
    }
    public func getProtocolString()->String {
        return protocolString;
    }
    public func setProtolString(str:String) {
        protocolString = str;
    }
    public static func strToProtocol(from:String)->ProtocolVersion {
        let protocolVersion:ProtocolVersion = ProtocolVersion();
        protocolVersion.protocolString = from;
        return protocolVersion;
    }
}
