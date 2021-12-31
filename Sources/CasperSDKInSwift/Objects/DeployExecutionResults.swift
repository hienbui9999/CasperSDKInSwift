//
//  File.swift
//  
//
//  Created by Hien on 29/12/2021.
//

import Foundation

public class DeployModuleBytes {
    
}
public enum ExecutableDeployItemType {
    case ModuleBytes //bytes - very long string
    case StoredContractByHash
    case StoredContractByName
    case StoredVersionedContractByHash
    case StoredVersionedContractByName
    case Transfer
}
public class DeployArgs {
    public var clType:CLType = .BOOL;//PublicKey, u256,u512,
    public var parse:String="";//can be list, string, object - key, URef - is the value of clType
    public var bytes:String = "";
    //000B4AC8b9Aa02A5E3B7f6f95641152b3Fc5a05e88b6469fAa22107f824b7bE3bE - can be very long string -
    //the serialization of clType and parse (value of clType)
    //very long string
    public var argsDesc:String = "";//amount_out_min,path,amount_in,delegator,validators,validator_public_key
}
public class ExecutableDeployItem {
    
}
public class DeployExecutionResult {
    public var blockHash:String = "";//528c63a9e30bf6e52b9d38f7c1a3e2ec035a54bfb29225d31ecedff00eebbe18 - block_hash
    
}
public class DeployExecutionResults {
    public var executionResults:[DeployExecutionResult] = [DeployExecutionResult] ();
}
