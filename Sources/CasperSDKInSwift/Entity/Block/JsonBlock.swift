import Foundation
/**
 Class represents the JsonBlock
 */
public class JsonBlock {
    /// Hash of json block
    public var hash: String = ""
    /// Body of json block - link to other class that hold more detail attributes
    public var body: JsonBlockBody = JsonBlockBody()
    /// Header of json block -  - link to other class that hold more detail attributes
    public var header: JsonBlockHeader = JsonBlockHeader()
    /// List of JsonProof objects
    public var proofs: [JsonProof] = [JsonProof]()
}
