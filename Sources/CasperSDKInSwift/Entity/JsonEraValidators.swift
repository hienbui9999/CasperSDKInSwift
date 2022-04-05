import Foundation
/**
 Class represents the JsonEraValidators
 */

public class JsonEraValidators {
    /// Era id
    public var eraId: UInt64=0
    /// List of Validator weight
    public var validatorWeights: [ValidatorWeight] = [ValidatorWeight]()
    /**
        Get JsonEraValidators object from Json string
        - Parameter: a Json String represents the JsonEraValidators object
        - Returns: JsonEraValidators object
        */

    public static func fromJsonToEraValidator(from: [String: Any]?) -> JsonEraValidators {
        let ret: JsonEraValidators = JsonEraValidators()
        if let from1 = from {
            if let eraId1 = from1["era_id"] as? UInt64 {
                ret.eraId = eraId1
            }
            var listVW: [ValidatorWeight] = [ValidatorWeight]()
            if let vws = from1["validator_weights"] as? [[String: Any]] {
                for vw in vws {
                    let oneVW: ValidatorWeight = ValidatorWeight()
                    if let weight = vw["weight"] as? String {
                        oneVW.weight = U512Class.fromStringToU512(from: weight)
                    }
                    if let publicKey1 = vw["public_key"] as? String {
                        oneVW.publicKey = PublicKey.strToPublicKey(from: publicKey1)
                    }
                    listVW.append(oneVW)
                }
                ret.validatorWeights = listVW
            }
        }
        return ret
    }

}
