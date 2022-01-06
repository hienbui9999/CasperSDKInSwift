//
//  File.swift
//  
//
//  Created by Hien on 29/12/2021.
//

import Foundation
public class RuntimeArg {
    public var item0:String = "";//can be among these string: token,amount,,amount_token_desired,amount_cspr_desired,amount_token_min,amount_cspr_min,to,deadline,src_purse,target_account...
    public var argsItem:DeployArgItem=DeployArgItem();
    public func textToArgObject(input:[String:Any]) -> DeployArgItem {
        var retArg:DeployArgItem = DeployArgItem();
        if let bytes = input["bytes"] as? String {
            print("bytes:\(bytes)")
            retArg.bytes = bytes
        }
        if let clType=input["cl_type"] as? String {
            print("clType string value:\(clType)")
            //PRIMITIVE TYPES
            if clType == "U8" {
                retArg.clType = .U8
            }else if clType == "U32" {
                retArg.clType = .U32
            }else if clType == "U64" {
                retArg.clType = .U64
            } else if clType == "U128" {
                retArg.clType = .U128
            } else if clType == "U256" {
                retArg.clType = .U256
            } else if clType == "U512" {
                retArg.clType = .U512
            } else if clType == "String" {
                retArg.clType = .CLType_STRING
            } else if clType == "BOOL" {
                retArg.clType = .BOOL
            } else if clType == "URef" {
                retArg.clType = .CLType_UREF
            } else if clType == "Key" {
                retArg.clType = .CLType_KEY
            }
            retArg.clTypeWarper = clType as AnyObject
        }
        else if let clTypeObj = input["cl_type"] as? AnyObject {
            print("clType:\(clTypeObj)")
            retArg.clTypeWarper = clTypeObj
            let clType = encodeCLTypePrimitive(from: clTypeObj)
            switch clType {
            case .NONE:
                let clTypeCompound = encodeCLTypeCompound(from: clTypeObj)
                retArg.clType = clTypeCompound
                break;
            default:
                retArg.clType = clType;
                break;
            }
        }
        if let parsed = input["parsed"] as? String {
            print("parsed, string type :\(parsed)")
            retArg.parsed = parsed as AnyObject
        } else if let parsed = input["parsed"] as? AnyObject {
            print("parsed any object:\(parsed)")
            retArg.parsed = parsed
            if let account = parsed["Account"] as? String {
                print("parsed account:\(account)")
            }
        }
        return retArg
    }
    public func printMe() {
        print("Arg0:\(item0)")
        argsItem.printMe();
    }
    public func decodeCLTypeCompound(from:CLType)->String {
        return "";
    }
    public func decodeCLTypePrimitive(from:CLType)->String {
        return "";
    }
    public func encodeCLTypePrimitive(from:AnyObject)->CLType {
        var clType : CLType = .NONE
        //primitive type
        if let boolCLType = from["Bool"] as? Bool {
            return clType
        }
        if let u8CLType = from["U8"] as? UInt8 {
            return .U8
        }
        if let u32CLType = from["U32"] as? UInt32 {
            return .U32
        }
        if let u64CLType = from["U64"] as? UInt64 {
            return .U64
        }
        if let u128CLType = from["U128"] as? String {
            return .U128
        }
        if let u256CLType = from["U256"] as? String {
            return .U256
        }
        if let u512CLType = from["U512"] as? String {
            return .U512
        }
        if let stringCLType = from["String"] as? String {
            return .CLType_STRING
        }
        if let keyMapCLType = from["key"] as? String {
            return .CLType_STRING
        }
        if let valueMapCLType = from["value"] as? String {
            return .CLType_STRING
        }
        if let byteArrray = from["ByteArray"] as? UInt32 {
            return .CLType_BytesArray
        }
        if let keyCLType = from["Key"] as? String {
            return .CLType_KEY;
        }
        if let publicKeyCLType = from["PublicKey"] as? String {
            return .CLType_PublicKey;
        }
        if let URefClType = from["URef"] as? String {
            return .CLType_UREF
        }
        return clType
    }
    public func stringToCLTypePrimitive(input:String)->CLType {
        if input == "String" {
            return .CLType_STRING
        } else if input == "Bool" {
            return .BOOL
        } else if input == "U8" {
            return .U8
        } else if input == "U32" {
            return .U32
        } else if input == "U64" {
            return .U64
        } else if input == "U128" {
            return .U128
        } else if input == "I32" {
            return .I32
        } else if input == "I64" {
            return .I64
        } else if input == "U256" {
            return .U256
        } else if input == "U512" {
            return .U512
        } else if input == "String" {
            return .CLType_STRING
        } else if input == "Key" {
            return .CLType_KEY
        } else if input == "URef" {
            return .CLType_UREF
        } else if input == "PublicKey" {
            return .CLType_PublicKey
        } 
        return .NONE
    }
    public func encodeCLTypeCompound(from:AnyObject)->CLType {
        print("Encode from :\(from)")
        var clType:CLType = .NONE
        //FOR LIST TYPE
        if let clType = encodeCLTypePrimitive(from: from) as? CLType {
            print("Encode for primitive:\(from)")
            switch clType {
            case .NONE:
                print("Not primitive")
                break;
            default:
                print("Primitive, cltype:\(clType)")
                return clType
                break;
            }
            
        }
        if let listCLType = from["List"] as? String {
            clType = stringToCLTypePrimitive(input: listCLType)
            print("---CLTYPE LIST:\(clType)")
            return .CLType_LIST(clType)
        } else if let listCLType = from["List"] as? AnyObject {
            if !(listCLType is NSNull) {
                print("Encode compound for LIST level 2: \(listCLType)")
                clType = encodeCLTypeCompound(from: listCLType)
                return .CLType_LIST(clType)
            }
        } else {
            print("NOT LIST, OTHER OBJECT")
        }
        //FOR MAP TYPE
        if let mapCLType = from["Map"] as? AnyObject {
            print("Encod for map")
            if !(mapCLType is NSNull) {
                if let keyCLType = encodeCLTypePrimitive(from: mapCLType) as? CLType {
                    if let valueCLType = encodeCLTypePrimitive(from: mapCLType) as? CLType {
                        return .CLType_MAP(keyCLType, valueCLType)
                    } else {
                        let valueCLType = encodeCLTypeCompound(from: mapCLType) as! CLType
                        return .CLType_MAP(keyCLType, valueCLType)
                    }
                } else {
                    let keyCLType = encodeCLTypeCompound(from: mapCLType) as! CLType
                    if let valueCLType = encodeCLTypePrimitive(from: mapCLType) as? CLType {
                        return .CLType_MAP(keyCLType, valueCLType)
                    } else {
                        let valueCLType = encodeCLTypeCompound(from: mapCLType) as! CLType
                        return .CLType_MAP(keyCLType, valueCLType)
                    }
                }
            }
        }
        //FOR TUPLE1 TYPE
        if let tuple1CLType = from["Tuple1"] as? AnyObject {
            
        }
        //FOR OPTION
        if let optionCLType = from["Option"] as? String {
            clType = stringToCLTypePrimitive(input: optionCLType)
            print("---OPTION TYPE:\(clType)")
            return .CLType_OPTION(clType)
        } else if let optionCLType = from["Option"] as? AnyObject {
            if !(optionCLType is NSNull) {
                print("Encode compound for Option level 2: \(optionCLType)")
                clType = encodeCLTypeCompound(from: optionCLType)
                return .CLType_OPTION(clType)
            }
        } else {
            print("NOT OPTION, OTHER OBJECT")
        }
        return .NONE
    }
}
public class DeployModuleByte {
    public var moduleBytes:String?
    public var args:[RuntimeArg]?
}
public class DeployStoredContractByHash {
    public var hash:String?
    public var entryPoint:String?
    public var args:[RuntimeArg]?
}
public enum ExecutableDeployItem {
    case ModuleBytes (String, [RuntimeArg])//module_bytes - very long string
    /*ModuleBytes {
     module_bytes: Bytes,
     args: RuntimeArgs,
 },*/
    case StoredContractByHash(String,String,[RuntimeArg]) // [RuntimeArg]  - an array of at most 256 item in Rust Vec<u8>
    /*
     StoredContractByHash {
             hash: ContractHash,
             entry_point: String,
             args: RuntimeArgs,
         },
     */
    case StoredContractByName(String,String,[RuntimeArg])
    /*  StoredContractByName {
     name: String,
     entry_point: String,
     args: RuntimeArgs,
 },*/
    case StoredVersionedContractByHash (String,UInt32?,String,[RuntimeArg])
    /*
     StoredVersionedContractByHash {
            hash: ContractPackageHash,
            version: Option<ContractVersion>,
            entry_point: String,
            args: RuntimeArgs,
        },
     */
    case StoredVersionedContractByName(String,UInt32?,String,[RuntimeArg])
    /*StoredVersionedContractByName {
     name: String,
     version: Option<ContractVersion>,
     entry_point: String,
     args: RuntimeArgs,
 },
     */
    case Transfer([RuntimeArg])
    /* Transfer {
     args: RuntimeArgs,
 },*/
    case NONE //JUST FOR INITIAL RETURN VALUE
}

/* --- IN RUST ---
 pub enum ExecutableDeployItem {
 //https://testnet.cspr.live/deploy/1edCE86aB07Aa8a7F9A96A7d8ADAb9AEfF3756225faa8c175F1944149Ac0B74F - payment
 // or https://testnet.cspr.live/deploy/6Dd8E5CdD05A47628ECa05D2Cc10B383F5681eb8C3A4661Ba5b9985769D4323D
     ModuleBytes {
         #[serde(with = "HexForm::<Vec<u8>>")]
         module_bytes: Vec<u8>,
         // assumes implicit `call` noarg entrypoint
         #[serde(with = "HexForm::<Vec<u8>>")]
         args: Vec<u8>,
     },
 //https://testnet.cspr.live/deploy/1edCE86aB07Aa8a7F9A96A7d8ADAb9AEfF3756225faa8c175F1944149Ac0B74F - session
 //or https://testnet.cspr.live/deploy/6Dd8E5CdD05A47628ECa05D2Cc10B383F5681eb8C3A4661Ba5b9985769D4323D
     StoredContractByHash {
         #[serde(with = "HexForm::<[u8; KEY_HASH_LENGTH]>")]
         hash: ContractHash,
         entry_point: String,
         #[serde(with = "HexForm::<Vec<u8>>")]
         args: Vec<u8>,
     },
     StoredContractByName {
         name: String,
         entry_point: String,
         #[serde(with = "HexForm::<Vec<u8>>")]
         args: Vec<u8>,
     },
     StoredVersionedContractByHash {
         #[serde(with = "HexForm::<[u8; KEY_HASH_LENGTH]>")]
         hash: ContractPackageHash,
         version: Option<ContractVersion>, // defaults to highest enabled version
         entry_point: String,
         #[serde(with = "HexForm::<Vec<u8>>")]
         args: Vec<u8>,
     },
     StoredVersionedContractByName {
         name: String,
         version: Option<ContractVersion>, // defaults to highest enabled version
         entry_point: String,
         #[serde(with = "HexForm::<Vec<u8>>")]
         args: Vec<u8>,
     },
 //https://testnet.cspr.live/deploy/A70B7BB957f152D289BaE4fDcC9154AB563359059B4EE232D6Ec43AA3Da509DA
 //https://testnet.cspr.live/deploy/A34c93dd34dD9A6E8580BE0120F9413556b9B7CDB4EF56f4b110e56b659bc7d4
 //https://testnet.cspr.live/deploy/063799dc8BBC6469790a8a6C0aa9a536C2012979fA53A4FF88769F2bc8b21A05
     Transfer {
         #[serde(with = "HexForm::<Vec<u8>>")]
         args: Vec<u8>,
     },
 }
 */

public class DeployArgs {
    public var clType:CLType = .BOOL;//PublicKey, u256,u512,
    public var parse:String="";//can be list, string, object - key, URef - is the value of clType
    public var bytes:String = "";
    //000B4AC8b9Aa02A5E3B7f6f95641152b3Fc5a05e88b6469fAa22107f824b7bE3bE - can be very long string -
    //the serialization of clType and parse (value of clType)
    //very long string
    public var argsDesc:String = "";//amount_out_min,path,amount_in,delegator,validators,validator_public_key
}

public class DeployExecutionResult {
    public var blockHash:String = "";//528c63a9e30bf6e52b9d38f7c1a3e2ec035a54bfb29225d31ecedff00eebbe18 - block_hash
    
}
public class DeployExecutionResults {
    public var executionResults:[DeployExecutionResult] = [DeployExecutionResult] ();
}
