import Foundation
/**
 Enumeration type represents the StoredValue
 */

public enum StoredValue {
    case    cLValue(CLValue)
    case    account(Account)
    case    contractWasm(String)
    case    contract(Contract)
    case    contractPackage(ContractPackage)
    case    transfer(Transfer)
    case    deployInfo(DeployInfo)
    case    eraInfo(EraInfo)
    case    bid(Bid)
    case    withdraw([UnbondingPurse])
    case    none
}
/**
 Class supports the getting of StoredValue from Json String
 */

public class StoredValueHelper {
    /**
       Get StoredValue object from Json string
       - Parameter: a Json String represents the StoredValue object
       - Returns: StoredValue object
       */

    public static func getStoredValue(from: [String: Any]) -> StoredValue {
        var retResult: StoredValue = .none
        if let accountJson = from["Account"] as? [String: Any] {
            retResult = StoredValueHelper.getAccount(from: accountJson)
        } else if let contractWasm = from["ContractWasm"] as? String {
            retResult = StoredValue.contractWasm(contractWasm)
        } else if let contractJson = from["Contract"] as? [String: Any] {
            retResult = StoredValueHelper.getContract(from: contractJson)
        } else if let contractPackageJson = from["ContractPackage"] as? [String: Any] {
            retResult = StoredValueHelper.getContractPackage(from: contractPackageJson)
        } else if let transferJson = from["Transfer"] as? [String: Any] {
            retResult = StoredValueHelper.getTransfer(from: transferJson)
        } else if let deployInfoJson = from["DeployInfo"] as? [String: Any] {
            retResult = StoredValueHelper.getDeployInfo(from: deployInfoJson)
        } else if let eraInfoJson = from["EraInfo"] as? [String: Any] {
            retResult = StoredValueHelper.getEraInfo(from: eraInfoJson)
        } else if let bidJson = from["Bid"] as? [String: Any] {
            retResult = StoredValueHelper.getBid(from: bidJson)
        } else if let withdrawJson = from["Withdraw"] as? [AnyObject] {
            retResult = StoredValueHelper.getWithdraw(from: withdrawJson)
        } else if let clValue = from["CLValue"] as?[String: Any] {
            let retClValue = CLValue.getCLValue(from: clValue)
            retResult = .cLValue(retClValue)
        }
        return retResult
    }

    // StoredValue.Account(Account)
    public static func getAccount(from: [String: Any]) -> StoredValue {
        let account: Account = Account()
        if let accountHash1 = from["account_hash"] as? String {
            let aHash: AccountHash = AccountHash()
            aHash.value = accountHash1
            account.accountHash = aHash
        }
        if let namedKeys1 = from["name_keys"] as? [AnyObject] {
            account.namedKeys = [NamedKey]()
            for namedKey1 in namedKeys1 {
                let nameKey: NamedKey = NamedKey()
                if let name = namedKey1["name"] as? String {
                    nameKey.name = name
                }
                if let key = namedKey1["key"] as? String {
                    nameKey.key = key
                }
                account.namedKeys.append(nameKey)
            }
        }
        if let mainPurse1 = from["main_purse"] as? String {
            let uref: URef = URef()
            uref.value = mainPurse1
            account.mainPurse = uref
        }
        if let associatedKeys1 = from["associated_keys"] as? [AnyObject] {
            account.associatedKeys = [AssociatedKey]()
            for associated_key in associatedKeys1 {
                let oneAK: AssociatedKey = AssociatedKey()
                if let weight = associated_key["weight"] as? UInt64 {
                    oneAK.weight = weight
                }
                if let accountHash1 = associated_key["account_hash"] as? String {
                    oneAK.accountHash = AccountHash.fromStrToHash(from: accountHash1)
                }
                account.associatedKeys.append(oneAK)
            }
        }
        if let actionThresholds1 = from["action_thresholds"] as? [String: Any] {
            let at: ActionThresholds = ActionThresholds()
            if let deployment = actionThresholds1["deployment"] as? UInt64 {
                at.deployment = deployment
            }
            if let keyManagement1 = actionThresholds1["key_management"] as? UInt64 {
                at.keyManagement = keyManagement1
            }
            account.actionThresholds = at
        }
        return StoredValue.account(account)
    }
    // StoredValue.Contract(Contract)

    public static func getContract(from: [String: Any]) -> StoredValue {
        let retContract: Contract = Contract()
        if let contractPackageHash1 = from["contract_package_hash"] as? String {
            retContract.contractPackageHash = contractPackageHash1
        }
        if let contractWasmHash1 = from["contract_wasm_hash"] as? String {
            retContract.contractWasmHash = contractWasmHash1
        }
        if let namedKeys1 = from["named_keys"] as? [AnyObject] {
            retContract.namedKeys = [NamedKey]()
            for namedKey1 in namedKeys1 {
                let oneNK: NamedKey = NamedKey()
                if let name = namedKey1["name"] as? String {
                    oneNK.name = name
                }
                if let key = namedKey1["key"] as? String {
                    oneNK.key = key
                }
                retContract.namedKeys?.append(oneNK)
            }
        }
        if let entryPoints1 = from["entry_points"] as? [AnyObject] {
            retContract.entryPoints = [EntryPoint]()
            for entryPoint1 in entryPoints1 {
                let oneEP: EntryPoint = EntryPoint()
                if let name = entryPoint1["name"] as? String {
                    oneEP.name = name
                }
                if let entryPointType1 = entryPoint1["entry_point_type"] as? String {
                    oneEP.entryPointType = entryPointType1
                }
                if let access = entryPoint1["access"] as? String {
                    oneEP.access = access
                }
                if let ret = entryPoint1["ret"] as? [String: Any] {
                    oneEP.ret = CLTypeHelper.jsonToCLType(from: ret as AnyObject)
                }
                if let args = entryPoint1["args"] as? [AnyObject] {
                    oneEP.args = [NamedCLTypeArg]()
                    for arg in args {
                        let oneNCLTA: NamedCLTypeArg = NamedCLTypeArg()
                        if let name = arg["name"] as? String {
                            oneNCLTA.name = name
                        }
                        if let clTypeJson = arg["cl_type"] as? [String: Any] {
                            oneNCLTA.clType = CLTypeHelper.jsonToCLType(from: clTypeJson as AnyObject)
                        }
                        oneEP.args?.append(oneNCLTA)
                    }
                }
                retContract.entryPoints!.append(oneEP)
            }
        }
        if let protocolVersion = from["protocol_version"] as? String {
            retContract.protocolVersion = ProtocolVersion.strToProtocol(from: protocolVersion)
        }
        return StoredValue.contract(retContract)
    }
    // StoredValue.ContractPackage(ContractPackage)

    public static func getContractPackage(from: [String: Any]) -> StoredValue {
        let ret: ContractPackage = ContractPackage()
        if let accessKey1 = from["access_key"] as? String {
            let uref: URef = URef.fromStringToUref(from: accessKey1)
            ret.accessKey = uref
        }
        if let versions = from["versions"] as? [AnyObject] {
            ret.versions = [ContractVersion]()
            for version in versions {
                let oneVersion: ContractVersion = ContractVersion()
                if let protocolVersionMajor1 = version["protocol_version_major"] as? UInt32 {
                    oneVersion.protocolVersionMajor = protocolVersionMajor1
                }
                if let contractVersion1 = version["contract_version"] as? UInt32 {
                    oneVersion.contractVersion = contractVersion1
                }
                if let contractHash1 = version["contract_hash"] as? String {
                    oneVersion.contractHash = contractHash1
                }
                ret.versions!.append(oneVersion)
            }
        }
        if let disabledVersions1 = from["disabled_versions"] as? [AnyObject] {
            ret.disabledVersions = [DisableVersion]()
            for disabledVersion1 in disabledVersions1 {
                let oneDVersion: DisableVersion = DisableVersion()
                if let protocolVersionMajor1 = disabledVersion1["protocol_version_major"] as? UInt32 {
                    oneDVersion.protocolVersionMajor = protocolVersionMajor1
                }
                if let contractVersion1 = disabledVersion1["contract_version"] as? UInt32 {
                    oneDVersion.contractVersion = contractVersion1
                }
                ret.disabledVersions!.append(oneDVersion)
            }
        }
        if let groups = from["groups"] as? [AnyObject] {
            ret.groups = [Groups]()
            for group in groups {
                let oneGroup: Groups = Groups()
                if let g = group["group"] as? String {
                    oneGroup.group = g
                }
                if let groupKeys = group["keys"] as? [String] {
                    oneGroup.keys = [URef]()
                    for groupKey in groupKeys {
                        let oneUref = URef.fromStringToUref(from: groupKey)
                        oneGroup.keys.append(oneUref)
                    }
                }
                ret.groups!.append(oneGroup)
            }
        }
        return StoredValue.contractPackage(ret)
    }
    // StoredValue.DeployInfo(DeployInfo)

    public static func getDeployInfo(from: [String: Any]) -> StoredValue {
        let deployInfo: DeployInfo = DeployInfo()
        if let deployHash1 = from["deploy_hash"] as? String {
            deployInfo.deployHash = deployHash1
        }
        if let fromDeploy = from["from"] as? String {
            deployInfo.from = fromDeploy
        }
        if let source = from["source"] as? String {
            deployInfo.source = URef.fromStringToUref(from: source)
        }
        if let gas = from["gas"] as? String {
            deployInfo.gas = U512Class.fromStringToU512(from: gas)
        }
        if let transfers = from["transfers"] as? [String] {
            deployInfo.transfers = [String]()
            for transfer in transfers {
                deployInfo.transfers.append(transfer)
            }
        }
        return StoredValue.deployInfo(deployInfo)
    }
    // StoredValue.Transfer(Transfer)

    public static func getTransfer(from: [String: Any]) -> StoredValue {
        let transfer = Transfer.fromJsonToTransfer(from: from)
        return StoredValue.transfer(transfer)
    }
    //  StoredValue.EraInfo(EraInfo)

    public static func getEraInfo(from: [String: Any]) -> StoredValue {
        let eraInfo: EraInfo = EraInfo()
        if let seigniorageAllocations = from["seigniorage_allocations"] as? [AnyObject] {
            eraInfo.listSeigniorageAllocation = [SeigniorageAllocation]()
            var totalDelegator = 0
            var totalValidator = 0
            for sei in seigniorageAllocations {
                if let delegator = sei["Delegator"] as? [String: Any] {
                    let oneDelegator: Delegator2 = Delegator2()
                    if let amount = delegator["amount"] as? String {
                        oneDelegator.amount = U512Class.fromStringToU512(from: amount)
                    }
                    if let delegatorPublicKey1 = delegator["delegator_public_key"] as? String {
                        oneDelegator.delegatorPublicKey = PublicKey.strToPublicKey(from: delegatorPublicKey1)
                    }
                    if let validatorPublicKey1 = delegator["validator_public_key"] as? String {
                        oneDelegator.validatorPublicKey = PublicKey.strToPublicKey(from: validatorPublicKey1)
                    }
                    eraInfo.listSeigniorageAllocation.append(.delegator(oneDelegator))
                    totalDelegator += 1
                }
                if let validator = sei["Validator"] as? [String: Any] {
                    totalValidator += 1
                    let oneValidator: Validator = Validator()
                    if let amount = validator["amount"] as? String {
                        let amount512: U512Class = U512Class()
                        amount512.valueInStr = amount
                        oneValidator.amount = amount512
                    }
                    if let validatorPublicKey1 = validator["validator_public_key"] as? String {
                        oneValidator.validatorPublicKey = PublicKey.strToPublicKey(from: validatorPublicKey1)
                    }
                    eraInfo.listSeigniorageAllocation.append(.validator(oneValidator))
                }
            }
        }
        return .eraInfo(eraInfo)
    }
    // StoredValue.Bid(Bid)

    public static func getBid(from: [String: Any]) -> StoredValue {
        let retBid: Bid = Bid()
        if let validatorPublicKey1 = from["validator_public_key"] as? String {
            retBid.validatorPublicKey = PublicKey.strToPublicKey(from: validatorPublicKey1)
        }
        if let bondingPurse1 = from["bonding_purse"] as? String {
            retBid.bondingPurse = URef.fromStringToUref(from: bondingPurse1)
        }
        if let stakedAmount1 = from["staked_amount"] as? String {
            retBid.stakedAmount = U512Class.fromStringToU512(from: stakedAmount1)
        }
        if let delegationRate1 = from["delegation_rate"] as? UInt8 {
            retBid.delegationRate = delegationRate1
        }
        if let vestingSchedule1 = from["vesting_schedule"] as? [String: Any] {
            retBid.vestingSchedule = VestingSchedule.jsonToVestingSchedule(from: vestingSchedule1)
        }
        if let delegators = from["delegators"] as? [String: AnyObject] {
            for (key, value) in delegators {
                let oneDelegator: Delegator = Delegator()
                if let validatorPublicKey1 = value ["validator_public_key"] as? String {
                    oneDelegator.validatorPublicKey = PublicKey.strToPublicKey(from: validatorPublicKey1)
                }
                if let stakedAmount1 = value["staked_amount"] as? String {
                    oneDelegator.stakedAmount = U512Class.fromStringToU512(from: stakedAmount1)
                }
                if let bondingPurse1 = value["bonding_purse"] as? String {
                    oneDelegator.bondingPurse = URef.fromStringToUref(from: bondingPurse1)
                }
                if let vestingSchedule1 = value["vesting_schedule"] as? [String: Any] {
                    oneDelegator.vestingSchedule = VestingSchedule.jsonToVestingSchedule(from: vestingSchedule1)
                }
                retBid.delegators[key] = oneDelegator
            }
        }
        if let inactive = from["inactive"] as? Bool {
            retBid.inactive = inactive
        }
        return .bid(retBid)
    }

    public static func getWithdraw(from: [AnyObject]) -> StoredValue {
        var unboundingPurses: [UnbondingPurse] = [UnbondingPurse]()
        for upJson in from {
            let oneUnboundingPurse: UnbondingPurse = UnbondingPurse()
            if let bondingPurse1 = upJson["bonding_purse"] as? String {
                oneUnboundingPurse.bondingPurse = URef.fromStringToUref(from: bondingPurse1)
            }
            if let validatorPublicKey1 = upJson["validator_public_key"] as? String {
                oneUnboundingPurse.validatorPublicKey = PublicKey.strToPublicKey(from: validatorPublicKey1)
            }
            if let unbonderPublicKey = upJson["unbonder_public_key"] as? String {
                oneUnboundingPurse.unbonderPublicKey = PublicKey.strToPublicKey(from: unbonderPublicKey)
            }
            if let eraOfCreation1 = upJson["era_of_creation"] as? UInt64 {
                oneUnboundingPurse.eraOfCreation = eraOfCreation1
            }
            if let amount = upJson["amount"] as? String {
                oneUnboundingPurse.amount = U512Class.fromStringToU512(from: amount)
            }
            unboundingPurses.append(oneUnboundingPurse)
        }
        let retWithdraw: StoredValue = .withdraw(unboundingPurses)
        return retWithdraw
    }

}
