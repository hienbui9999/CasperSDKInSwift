import Foundation

public class JsonEraValidators {
    public var era_id:UInt64=0
    public var validator_weights:[ValidatorWeight] = [ValidatorWeight]()
    public static func fromJsonToEraValidator(from:[String:Any])->JsonEraValidators {
        let ret : JsonEraValidators = JsonEraValidators();
        if let from1 = from as? [String:Any] {
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
