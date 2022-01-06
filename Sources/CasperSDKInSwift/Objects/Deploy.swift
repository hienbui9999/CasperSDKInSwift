import Foundation

public class Deploy {
    public var hash:String = "";
    public var approvals:[DeployApprovalItem] = [DeployApprovalItem]();
    public var header:DeployHeader = DeployHeader();
    public var payment:ExecutableDeployItem?;
    public var session:ExecutableDeployItem?;
    public func printMe () {
        switch payment {
        case .ModuleBytes(let moduleBytes, let runtimeArgs) :
            break;
        case .StoredContractByHash(let hash, let entryPoint , let runtimeArgs):
            break;
        default:
            break;
        }
        switch session {
        case .ModuleBytes(let moduleBytes, let runtimeArgs) :
            break;
        case .StoredContractByHash(let hash, let entryPoint , let runtimeArgs):
            break;
        case .Transfer(let runtimeArgs) :
            break;
        default:
            break;
        }
    }
}
public class DeployApprovalItem {
    public var signature:String = "";
    public var signer:String = "";
}


