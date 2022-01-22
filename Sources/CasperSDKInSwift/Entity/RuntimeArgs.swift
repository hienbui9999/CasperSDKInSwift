import Foundation
public class RuntimeArgs {
    public var listNamedArg:[NamedArg] = [NamedArg]()
    public static func fromListToRuntimeArgs(from:[NamedArg])->RuntimeArgs {
        let ret : RuntimeArgs = RuntimeArgs();
        for i in from {
            ret.listNamedArg.append(i)
        }
        return ret
    }
}
