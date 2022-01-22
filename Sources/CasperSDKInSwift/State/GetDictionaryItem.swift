import Foundation

class GetDictionaryItem {
    public static func getDictionaryItem(from:[String:Any]) -> GetDictionaryItemResult{
        print("Get dictionary item from:\(from)")
        let ret:GetDictionaryItemResult = GetDictionaryItemResult();
        return ret;
    }
}
