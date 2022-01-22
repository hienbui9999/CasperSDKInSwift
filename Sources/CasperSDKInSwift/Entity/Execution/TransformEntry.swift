import Foundation

public class TransformEntry {
    public var key:String = "";
    public var transform:Transform = .NONE;
    public static func getTransformEntry(from:[String:Any])->TransformEntry {
        let transformEntry:TransformEntry = TransformEntry();
        if let key = from["key"] as? String {
            transformEntry.key = key;
        }
        transformEntry.transform = TransformHelper.getTransform(from: from);
        return transformEntry;
    }
}
