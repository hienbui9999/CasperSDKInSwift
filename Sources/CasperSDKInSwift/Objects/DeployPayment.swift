//
//  File.swift
//  
//
//  Created by Hien on 29/12/2021.
//

import Foundation
/*public class DeployPaymentStoredContractByName {//3 items
    public var paymentArgs:[DeployPaymentArgs] = [DeployPaymentArgs]();
    public var entryPoint:String = "";//example-entry-point
    public var name:String = "";//casper-example
}
public class DeployPaymentArgs { //2 items
    public var args:[DeployArgItem] = [DeployArgItem]();
    public var quantity:String = "";//
}
public class DeployPayment {//4 items
    public var paymentStoredContractByName: DeployPaymentStoredContractByName = DeployPaymentStoredContractByName();
}*/

struct Person: Codable {
    var name: String
    var age: Int
    var album:[String]
    var visitedContry:[Country]
    var likeFood:LikeFood
    var parseType:ParseType
    
}
struct Country:Codable {
    var name:String
    var code:Int
}
enum LikeFood:String,Codable {
    case Potato = "Potato"
    case Tomato = "Tomato"
    case Cheese = "Cheese"
}
enum MeetingPerson : Codable {
    case OldMan(name:String,likeFood:LikeFood)
    case Child(name:String,country:Country)
}

enum ParseType:String,Codable {
    case U256 = "U256"
    case ByteArray = "ByteArray"
    case I32 = "I32"
}
class TestPaymen {
    public func testCallJson() {
        let jsonString = """
        [
            {
                "name": "Taylor Swift",
                "age": 26,
                "album":["Style","You belong to me","Disturbia"],
                "visitedContry":[{"name":"a","code":11}],
                "likeFood":"Potato",
                "parseType":100
               
            },
            {
                "name": "Justin Bieber",
                "age": 25,
                "album":["Beautiy","And the beast","Walk","Septimer"],
                "visitedContry":[{"name":"a","code":11},{"name":"b","code":12}],
                "likeFood":"Tomato",
                "parseType":"A ha ha"
                
            }
        ]
        """

        let jsonData = Data(jsonString.utf8)
        let decoder = JSONDecoder()

        do {
            let people = try decoder.decode([Person].self, from: jsonData)
            print(people)
        } catch {
            print(error.localizedDescription)
        }
    }
}
