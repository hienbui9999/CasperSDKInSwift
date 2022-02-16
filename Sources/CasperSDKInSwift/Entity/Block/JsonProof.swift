import Foundation

/**
 Class represents the JsonProof
 */
public class JsonProof {
    
    public var publicKey:PublicKey = PublicKey();
    public var signature:String = "";
    
    /**
       Get JsonProof  object  list from Json string
       - Parameter : a Json String represents the JsonProof object list
       - Returns: JsonProof object list
       */

    public static func getJsonProofs(jsonProofs:[AnyObject])->[JsonProof] {
        var listJsonProof:[JsonProof]  = [JsonProof]();
        for jsonProof  in jsonProofs {
            let oneProof:JsonProof = JsonProof.getJsonProof(from: jsonProof as! [String:Any])
            listJsonProof.append(oneProof);
        }
        return listJsonProof
    }
    /**
       Get JsonProof  object  from Json string
       - Parameter : a Json String represents the JsonProof object
       - Returns: JsonProof object 
       */
    public static func getJsonProof(from:[String:Any])->JsonProof {
        let oneProof:JsonProof = JsonProof();
        if let publicKey = from["public_key"] as? String {
            oneProof.publicKey = PublicKey.strToPublicKey(from: publicKey);
        }
        if let signature = from["signature"] as? String {
            oneProof.signature = signature;
        }
        return oneProof;
    }
}
