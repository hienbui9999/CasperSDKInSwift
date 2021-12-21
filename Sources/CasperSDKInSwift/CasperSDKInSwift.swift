public struct CasperSDKInSwift {
    //public private(set) var text = "Hello, World!"

    public init() {
    }
    public func getStateRootHash() {
        let getState:GetStateRootHash = GetStateRootHash();
        getState.handle_request();
    }
}
