import Foundation
/**
 Class represent the JsonBlock
 */
public class JsonBlock {
    ///
    public var hash:String = "";
    public var body:JsonBlockBody = JsonBlockBody();
    public var header:JsonBlockHeader = JsonBlockHeader();
    public var proofs: [JsonProof] = [JsonProof]();
}
