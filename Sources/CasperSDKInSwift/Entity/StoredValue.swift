import Foundation
/**
 Enumeration type represents the StoredValue
 */

public enum StoredValue {
    case    CLValue(CLValue)
    case    Account(Account)
    case    ContractWasm(String)
    case    Contract(Contract)
    case    ContractPackage(ContractPackage)
    case    Transfer(Transfer)
    case    DeployInfo(DeployInfo)
    case    EraInfo(EraInfo)
    case    Bid(Bid)
    case    Withdraw([UnbondingPurse])
    case    None
}
/**
 Class supports the getting of StoredValue from Json String
 */

public class StoredValueHelper {
    /**
       Get StoredValue object from Json string
       - Parameter : a Json String represents the StoredValue object
       - Returns: StoredValue object
       */

    public static func getStoredValue(from:[String:Any])->StoredValue {
        var retResult:StoredValue = .None
        if let accountJson = from["Account"] as? [String:Any] {
            retResult = StoredValueHelper.getAccount(from: accountJson)
        } else if let contractWasm = from["ContractWasm"] as? String {
            retResult = StoredValue.ContractWasm(contractWasm)
        } else if let contractJson = from["Contract"] as? [String:Any] {
            retResult = StoredValueHelper.getContract(from: contractJson)
        } else if let contractPackageJson = from["ContractPackage"] as? [String:Any] {
            retResult = StoredValueHelper.getContractPackage(from: contractPackageJson)
        } else if let transferJson = from["Transfer"] as? [String:Any] {
            retResult = StoredValueHelper.getTransfer(from: transferJson)
        } else if let deployInfoJson = from["DeployInfo"] as? [String:Any] {
            retResult = StoredValueHelper.getDeployInfo(from: deployInfoJson)
        } else if let eraInfoJson = from["EraInfo"] as? [String:Any] {
            retResult = StoredValueHelper.getEraInfo(from: eraInfoJson)
        } else if let bidJson = from["Bid"] as? [String:Any] {
            retResult = StoredValueHelper.getBid(from: bidJson)
        } else if let withdrawJson = from["Withdraw"] as? [AnyObject] {
            retResult = StoredValueHelper.getWithdraw(from: withdrawJson)
        } else if let clValue = from["CLValue"] as?[String:Any] {
            let retClValue = CLValue.getCLValue(from: clValue)
            retResult = .CLValue(retClValue)
        }
        return retResult
    }
    //StoredValue.Account(Account)
    public static func getAccount(from:[String:Any])->StoredValue {
        let account : Account = Account();
        if let account_hash = from["account_hash"] as? String {
            let aHash:AccountHash = AccountHash();
            aHash.value = account_hash;
            account.account_hash = aHash;
        }
        if let named_keys = from["name_keys"] as? [AnyObject] {
            account.named_keys = [NamedKey]();
            for named_key in named_keys {
                let nameKey:NamedKey = NamedKey();
                if let name = named_key["name"] as? String {
                    nameKey.name = name;
                }
                if let key = named_key["key"] as? String {
                    nameKey.key = key;
                }
                account.named_keys.append(nameKey)
            }
        }
        if let main_purse = from["main_purse"] as? String {
            let uref:URef = URef();
            uref.value = main_purse
            account.main_purse = uref
        }
        if let associated_keys = from["associated_keys"] as? [AnyObject] {
            account.associated_keys = [AssociatedKey]();
            for associated_key in associated_keys {
                let oneAK : AssociatedKey = AssociatedKey();
                if let weight = associated_key["weight"] as? UInt64 {
                    oneAK.weight = weight;
                }
                if let account_hash = associated_key["account_hash"] as? String {
                    oneAK.account_hash = AccountHash.fromStrToHash(from: account_hash);
                }
                account.associated_keys.append(oneAK)
            }
        }
        if let action_thresholds = from["action_thresholds"] as? [String:Any] {
            let at:ActionThresholds = ActionThresholds();
            if let deployment = action_thresholds["deployment"] as? UInt64 {
                at.deployment = deployment
            }
            if let key_management = action_thresholds["key_management"] as? UInt64 {
                at.key_management = key_management
            }
            account.action_thresholds = at;
        }
        return StoredValue.Account(account)
    }
    
    //StoredValue.Contract(Contract)

    public static func getContract(from:[String:Any])->StoredValue {
        let retContract:Contract = Contract();
        if let contract_package_hash = from["contract_package_hash"] as? String {
            retContract.contract_package_hash = contract_package_hash
        }
        if let contract_wasm_hash = from["contract_wasm_hash"] as? String {
            retContract.contract_wasm_hash = contract_wasm_hash
        }
        if let named_keys = from["named_keys"] as? [AnyObject] {
            retContract.named_keys = [NamedKey]();
            for named_key in named_keys {
                let oneNK : NamedKey = NamedKey();
                if let name = named_key["name"] as? String {
                    oneNK.name = name
                }
                if let key = named_key["key"] as? String {
                    oneNK.key = key
                }
                retContract.named_keys?.append(oneNK)
            }
        }
        if let entry_points = from["entry_points"] as? [AnyObject] {
            retContract.entry_points = [EntryPoint]();
            for entry_point in entry_points {
                let oneEP:EntryPoint = EntryPoint();
                if let name = entry_point["name"] as? String {
                    oneEP.name = name
                }
                if let entry_point_type = entry_point["entry_point_type"] as? String {
                    oneEP.entry_point_type = entry_point_type
                }
                if let access = entry_point["access"] as? String {
                    oneEP.access = access
                }
                if let ret = entry_point["ret"] as? [String:Any] {
                    oneEP.ret = CLTypeHelper.jsonToCLType(from: ret as AnyObject)
                }
                if let args = entry_point["args"] as? [AnyObject] {
                    oneEP.args = [NamedCLTypeArg]();
                    for arg in args {
                        let oneNCLTA:NamedCLTypeArg = NamedCLTypeArg();
                        if let name = arg["name"] as? String {
                            oneNCLTA.name = name;
                        }
                        if let clTypeJson = arg["cl_type"] as? [String:Any] {
                            oneNCLTA.cl_type = CLTypeHelper.jsonToCLType(from: clTypeJson as AnyObject)
                        }
                        oneEP.args?.append(oneNCLTA)
                    }
                    
                }
                retContract.entry_points!.append(oneEP)
            }
        }
        if let protocolVersion = from["protocol_version"] as? String {
            retContract.protocol_version = ProtocolVersion.strToProtocol(from: protocolVersion);
        }
        return StoredValue.Contract(retContract)
    }
    
    //StoredValue.ContractPackage(ContractPackage)

    public static func getContractPackage(from:[String:Any])->StoredValue {
        let ret:ContractPackage = ContractPackage();
        if let access_key = from["access_key"] as? String {
            let uref:URef = URef.fromStringToUref(from: access_key)
            ret.access_key = uref
        }
        if let versions = from["versions"] as? [AnyObject] {
            ret.versions = [ContractVersion]();
            for version in versions {
                let oneVersion : ContractVersion = ContractVersion();
                if let protocol_version_major = version["protocol_version_major"] as? UInt32 {
                    oneVersion.protocol_version_major = protocol_version_major
                }
                if let contract_version = version["contract_version"] as? UInt32 {
                    oneVersion.contract_version = contract_version
                }
                if let contract_hash = version["contract_hash"] as? String {
                    oneVersion.contract_hash = contract_hash
                }
                ret.versions!.append(oneVersion)
            }
        }
        if let disabled_versions = from["disabled_versions"] as? [AnyObject] {
            ret.disabled_versions = [DisableVersion]();
            for disabled_version in disabled_versions {
                let oneDVersion:DisableVersion = DisableVersion();
                if let protocol_version_major = disabled_version["protocol_version_major"] as? UInt32 {
                    oneDVersion.protocol_version_major = protocol_version_major
                }
                if let contract_version = disabled_version["contract_version"] as? UInt32 {
                    oneDVersion.contract_version = contract_version
                }
                ret.disabled_versions!.append(oneDVersion)
            }
        }
        if let groups = from["groups"] as? [AnyObject] {
            ret.groups = [Groups]();
            for group in groups {
                let oneGroup:Groups = Groups();
                if let g = group["group"] as? String {
                    oneGroup.group = g;
                }
                if let groupKeys = group["keys"] as? [String] {
                    oneGroup.keys = [URef]();
                    for groupKey in groupKeys {
                        let oneUref = URef.fromStringToUref(from: groupKey);
                        oneGroup.keys.append(oneUref)
                    }
                }
                ret.groups!.append(oneGroup)
            }
        }
        return StoredValue.ContractPackage(ret)
    }
    
    //StoredValue.DeployInfo(DeployInfo)
    
    public static func getDeployInfo(from:[String:Any])->StoredValue {
        let deployInfo:DeployInfo = DeployInfo()
        if let deploy_hash = from["deploy_hash"] as? String {
            deployInfo.deploy_hash = deploy_hash
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
            deployInfo.transfers = [String]();
            for transfer in transfers {
                deployInfo.transfers.append(transfer)
            }
        }
        return StoredValue.DeployInfo(deployInfo)
    }
    
    //StoredValue.Transfer(Transfer)
    
    public static func getTransfer(from:[String:Any])->StoredValue {
        let transfer = Transfer.fromJsonToTransfer(from: from)
        return StoredValue.Transfer(transfer)
    }
    
    // StoredValue.EraInfo(EraInfo)

    public static func getEraInfo(from:[String:Any])->StoredValue {
        let eraInfo : EraInfo = EraInfo();
        if let seigniorageAllocations = from["seigniorage_allocations"] as? [AnyObject] {
            eraInfo.listSeigniorageAllocation = [SeigniorageAllocation]();
            var totalDelegator = 0;
            var totalValidator = 0;
            for sei in seigniorageAllocations {
                if let delegator = sei["Delegator"] as? [String:Any] {
                    let oneDelegator:Delegator2 = Delegator2();
                    if let amount = delegator["amount"] as? String {
                        oneDelegator.amount = U512Class.fromStringToU512(from: amount);
                    }
                    if let delegator_public_key = delegator["delegator_public_key"] as? String {
                        oneDelegator.delegator_public_key = PublicKey.strToPublicKey(from: delegator_public_key)
                    }
                    if let validator_public_key = delegator["validator_public_key"] as? String {
                        oneDelegator.validator_public_key = PublicKey.strToPublicKey(from: validator_public_key)
                    }
                    eraInfo.listSeigniorageAllocation.append(.Delegator(oneDelegator))
                    totalDelegator += 1;
                }
                if let validator = sei["Validator"] as? [String:Any] {
                    totalValidator += 1;
                    let oneValidator:Validator = Validator();
                    if let amount = validator["amount"] as? String {
                        let amount512:U512Class = U512Class();
                        amount512.valueInStr = amount;
                        oneValidator.amount = amount512;
                    }
                    if let validator_public_key = validator["validator_public_key"] as? String {
                        oneValidator.validator_public_key = PublicKey.strToPublicKey(from: validator_public_key);
                    }
                    eraInfo.listSeigniorageAllocation.append(.Validator(oneValidator))
                }
            }
        }
        return .EraInfo(eraInfo)
    }
    //StoredValue.Bid(Bid)
    public static func getBid(from:[String:Any])->StoredValue {
        let retBid:Bid = Bid();
        if let validator_public_key = from["validator_public_key"] as? String {
            retBid.validator_public_key = PublicKey.strToPublicKey(from: validator_public_key)
        }
        if let bonding_purse = from["bonding_purse"] as? String {
            retBid.bonding_purse = URef.fromStringToUref(from: bonding_purse)
        }
        if let staked_amount = from["staked_amount"] as? String {
            retBid.staked_amount = U512Class.fromStringToU512(from: staked_amount)
        }
        if let delegation_rate = from["delegation_rate"] as? UInt8 {
            retBid.delegation_rate = delegation_rate
        }
        if let vesting_schedule = from["vesting_schedule"] as? [String:Any] {
            retBid.vesting_schedule = VestingSchedule.jsonToVestingSchedule(from: vesting_schedule)
        }
        if let delegators = from["delegators"] as? [String:AnyObject] {
           
           
            for (key,value) in delegators {
               
                let oneDelegator:Delegator = Delegator();
                if let validator_public_key = value ["validator_public_key"] as? String{
                    oneDelegator.validator_public_key = PublicKey.strToPublicKey(from: validator_public_key)
                }
                if let staked_amount = value["staked_amount"] as? String {
                    oneDelegator.staked_amount = U512Class.fromStringToU512(from: staked_amount)
                }
                if let bonding_purse = value["bonding_purse"] as? String {
                    oneDelegator.bonding_purse = URef.fromStringToUref(from: bonding_purse)
                }
                if let vesting_schedule = value["vesting_schedule"] as? [String:Any] {
                    oneDelegator.vesting_schedule = VestingSchedule.jsonToVestingSchedule(from: vesting_schedule)
                }
                retBid.delegators[key] = oneDelegator;
            }
        }
        if let inactive = from["inactive"] as? Bool {
            retBid.inactive = inactive
        }
        return .Bid(retBid)
    }
    public static func getWithdraw(from:[AnyObject])->StoredValue {
        var unboundingPurses:[UnbondingPurse] = [UnbondingPurse]();
        for upJson in from {
            let oneUnboundingPurse : UnbondingPurse = UnbondingPurse();
            if let bonding_purse = upJson["bonding_purse"] as? String {
                oneUnboundingPurse.bonding_purse = URef.fromStringToUref(from: bonding_purse)
            }
            if let validator_public_key = upJson["validator_public_key"] as? String {
                oneUnboundingPurse.validator_public_key = PublicKey.strToPublicKey(from: validator_public_key)
            }
            if let unbonder_public_key = upJson["unbonder_public_key"] as? String {
                oneUnboundingPurse.unbonder_public_key = PublicKey.strToPublicKey(from: unbonder_public_key)
            }
            if let era_of_creation = upJson["era_of_creation"] as? UInt64 {
                oneUnboundingPurse.era_of_creation = era_of_creation
            }
            if let amount = upJson["amount"] as? String {
                oneUnboundingPurse.amount = U512Class.fromStringToU512(from: amount)
            }
            unboundingPurses.append(oneUnboundingPurse)
        }
        let retWithdraw : StoredValue = .Withdraw(unboundingPurses)
        return retWithdraw;
    }
    
}
