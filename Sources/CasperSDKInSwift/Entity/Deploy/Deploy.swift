import Foundation
/**
 Class for Deploy object
 */
public class Deploy {
    ///Deploy hash
    public var hash:String = "";
    ///List of DeployApprovalItem
    public var approvals:[DeployApprovalItem] = [DeployApprovalItem]();
    ///Deploy Header
    public var header:DeployHeader = DeployHeader();
    ///Deploy Payment, which is object of class ExecutableDeployItem
    public var payment:ExecutableDeployItem?;
    ///Deploy Session, which is object of class ExecutableDeployItem
    public var session:ExecutableDeployItem?;
}
/**
 Class for DeployApprovalItem object
 */
public class DeployApprovalItem {
    ///signature  of the Approval
    public var signature:String = "";
    ///singer  of the Approval
    public var signer:String = "";
}


