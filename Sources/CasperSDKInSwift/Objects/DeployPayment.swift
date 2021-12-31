//
//  File.swift
//  
//
//  Created by Hien on 29/12/2021.
//

import Foundation
public class DeployPaymentStoredContractByName {//3 items
    public var paymentArgs:[DeployPaymentArgs] = [DeployPaymentArgs]();
    public var entryPoint:String = "";//example-entry-point
    public var name:String = "";//casper-example
}
public class DeployPaymentArgs { //2 items
    public var args:[DeployArgItem] = [DeployArgItem]();
    public var quantity:String = "";//
}
public class DeployPayment {//4 items
    public var paymentStoredContractByName: DeployPaymentStoredContractByName = DeployPaymentStoredContractByName();
}
