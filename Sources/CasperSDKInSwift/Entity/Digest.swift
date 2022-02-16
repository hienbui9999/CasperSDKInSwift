import Foundation
/**
 Class represents the Digest
 */

public class Digest {
    public var value:String=""
    
    /**
       Get Digest object from  string
       - Parameter : a  String represents the Digest object
       - Returns: Digest object
       */

    public static func fromStrToDigest(from:String)->Digest {
        let digest:Digest = Digest();
        digest.value = from;
        return digest;
    }
}
