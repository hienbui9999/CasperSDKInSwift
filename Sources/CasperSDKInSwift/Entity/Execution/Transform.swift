import Foundation
/**
 Enumeration type represents the Transform
 */

public enum Transform {
    case identity
    case writeCLValue(CLValue)
    case writeAccount(AccountHash)
    case writeContractWasm
    case writeContract
    case writeContractPackage
    case writeDeployInfo(DeployInfo)
    case writeEraInfo(EraInfo)
    case writeTransfer(Transfer)
    case writeBid(Bid)
    case writeWithdraw([UnbondingPurse])
    case addInt32(Int32)
    case addUInt64(UInt64)
    case addUInt128(U128Class)
    case addUInt256(U256Class)
    case addUInt512(U512Class)
    case addKeys([NamedKey])
    case failure(String)
    case none
}
/**
 Class provides the supported method for  getting the Transform value
 */

public class TransformHelper {
    /**
        Get Transform value from Json string
        - Parameter: a Json String represents the Transform value
        - Returns: Transform value
        */

    public static func getTransform(from: [String: Any]) -> Transform {
        var retValue: Transform = .none
        if let transformType = from["transform"] as? String {
            if transformType == "Identity" {
                retValue = .identity
            } else if transformType == "WriteContractWasm" {
                retValue = .writeContractWasm
            } else if transformType == "WriteContract" {
                retValue = .writeContract
            } else if transformType == "WriteContractPackage" {
                retValue = .writeContractPackage
            }
        }
        if let transformType = from["transform"] as AnyObject? {
            if let addUInt512 = transformType["AddUInt512"] as? String {
               retValue = .addUInt512(U512Class.fromStringToU512(from: addUInt512))
           }
            else if let addInt32 = transformType["AddInt32"] as? Int32 {
                retValue = .addInt32(addInt32)
            } else if let addUInt64 = transformType["AddUInt64"] as? UInt64 {
                retValue = .addUInt64(addUInt64)
            } else if let addUInt128 = transformType["AddUInt128"] as? String {
                retValue = .addUInt128(U128Class.fromStringToU128(from: addUInt128))
            } else if let addUInt256 = transformType["AddUInt256"] as? String {
                retValue = .addUInt256(U256Class.fromStringToU256(from: addUInt256))
            } else if let writeAccount = transformType["WriteAccount"] as? String {
                retValue = .writeAccount(AccountHash.fromStrToHash(from: writeAccount))
            }
            else if let transformWriteDeployInfo = transformType["WriteDeployInfo"] as? [String: Any] {
                retValue = .writeDeployInfo(DeployInfo.fromJsonToDeployInfo(from: transformWriteDeployInfo))
            } else if let _ = transformType["WriteEraInfo"] as? [String: Any] {
            } else if let transformTransfer = transformType["WriteTransfer"] as? [String: Any] {
                retValue = .writeTransfer(Transfer.fromJsonToTransfer(from: transformTransfer))
            } else if let bidJson = transformType["WriteBid"] as? [String: Any] {
                let retBid: Bid = Bid()
                if let validatorPublicKey = bidJson["validator_public_key"] as? String {
                    retBid.validatorPublicKey = PublicKey.strToPublicKey(from: validatorPublicKey)
                }
                if let delegationRate = bidJson["delegation_rate"] as? UInt8 {
                    retBid.delegationRate = delegationRate
                }
                if let bondingPurse = bidJson["bonding_purse"] as? String {
                    retBid.bondingPurse = URef.fromStringToUref(from: bondingPurse)
                }
                if let stakedAmount = bidJson["staked_amount"] as? String {
                    retBid.stakedAmount = U512Class.fromStringToU512(from: stakedAmount)
                }
                if let releaseTimestampMillis = bidJson["release_timestamp_millis"] as? UInt64 {
                    retBid.releaseTimestampMillis = releaseTimestampMillis
                }
                if let inactive = bidJson["inactive"] as? Bool {
                    retBid.inactive = inactive
                }
                if let vestingSchedule = bidJson["vesting_schedule"] as? [String: Any] {
                    retBid.vestingSchedule = VestingSchedule.jsonToVestingSchedule(from: vestingSchedule)
                }
                if let delegators = bidJson["delegators"] as? [String: Any] {
                    for (key, value) in delegators {
                        if let realValue = value as? [String: Any] {
                            // let oneD = Delegator.jsonToDelegator(from: value as! [String: Any])
                            let oneD = Delegator.jsonToDelegator(from: realValue)
                            retBid.delegators[key] = Delegator()
                            retBid.delegators[key] = oneD
                        }
                    }
                }
                retValue = .writeBid(retBid)
            } else if let writeWithdraws = transformType["WriteWithdraw"] as? [AnyObject] {
                var listWithDraw: [UnbondingPurse] = [UnbondingPurse]()
                for withdraw in writeWithdraws {
                    let oneUP: UnbondingPurse = UnbondingPurse()
                    if let bondingPurse = withdraw["bonding_purse"] as? String {
                        oneUP.bondingPurse = URef.fromStringToUref(from: bondingPurse)
                    }
                    if let validatorPublicKey = withdraw["validator_public_key"] as? String {
                        oneUP.validatorPublicKey = PublicKey.strToPublicKey(from: validatorPublicKey)
                    }
                    if let unbonderPublicKey = withdraw["unbonder_public_key"] as? String {
                        oneUP.unbonderPublicKey = PublicKey.strToPublicKey(from: unbonderPublicKey)
                    }
                    if let eraOfCreation = withdraw["era_of_creation"] as? UInt64 {
                        oneUP.eraOfCreation = eraOfCreation
                    }
                    if let amount = withdraw["amount"] as? String {
                        oneUP.amount = U512Class.fromStringToU512(from: amount)
                    }
                    listWithDraw.append(oneUP)
                }
                retValue = .writeWithdraw(listWithDraw)
            } else if let addKeys = transformType["AddKeys"] as? [AnyObject] {
                var listNamedKey: [NamedKey] = [NamedKey]()
                for addKey in addKeys {
                    let oneNamedKey: NamedKey = NamedKey()
                    if let key = addKey["key"] as? String {
                        oneNamedKey.key = key
                    }
                    if let name = addKey["name"] as? String {
                        oneNamedKey.name = name
                    }
                    listNamedKey.append(oneNamedKey)
                }
                retValue = .addKeys(listNamedKey)
            }
            else if let transformWriteCLValue = transformType["WriteCLValue"] as? [String: Any] {
                let  clValue: CLValue = NamedArg.jsonToCLValue(input: transformWriteCLValue)
                retValue = .writeCLValue(clValue)
            }
        }
        return retValue
    }

}
