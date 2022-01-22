import Foundation
public class Digest {
    public var value:String=""
    public static func fromStrToDigest(from:String)->Digest {
        let digest:Digest = Digest();
        digest.value = from;
        return digest;
    }
}
