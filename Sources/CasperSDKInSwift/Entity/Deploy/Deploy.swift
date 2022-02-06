import Foundation

public class Deploy {
    public var hash:String = "";
    public var approvals:[DeployApprovalItem] = [DeployApprovalItem]();
    public var header:DeployHeader = DeployHeader();
    public var payment:ExecutableDeployItem?;
    public var session:ExecutableDeployItem?;
}
/*public class DeployUtil {//account_put_deploy
    public static func fromDeployToJson(deploy:Deploy) -> Data {
        let jsonEncoder = JSONEncoder()
        let jsonData = try jsonEncoder.encode(deploy)
        return Data()
    }
}*/
public class DeployApprovalItem {
    public var signature:String = "";
    public var signer:String = "";
}


