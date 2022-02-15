import Foundation
/**
 Class for Deploy serialization
 */
public class DeploySerialization {
    /**
     Serialize for Deploy
     - Parameter : a deploy object
     - Returns: String represent the serialization of the deploy of the input, with the rule of making serialization like this:
     deployHeader.Serialization + hash + payment.Serialization + session.Serialization + approvals.Serialization
     */
    public static func serialize(fromDeploy:Deploy)->String {
        var retStr:String = ""
        retStr = DeployHeaderSerialization.serialize(from: fromDeploy.header)
        retStr = retStr + fromDeploy.hash
        retStr = retStr + ExecutableDeployItemSerializaton.serialize(from: fromDeploy.payment!)
        retStr = retStr + ExecutableDeployItemSerializaton.serialize(from: fromDeploy.session!)
        retStr = retStr + DeployApprovalSerialization.serialize(from: fromDeploy.approvals)
        return retStr
    }
}
/**
 class for Deploy Header  serialization
 */
public class DeployHeaderSerialization {
    /**
     Serialize for DeployHeader
     - Parameter : a deploy header object
     - Returns: String represent the serialization of the deploy header
     */
    public static func serialize(from:DeployHeader) -> String {
        var retStr =  from.account +  CLTypeSerializeHelper.UInt64Serialize(input:Utils.dateStrToMilisecond(dateStr:from.timestamp)) + CLTypeSerializeHelper.UInt64Serialize(input: Utils.ttlToMilisecond(ttl: from.ttl)) + CLTypeSerializeHelper.UInt64Serialize(input: from.gas_price) + from.body_hash
        var depStr = CLTypeSerializeHelper.UInt32Serialize(input: UInt32(from.dependencies.count))
        if from.dependencies.count > 0 {
            for element in from.dependencies {
                depStr =  depStr + element
            }
        }
        retStr = retStr + depStr
        let chainSerialization = CLTypeSerializeHelper.StringSerialize(input: from.chain_name)
        retStr = retStr + chainSerialization
        return retStr
    }
}
/**
 class for ExecutableDeployItem  serialization
 */
public class ExecutableDeployItemSerializaton {
    /**
     Serialize for NamedArg list
     - Parameter : NamedArg list
     - Returns: String represent the serialization of the NamedArg list
     */
    public static func NameArgListSerialize(from:[NamedArg])->String {
        //if the args list is empty then just return the U32Serialize(0), which is 00000000
        if from.count == 0 {
            return "00000000"
        }
        let size = UInt32(from.count)
        // concatenate each arg item in the args list
        var argStr:String = CLTypeSerializeHelper.UInt32Serialize(input: size)
        for nameArg in from {
            argStr = argStr + CLTypeSerializeHelper.StringSerialize(input: nameArg.name)
            do {
                let clValueSerialize = try CLTypeSerializeHelper.CLValueSerialize(input: nameArg.argsItem.parsed)
                let clValueSerializeSize = UInt32(clValueSerialize.count/2)
                argStr = argStr + CLTypeSerializeHelper.UInt32Serialize(input: clValueSerializeSize)  + clValueSerialize
                argStr = argStr + CLTypeSerializeHelper.CLTypeSerialize(input: nameArg.argsItem.cl_type)
            } catch {
                NSLog("Error serialize NameArgs \(error)")
            }
        }
        return argStr
    }
    /**
     Serialize for ExecutableDeployItem
     - Parameter : ExecutableDeployItem object
     - Returns: String represent the serialization of the ExecutableDeployItem
     */
    public static func serialize(from:ExecutableDeployItem)->String {
        switch from {
        case .ModuleBytes(let module_bytes, let args):
            var ret:String = ""
            if module_bytes.value == "" {
                ret = CLTypeSerializeHelper.UInt32Serialize(input: 0)
            } else {
                let module_bytesLength = UInt32(module_bytes.value.count)
                ret = "00" +  CLTypeSerializeHelper.StringSerialize(input: module_bytes.value)
            }
            let argStr = ExecutableDeployItemSerializaton.NameArgListSerialize(from: args.listNamedArg)
            ret = ret + argStr
            return ret
        case .StoredContractByHash(let hash, let entry_point, let args):
            var ret:String = "01"
            ret = ret + hash
            ret = ret + CLTypeSerializeHelper.StringSerialize(input: entry_point)
            ret = ret + ExecutableDeployItemSerializaton.NameArgListSerialize(from: args.listNamedArg)
            return ret
        case .StoredContractByName(let name, let entry_point, let args):
            var ret: String = "02"
            ret = ret + CLTypeSerializeHelper.StringSerialize(input: name)
            ret = ret + CLTypeSerializeHelper.StringSerialize(input: entry_point)
            ret = ret + ExecutableDeployItemSerializaton.NameArgListSerialize(from: args.listNamedArg)
            return ret
        case .StoredVersionedContractByHash(let hash, let version, let entry_point, let args):
            var ret : String = "03"
            ret = ret + hash
            if let realVersion = version {//version with value # NONE
                ret = ret + "01" + CLTypeSerializeHelper.UInt32Serialize(input: realVersion)
            } else {//version with value NONE
                ret = ret + "00"
            }
            ret = ret + CLTypeSerializeHelper.StringSerialize(input: entry_point)
            ret = ret + ExecutableDeployItemSerializaton.NameArgListSerialize(from: args.listNamedArg)
            return ret
        case .StoredVersionedContractByName(let name, let version, let entry_point, let args):
            var ret : String = "04"
            ret = ret + CLTypeSerializeHelper.StringSerialize(input: name)
            if let realVersion = version {
                ret = ret + "01" + CLTypeSerializeHelper.UInt32Serialize(input: realVersion)
            } else {
                ret = ret + "00"
            }
            ret = ret + CLTypeSerializeHelper.StringSerialize(input: entry_point)
            ret = ret + ExecutableDeployItemSerializaton.NameArgListSerialize(from: args.listNamedArg)
            
            return ret
        case .Transfer(let args):
            return "05" + ExecutableDeployItemSerializaton.NameArgListSerialize(from: args.listNamedArg)
        case .NONE:
            return "-1"
        }
    }
}
/**
 Class for Approval serialization
 */

public class DeployApprovalSerialization {
    /**
     Serialize for DeployApprovalItem list
     - Parameter : DeployApprovalItem list
     - Returns: String represent the serialization of the DeployApprovalItem list
     */
    public static func serialize(from:[DeployApprovalItem])->String {
        let totalApproval = from.count
        if totalApproval == 0 {
            return "00000000"
        }
        var retStr = CLTypeSerializeHelper.UInt32Serialize(input: UInt32(totalApproval))
        for element in from {
            retStr = retStr + element.signer + element.signature
        }
        return retStr
    }
}
