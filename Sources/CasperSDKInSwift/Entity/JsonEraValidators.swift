import Foundation
/**
 Class represents the JsonEraValidators
 */

public class JsonEraValidators {
    ///Era id
    public var era_id:UInt64=0
    ///List of Validator weight
    public var validator_weights:[ValidatorWeight] = [ValidatorWeight]()
    /**
        Get JsonEraValidators object from Json string
        - Parameter : a Json String represents the JsonEraValidators object
        - Returns: JsonEraValidators object
        */

    public static func fromJsonToEraValidator(from:[String:Any]?)->JsonEraValidators {
        let ret : JsonEraValidators = JsonEraValidators();
        if let from1 = from {
            if let era_id = from1["era_id"] as? UInt64 {
                ret.era_id = era_id
            }
            var listVW:[ValidatorWeight] = [ValidatorWeight]();
            if let vws = from1["validator_weights"] as? [[String:Any]] {
                for vw in vws {
                    let oneVW : ValidatorWeight = ValidatorWeight();
                    if let weight = vw["weight"] as? String {
                        oneVW.weight = U512Class.fromStringToU512(from: weight)
                    }
                    if let public_key = vw["public_key"] as? String {
                        oneVW.public_key = PublicKey.strToPublicKey(from: public_key)
                    }
                    listVW.append(oneVW)
                }
                ret.validator_weights = listVW
            }
        }
        return ret;
    }
}
