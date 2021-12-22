//
//  GetDictionaryItemParams.swift
//  SampleRPCCall1
//
//  Created by Hien on 11/12/2021.
//

import Foundation
struct Digest {
    
}

class GetDictionaryItemParams {
    var state_root_hash: Digest = Digest();
    var dictionary_identifier: DictionaryIdentifier = .Dictionary;
}
