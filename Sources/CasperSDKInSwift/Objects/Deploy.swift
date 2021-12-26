//
//  File.swift
//  
//
//  Created by Hien on 25/12/2021.
//

import Foundation
class DeployHeader {
    public var account:String = "";//account_hash "016D9E3DB0A800aEF8D18975B469C77bEF042ee909D24CB83D27dF97a22bB6D8Ad"
    public var timeStamp: Date = Date();//"2021-06-25T00:29:01.261Z"
    public var ttl:Int32 = 30;//time to live, in minutes
    public var gas_price:UInt64 = 1;
    public var body_hash:String = "";//body_hash, "Dd10BBd650a271114143Eb4733601eeb4e4BBDd2D3C631022eD617E186E93C39"
    public var dependencies:[String] = [String]();
    public var chain_name : String = "casper-test";
    //let epochTime = TimeInterval(1429162809359) / 1000
    //let date = Date(timeIntervalSince1970: epochTime)
}
class ExecutableDeployItem {
    
}
class Deploy
{
    public var hash:String = "";//"8DD3c3C66F6d9544Bd0E39cFF77470682fE42dbDDF85f08521fbfa563eEb7321"
    public var header:DeployHeader=DeployHeader();
    public var payment:ExecutableDeployItem = ExecutableDeployItem();
    public var session:ExecutableDeployItem = ExecutableDeployItem();
}
