import Foundation

class Utils {
    public static var deployGotLittle:Bool = false
    public static func getListDeploy()->[String] {
        let file = "file.txt"
        var retStr:[String] = [String]()
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(file)
            do {
                    let text2 = try String(contentsOf: fileURL, encoding: .utf8)
                    let elements = text2.components(separatedBy: "https://testnet.cspr.live/deploy/")
                    var counter:Int = 0;
                    var str = ""
                    for element in elements {
                        let e2 = element.components(separatedBy: "\">")
                        if e2.count > 0 {
                            counter += 1
                            if counter > 1 {
                                retStr.append(e2[0])
                            }
                        }
                    }
                return retStr
                }
                catch {
                   NSLog("Error reading file :\(error)")
                }
        }
        return retStr
    }
}
extension String {
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.utf16.count
        } else {
            return false
        }
    }
}
