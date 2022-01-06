//
//  File.swift
//  
//
//  Created by Hien on 05/01/2022.
//

import Foundation
class DeployUtils {
    /*
     get object in this structure
     public class DeployArgItem {
         public var bytes:String = "";// serialization of parsed
         public var clTypeWarper:AnyObject?;//among the CLType
         public var parsed:AnyObject?;//CLType value
         public var clType:CLType?;//real CLType enum
         public func printMe() {
             print("byte:\(bytes), clType:\(clType),parse:\(parsed), clTypeWrapper:\(clTypeWarper)")
         }
     }
     sample value
     WriteCLValue =     {
         bytes = 00;
         "cl_type" = U512;
         parsed = 0;
     };
     */
    public func getDeployArgItem(from:AnyObject)->DeployArgItem {
        let retDeployArgItem : DeployArgItem = DeployArgItem();
        
        return retDeployArgItem;
    }
}
