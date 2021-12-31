//
//  File.swift
//  
//
//  Created by Hien on 25/12/2021.
//

import Foundation
public class Deploy { //5 items
    public var hash:String = "";
    public var approvals:[DeployApprovalItem] = [DeployApprovalItem]();
    public var header:DeployHeader = DeployHeader();
    public var payment:DeployPayment = DeployPayment();
    public var session:DeploySession = DeploySession();
}
public class DeployApprovalItem {
    public var signature:String = "";//130 chars
    public var signer:String = "";//01d9bf2148748a85c89da5aad8ee0b0fc2d105fd39d41a4c796536354f0ae2900c
}


