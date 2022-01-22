import Foundation

public class JsonProof {
    
    public var publicKey:PublicKey = PublicKey();
    public var signature:String = "";
    
    public static func getJsonProofs(jsonProofs:[AnyObject])->[JsonProof] {
        var listJsonProof:[JsonProof]  = [JsonProof]();
        for jsonProof  in jsonProofs {
            let oneProof:JsonProof = JsonProof.getJsonProof(from: jsonProof as! [String:Any])
            listJsonProof.append(oneProof);
        }
        return listJsonProof
    }
    
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
