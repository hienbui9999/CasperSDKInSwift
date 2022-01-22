import Foundation

public enum Transform {
    case Identity
    case WriteCLValue(CLValue)
    case WriteAccount(AccountHash)
    case WriteContractWasm
    case WriteContract
    case WriteContractPackage
    case WriteDeployInfo(DeployInfo)
    case WriteEraInfo(EraInfo)
    case WriteTransfer(Transfer)
    case WriteBid(Bid)
    case WriteWithdraw([UnbondingPurse])
    case AddInt32(Int32)
    case AddUInt64(UInt64)
    case AddUInt128(U128Class)
    case AddUInt256(U256Class)
    case AddUInt512(U512Class)
    case AddKeys([NamedKey])
    case Failure(String)
    case NONE
}
public class TransformHelper {
    public static func printMe(transform:Transform) {
        switch transform {
        case .Identity:
            print("Transform type is Identity")
        case .WriteCLValue(let cLValue):
            print("Transform type is WriteCLValue, value for cLValue:")
        case .WriteAccount(let accountHash):
            print("in print me, WriteAccount, accountHash:\(accountHash.value)")
        case .WriteContractWasm:
            print("Transform type is WriteContractWasm")
        case .WriteContract:
            print("Transform type is WriteContract")
        case .WriteContractPackage:
            print("Transform type is WriteContractPackage")
        case .WriteDeployInfo(let deployInfo):
            print("Transform type is WriteDeployInfo")
        case .WriteEraInfo(let eraInfo):
            print("Transform type is EraInfo")
        case .WriteTransfer(let transfer):
            print("Transform type is WriteTransfer")
        case .WriteBid(let bid):
            print("Transform type is bid")
        case .WriteWithdraw(let listWithDraws):
            print("Transform type is WriteWithdraw")
            var counter:Int = 0;
            for draw in listWithDraws {
                counter += 1;
                print("withdraw number \(counter) amount:\(draw.amount), bonding_purse:\(draw.bonding_purse.value)")
            }
        case .AddInt32(let int32):
            print("Transform type is AddInt32")
        case .AddUInt64(let uInt64):
            print("Transform type is AddInt64")
        case .AddUInt128(let u128Class):
            print("Transform type is AddUInt128")
        case .AddUInt256(let u256Class):
            print("Transform type is AddUInt256")
        case .AddUInt512(let u512Class):
            print("Transform type is AddUInt512")
        case .AddKeys(let listAddKeys):
            print("Transform type is AddKeys, total NamedKey:\(listAddKeys.count)")
            var counter:Int = 0;
            for listAddKey in listAddKeys {
                counter += 1;
                print("NamedKey number \(counter) key is:\(listAddKey.key), name:\(listAddKey.name)")
            }
        case .Failure(let string):
            print("Transform type is Failure")
        case .NONE:
            print("Transform type is NONE")
        }
    }
    public static func getTransform(from:[String:Any])-> Transform {
        var retValue:Transform = .NONE
        if let transformType = from["transform"] as? String {
            if transformType == "Identity" {
                retValue = .Identity
            } else if transformType == "WriteContractWasm" {
                retValue = .WriteContractWasm
            } else if transformType == "WriteContract" {
                retValue = .WriteContract
            } else if transformType == "WriteContractPackage" {
                retValue = .WriteContractPackage
            }
        }
        if let transformType = from["transform"] as? AnyObject {
            if let addUInt512 = transformType["AddUInt512"] as? String {
               retValue = .AddUInt512(U512Class.fromStringToU512(from: addUInt512))
           }
            else if let addInt32 = transformType["AddInt32"] as? Int32 {
                retValue = .AddInt32(addInt32)
            } else if let addUInt64 = transformType["AddUInt64"] as? UInt64 {
                retValue = .AddUInt64(addUInt64)
            } else if let addUInt128 = transformType["AddUInt128"] as? String {
                retValue = .AddUInt128(U128Class.fromStringToU128(from: addUInt128))
            } else if let addUInt256 = transformType["AddUInt256"] as? String {
                retValue = .AddUInt256(U256Class.fromStringToU256(from: addUInt256))
            } else if let writeAccount = transformType["WriteAccount"] as? String {
                retValue = .WriteAccount(AccountHash.fromStrToHash(from: writeAccount))
            }
            else if let transformWriteDeployInfo = transformType["WriteDeployInfo"] as? [String:Any] {
                retValue = .WriteDeployInfo(DeployInfo.fromJsonToDeployInfo(from: transformWriteDeployInfo))
            } else if let writeEraInfo = transformType["WriteEraInfo"] as? [String:Any] {
            } else if let transformTransfer = transformType["WriteTransfer"] as? [String:Any] {
                retValue = .WriteTransfer(Transfer.fromJsonToTransfer(from: transformTransfer))
            } else if let bidJson = transformType["WriteBid"] as? [String:Any] {
                var retBid:Bid = Bid();
                if let validator_public_key = bidJson["validator_public_key"] as? String {
                    retBid.validator_public_key = PublicKey.strToPublicKey(from: validator_public_key)
                }
                if let delegation_rate = bidJson["delegation_rate"] as? UInt8 {
                    retBid.delegation_rate = delegation_rate
                }
                if let bonding_purse = bidJson["bonding_purse"] as? String {
                    retBid.bonding_purse = URef.fromStringToUref(from: bonding_purse)
                }
                if let staked_amount = bidJson["staked_amount"] as? String {
                    retBid.staked_amount = U512Class.fromStringToU512(from: staked_amount)
                }
                if let release_timestamp_millis = bidJson["release_timestamp_millis"] as? UInt64 {
                    retBid.release_timestamp_millis = release_timestamp_millis
                }
                if let inactive = bidJson["inactive"] as? Bool {
                    retBid.inactive = inactive
                }
                if let vesting_schedule = bidJson["vesting_schedule"] as? [String:Any] {
                    retBid.vesting_schedule = VestingSchedule.jsonToVestingSchedule(from: vesting_schedule)
                }
                if let delegators = bidJson["delegators"] as? [String:Any] {
                    let totalDelegator : Int = delegators.count;
                    var counter : Int = 0 ;
                    for (key,value) in delegators {
                        counter += 1;
                        let oneD = Delegator.jsonToDelegator(from: value as! [String:Any])
                        retBid.delegators[key] = oneD
                    }
                }
                retValue = .WriteBid(retBid)
            } else if let WriteWithdraws = transformType["WriteWithdraw"] as? [AnyObject] {
                var listWithDraw:[UnbondingPurse] = [UnbondingPurse]();
                let totalWithDraw:Int = WriteWithdraws.count;
                for withdraw in WriteWithdraws {
                    let oneUP : UnbondingPurse = UnbondingPurse();
                    if let bonding_purse = withdraw["bonding_purse"] as? String {
                        oneUP.bonding_purse = URef.fromStringToUref(from: bonding_purse)
                    }
                    if let validator_public_key = withdraw["validator_public_key"] as? String {
                        oneUP.validator_public_key = PublicKey.strToPublicKey(from: validator_public_key)
                    }
                    if let unbonder_public_key = withdraw["unbonder_public_key"] as? String {
                        oneUP.unbonder_public_key = PublicKey.strToPublicKey(from: unbonder_public_key)
                    }
                    if let era_of_creation = withdraw["era_of_creation"] as? UInt64 {
                        oneUP.era_of_creation = era_of_creation
                    }
                    if let amount = withdraw["amount"] as? String {
                        oneUP.amount = U512Class.fromStringToU512(from: amount)
                    }
                    listWithDraw.append(oneUP)
                }
                retValue = .WriteWithdraw(listWithDraw)
            } else if let AddKeys = transformType["AddKeys"] as? [AnyObject] {
                var listNamedKey:[NamedKey] = [NamedKey]();
                for AddKey in AddKeys {
                    let oneNamedKey:NamedKey = NamedKey();
                    if let key = AddKey["key"] as? String {
                        oneNamedKey.key = key
                    }
                    if let name = AddKey["name"] as? String {
                        oneNamedKey.name = name
                    }
                    listNamedKey.append(oneNamedKey)
                }
                retValue = .AddKeys(listNamedKey)
            }
            else if let transformWriteCLValue = transformType["WriteCLValue"] as? [String:Any] {
                let  clValue : CLValue = NamedArg.jsonToCLValue(input: transformWriteCLValue);
                retValue = .WriteCLValue(clValue)
            }
        }
        
        
        TransformHelper.printMe(transform: retValue)
        return retValue;
    }
}
