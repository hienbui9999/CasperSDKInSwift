import Foundation

class JsonExecutionResult {
    public var blockHash:String?
    public var result:ExecutionResult?
}

public enum ExecutionResult {
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
    case WriteCLValue(CLValue)
    case WriteAccount(AccountHash)
    case WriteContractWasm
    case WriteContract
    case WriteContractPackage
    case WriteDeployInfo(DeployInfo)
    case WriteEraInfo(EraInfo)
    case WriteTransfer(TransformTransfer)
    case WriteBid(Bid)
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
    public var bondingPurse:URef?;
    public  var validatorPublicKey:String?;
    public var unbonderPublicKey:String?;
    public var eraOfCreation: EraID?;
    public var amount:U512?
}

public class EraID {
    public var maxValue:UInt64?
}

public class DeployInfo{
    public var deployHash:String?
    public var transfers: [String]?
    public var from:String?
    public var source: String?
    //public var gas:U512?
    public var gas:String?
}

public class Bid {
    
}

public class TransformTransfer{
    public var deployHash:String?
    public var from:String?
    public var to:String?
    public var source:String?
    public var target:String?
    public var amount:U512?
    public var gas:U512?
    public var id:UInt64?
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
