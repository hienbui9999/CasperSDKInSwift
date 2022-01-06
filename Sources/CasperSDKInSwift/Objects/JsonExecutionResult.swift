//
//  File.swift
//  
//
//  Created by Hien on 04/01/2022.
//

import Foundation
class JsonExecutionResult {
    public var blockHash:String?
    public var result:ExecutionResult?
}
public enum ExecutionResult {
//    case Failure(effect:ExecutionEffect,transfers:[TransferAddr], cost:U512,error_message:String)
    case Failure(ExecutionEffect,[TransferAddr], U512,String)
    case Success(ExecutionEffect,[TransferAddr],U512);
}
public enum OpKind {
    case Read
    case Write
    case Add
    case NoOp
}
public class ExecutionEffect {
    public var operations:[Operation]?
    public var transforms:TransformEntry?
}
public class Operation {
    public var  key:String?
    public var kind:OpKind?
}
public class TransformEntry {
    public var key:String?;
    public var transform:Transform?
}
public enum Transform {
    case Identity
    case WriteCLValue(CLValue)//DeployArgItem
    case WriteAccount(AccountHash) // String is AccountHash
    case WriteContractWasm
    case WriteContract
    case WriteContractPackage
    case WriteDeployInfo(DeployInfo) // Declare below
    case WriteEraInfo(EraInfo) // Not clear EraInfo
    case WriteTransfer(TransformTransfer) // Declare below
    case WriteBid(Bid) // not clear bid here
    case WriteWithdraw([UnbondingPurse])
    case AddInt32(Int32)
    case AddUInt64(UInt64)
    case AddUInt128(U128)
    case AddUInt256(U256)
    case AddUInt512(U512)
    case AddKeys([NamedKey])
    case Failure(String)
    case NONE
}
public class NamedKey {
    public var name:String?
    public var key:String?
}
public class UnbondingPurse {
    public var bondingPurse:URef?;//aString URef
    public  var validatorPublicKey:String?;//PublicKey type
    public var unbonderPublicKey:String?;//PublicKey type
    public var eraOfCreation: EraID?;//maybe a U64 type
    public var amount:U512?
}
public class EraID {
    public var maxValue:UInt64?
}
/*
 WriteDeployInfo =     {
     "deploy_hash" = 5FE66F884b71bCd23BE54ce0Aaae9a8ae3e63Baf5F9Bf633383337DcEBECC060;
     from = "account-hash-f929911F7494A360271b968ac00Fe2220773235e725366952De5d9a349e57c7B";
     gas = 2740651310;
     source = "uref-20906191670E7F3De270fd0800406a10ABA1746aE56beDF835ed876E60Ae5b2D-007";
     transfers =         (
         "transfer-A706e9b84BCb5AFeFb41D04481622469d1E590ee7CB9F2849e62BBDe76EEe312",
         "transfer-19BDAA5124EBA1b0e27B8c95932180Ab961063be77360fa26120b2ff1CdA3264"
     );
 };
 */
public class DeployInfo{
    public var deployHash:String? // String a Hash
    //public var transfers: [TransferAddr]?//List of TransferAddr, may be a pair of id and port???
    public var transfers: [String]?//List of TransferAddr, may be a pair of id and port???
   // public var from:AccountHash?//String a hash
    public var from:String?//String a hash
    //public var source: URef? // String a URef
    public var source: String? // String a URef
    //public var gas:U512? // String an U512
    public var gas:String? // String an U512
}
public class Bid {
    
}
/*
 "WriteTransfer":{8 items
 "id":NULL
 "to":NULL
 "gas":"0"
 "from":"account-hash-f929911F7494A360271b968ac00Fe2220773235e725366952De5d9a349e57c7B"
 "amount":"57028133000"
 "source":"uref-20906191670E7F3De270fd0800406a10ABA1746aE56beDF835ed876E60Ae5b2D-007"
 "target":"uref-d20483554E87b6F2F59E31D1bB1804A6Be8f6CEbA2b13dd160631d6e9c6e97C5-007"
 "deploy_hash":"Ae5ddB8b7B60AeEC20F06aFa23602a1EB8A42406D027667Bd932179813E9bfe3"
 }

 */
/*
 pub struct Transfer {
     pub deploy_hash: DeployHash,
     pub from: AccountHash,
     pub to: Option<AccountHash>,
     pub source: URef,
     pub target: URef,
     pub amount: U512,
     pub gas: U512,
     pub id: Option<u64>,
 }
 */
public class TransformTransfer{
    public var deployHash:String?//a hash
    public var from:String?//a hash "account-hash-f929911F7494A360271b968ac00Fe2220773235e725366952De5d9a349e57c7B"
    public var to:String?//a hash or can be NULL
    public var source:String?//URef "uref-20906191670E7F3De270fd0800406a10ABA1746aE56beDF835ed876E60Ae5b2D-007"
    public var target:String?//URef "uref-d20483554E87b6F2F59E31D1bB1804A6Be8f6CEbA2b13dd160631d6e9c6e97C5-007"
    public var amount:U512?//"57028133000"
    public var gas:U512?//"0"
    public var id:UInt64?//NULL
}
public class EraInfo {
    
}
public class URef {
    
}
public class TransferAddr {
    
}
public class AccountHash {
    
}
public class CLValue {
    public var clType:CLType?
    public var bytes:String?
    public var parse:AnyObject?
}
public class U512 {
    public var valueInStr:String?
}
public class U256 {
    
}
public class U128 {
    
}
