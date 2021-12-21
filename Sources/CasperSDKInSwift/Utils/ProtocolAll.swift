//
//  ProtocolAll.swift
//  SampleRPCCall1
//
//  Created by Hien on 09/12/2021.
//

import Foundation
protocol RpcWithParams {
    
}
protocol RpcWithParamsExt{
    func handle_request()
}
protocol RpcWithoutParams {
    
}
protocol RpcWithoutParamsExt {
    func handle_request()
}
protocol RpcWithOptionalParams{
    
}
protocol RpcWithOptionalParamsExt {
    func handle_request() 
}
