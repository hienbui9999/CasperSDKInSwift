import Foundation
/**
 Class represents the JsonBlockHeader
 */

public class JsonBlockHeader {
    public var parent_hash:String = "";
    public var state_root_hash:String = "";
    public var body_hash:String = "";
    public var random_bit:Bool = false;
    public var accumulated_seed:String = "";
    public var eraEnd:JsonEraEnd = JsonEraEnd();
    public var eraID:UInt64 = 0;
    public var height:UInt64 = 0;
    public var protocolVersion:ProtocolVersion = ProtocolVersion();
    public var timeStamp:String = "";
    /**
       Get JsonBlockHeader object from Json string
       - Parameter : a Json String represents the JsonBlockHeader object
       - Returns: JsonBlockHeader object
       */

    public static func getBlockHeader(from:[String:Any]) -> JsonBlockHeader {
        let getBlockHeader : JsonBlockHeader = JsonBlockHeader();
        if let accumulatedSeed = from["accumulated_seed"] as? String {
            getBlockHeader.accumulated_seed = accumulatedSeed;
        }
        if let bodyHash = from["body_hash"] as? String {
            getBlockHeader.body_hash = bodyHash;
        }
        if let eraId = from["era_id"] as? UInt64 {
            getBlockHeader.eraID = eraId;
        }
        if let Height = from["height"] as? UInt64 {
            getBlockHeader.height = Height;
        }
        if let parentHash = from["parent_hash"] as? String {
            getBlockHeader.parent_hash = parentHash
        }
        if let protocolVersion = from["protocol_version"] as? String {
            let pVersion:ProtocolVersion = ProtocolVersion();
            pVersion.setProtolString(str: protocolVersion)
            getBlockHeader.protocolVersion = pVersion;
        }
        if let randomBit = from["random_bit"] as? Bool {
            getBlockHeader.random_bit = randomBit;
        }
        if let stateRootHash = from["state_root_hash"] as? String {
            getBlockHeader.state_root_hash = stateRootHash;
        }
        if let timeStamp = from["timestamp"] as? String {
            getBlockHeader.timeStamp = timeStamp
        }
        if let eraEnd = from["era_end"] as? [String:Any] {
            let getEraEnd:JsonEraEnd = JsonEraEnd();
            getBlockHeader.eraEnd = getEraEnd;
            if let eraReport = eraEnd["era_report"] as? [String:Any] {
                let getEraReport:JsonEraReport = JsonEraReport();
                getEraEnd.era_report = getEraReport;
               
                if let equivocators = eraReport["equivocators"] as? [String] {
                    for equivocator in equivocators {
                        getEraReport.equivocators.append(PublicKey.strToPublicKey(from: equivocator))
                    }
                }
                
                if let inactiveValidators = eraReport["inactive_validators"] as? [String] {
                    for inactiveValidator in inactiveValidators {
                        getEraReport.inactiveValidators.append(PublicKey.strToPublicKey(from: inactiveValidator))
                    }
                }
               
                if let rewards = eraReport["rewards"] as? [AnyObject] {
                    let totalRewards = rewards.count;
                    for reward in rewards {
                        let rewardItem : Reward = Reward();
                        if let amount = reward["amount"] as? UInt64 {
                            rewardItem.amount = amount;
                        }
                        if let validator = reward["validator"] as? String {
                            rewardItem.validator = PublicKey.strToPublicKey(from: validator);
                        }
                        getEraReport.rewards.append(rewardItem);
                    }
                }
                
            }
            
            ///next_era_validator_weights
            if let nextEraValidatorWeights = eraEnd["next_era_validator_weights"] as? [AnyObject] {
                getEraEnd.next_era_validator_weights = [ValidatorWeight]();
                for nextEraValidatorWeight in nextEraValidatorWeights {
                    let oneVW:ValidatorWeight = ValidatorWeight();
                    if let validator = nextEraValidatorWeight["validator"] as? String {
                        oneVW.public_key = PublicKey.strToPublicKey(from: validator)
                    }
                    if let weight = nextEraValidatorWeight["weight"] as? String {
                        oneVW.weight = U512Class.fromStringToU512(from: weight)
                    }
                    getEraEnd.next_era_validator_weights.append(oneVW)
                }
            }
        }
        return getBlockHeader;
    }
}
