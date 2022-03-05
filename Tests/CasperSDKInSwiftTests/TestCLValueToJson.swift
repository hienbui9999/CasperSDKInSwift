import XCTest
@testable import CasperSDKInSwift
public class TestCLValueToJson : XCTestCase {
    func testAll() {
        //test for bool to json
           let clValueBool:CLValue = CLValue();
           clValueBool.cl_type = .Bool
           clValueBool.parsed = .Bool(true)
           clValueBool.bytes = "01"
           do {
               let jsonBool = try CLValueToJson.toJsonObj(clValue: clValueBool)
               //expect {"bytes":"01","parsed":true,"cl_type":"Bool"}
               NSLog("jsonBool:\(jsonBool)")
           } catch {
               
           }
        //test for I32
        let clValueI32:CLValue = CLValue()
        clValueI32.cl_type = .I32
        clValueI32.parsed = .I32(1000)
        clValueI32.bytes = "e8030000"
        do {
            let jsonI32 = try CLValueToJson.toJsonObj(clValue: clValueI32)
            NSLog("jsonI32:\(jsonI32)")
        } catch {
            
        }
        //test for I64
        let clValueI64:CLValue = CLValue()
        clValueI64.cl_type = .I32
        clValueI64.parsed = .I32(-1024)
        clValueI64.bytes = "00fcffffffffffff"
        do {
            let jsonI64 = try CLValueToJson.toJsonObj(clValue: clValueI64)
            NSLog("jsonI64:\(jsonI64)")
        } catch {
            
        }
        
        //test for U8
        let clValueU8:CLValue = CLValue()
        clValueU8.cl_type = .U8
        clValueU8.parsed = .U8(197)
        clValueU8.bytes = "c5"
        do {
            let jsonU8 = try CLValueToJson.toJsonObj(clValue: clValueU8)
            NSLog("jsonU8:\(jsonU8)")
        } catch {
            
        }
        //test for U32
        let clValueU32:CLValue = CLValue()
        clValueU32.cl_type = .U32
        clValueU32.parsed = .U32(5531024)
        clValueU32.bytes = "90655400"
        do {
            let jsonU32 = try CLValueToJson.toJsonObj(clValue: clValueU32)
            NSLog("jsonU32:\(jsonU32)")
        } catch {
            
        }
        //test for U64
        let clValueU64:CLValue = CLValue()
        clValueU64.cl_type = .U64
        clValueU64.parsed = .U64(33009900995531024)
        clValueU64.bytes = "10d1e87e54467500"
        do {
            let jsonU64 = try CLValueToJson.toJsonObj(clValue: clValueU64)
            NSLog("jsonU64:\(jsonU64)")
        } catch {
            
        }
        //U128
        let clValueU128:CLValue = CLValue();
        clValueU128.bytes = "0957ff1ada959f4eb106";
        clValueU128.parsed = .U128(U128Class.fromStringToU128(from: "123456789101112131415"))
        clValueU128.cl_type = .U128
        do {
            let jsonU128 = try CLValueToJson.toJsonObj(clValue: clValueU128)
            NSLog("jsonU128\(jsonU128)")
        } catch {
            
        }
        //U256
        let clValueU256:CLValue = CLValue();
        clValueU256.bytes = "020008";
        clValueU256.parsed = .U256(U256Class.fromStringToU256(from: "2048"))
        clValueU256.cl_type = .U256
        do {
            let jsonU256 = try CLValueToJson.toJsonObj(clValue: clValueU256)
            NSLog("jsonU256\(jsonU256)")
        } catch {
            
        }
       //U512
       let clValueU512:CLValue = CLValue();
       clValueU512.bytes = "04005ed0b2";
       clValueU512.parsed = .U512(U512Class.fromStringToU512(from: "3000000000"))
       clValueU512.cl_type = .U512
       do {
           let jsonU512 = try CLValueToJson.toJsonObj(clValue: clValueU512)
           NSLog("jsonU512\(jsonU512)")
       } catch {
           
       }
        //String
        let clValueString:CLValue = CLValue();
        clValueString.bytes = "07000000454e474c495348";
        clValueString.parsed = .String("ENGLISH")
        clValueString.cl_type = .String
        do {
            let jsonString = try CLValueToJson.toJsonObj(clValue: clValueString)
            NSLog("jsonString:\(jsonString)")
        } catch {
            
        }
        //PublicKey
        let clValuePublicKey:CLValue = CLValue();
        clValuePublicKey.bytes = "01394476bd8202887ac0e42ae9d8f96d7e02d81cc204533506f1fd199e95b1fd2b";
        clValuePublicKey.parsed = .PublicKey("01394476bd8202887ac0e42ae9d8f96d7e02d81cc204533506f1fd199e95b1fd2b")
        clValuePublicKey.cl_type = .PublicKey
        do {
            let jsonPublicKey = try CLValueToJson.toJsonObj(clValue: clValuePublicKey)
            NSLog("jsonPublicKey:\(jsonPublicKey)")
        } catch {
            
        }
        //URef
        let clValueURef:CLValue = CLValue();
        clValueURef.bytes = "be1dc0fd639a3255c1e3e5e2aa699df66171e40fa9450688c5d718b470e057c607";
        clValueURef.parsed = .URef("uref-be1dc0fd639a3255c1e3e5e2aa699df66171e40fa9450688c5d718b470e057c6-007")
        clValueURef.cl_type = .URef
        do {
            let jsonURef = try CLValueToJson.toJsonObj(clValue: clValueURef)
            NSLog("jsonURef:\(jsonURef)")
        } catch {
            
        }
        //Key Uref
        let clValueKey:CLValue = CLValue();
        clValueKey.bytes = "be1dc0fd639a3255c1e3e5e2aa699df66171e40fa9450688c5d718b470e057c6";
        clValueKey.parsed = .Key("uref-be1dc0fd639a3255c1e3e5e2aa699df66171e40fa9450688c5d718b470e057c6-007")
        clValueKey.cl_type = .Key
        do {
            let jsonKey = try CLValueToJson.toJsonObj(clValue: clValueKey)
            NSLog("jsonKey URef:\(jsonKey)")
        } catch {
            
        }
        
        //Key Account
        let clValueKeyAccount:CLValue = CLValue();
        clValueKeyAccount.bytes = "be1dc0fd639a3255c1e3e5e2aa699df66171e40fa9450688c5d718b470e057c6";
        clValueKeyAccount.parsed = .Key("account-hash-d0bc9cA1353597c4004B8F881b397a89c1779004F5E547e04b57c2e7967c6269")
        clValueKeyAccount.cl_type = .Key
        do {
            let jsonKeyAccount = try CLValueToJson.toJsonObj(clValue: clValueKeyAccount)
            NSLog("jsonKey Account :\(jsonKeyAccount)")
        } catch {
            
        }
        //Key Hash
        let clValueKeyHash:CLValue = CLValue();
        clValueKeyHash.bytes = "be1dc0fd639a3255c1e3e5e2aa699df66171e40fa9450688c5d718b470e057c6";
        clValueKeyHash.parsed = .Key("hash-f79455dd5fed17672e18f7c38f654ce2e2dc659f20d9ddab22a1097ebe3ba281")
        clValueKeyHash.cl_type = .Key
        do {
            let jsonKeyHash = try CLValueToJson.toJsonObj(clValue: clValueKeyHash)
            NSLog("jsonKey Hash:\(jsonKeyHash)")
        } catch {
            
        }
        //Option NULL
        let clValueOption:CLValue = CLValue();
        clValueOption.bytes =  "00"
        clValueOption.parsed = .NULL
        clValueOption.cl_type = .Option(.U64)
        do {
            let jsonOptionNull = try CLValueToJson.toJsonObj(clValue: clValueOption)
            NSLog("jsonOption Null:\(jsonOptionNull)")
        } catch {
            
        }
        
        //Option String
        let clValueOptionString:CLValue = CLValue();
        clValueOptionString.bytes =  "0103000000616263"
        clValueOptionString.parsed = .OptionWrapper(.String("abc"))
        clValueOptionString.cl_type = .Option(.String)
        do {
            let jsonOptionString = try CLValueToJson.toJsonObj(clValue: clValueOptionString)
            NSLog("jsonOption String:\(jsonOptionString)")
        } catch {
            
        }
        //Option U8
        let clValueOptionU8:CLValue = CLValue();
        clValueOptionU8.bytes =  "01c5"
        clValueOptionU8.parsed = .OptionWrapper(.U8(197))
        clValueOptionU8.cl_type = .Option(.U8)
        do {
            let jsonOptionU8 = try CLValueToJson.toJsonObj(clValue: clValueOptionU8)
            NSLog("jsonOption U8:\(jsonOptionU8)")
        } catch {
            
        }
        //Option U32
        let clValueOptionU32:CLValue = CLValue();
        clValueOptionU32.bytes =  "0190655400"
        clValueOptionU32.parsed = .OptionWrapper(.U32(5531024))
        clValueOptionU32.cl_type = .Option(.U32)
        do {
            let jsonOptionU32 = try CLValueToJson.toJsonObj(clValue: clValueOptionU32)
            NSLog("jsonOption U8:\(jsonOptionU32)")
        } catch {
            
        }
        //Option U128
        let clValueOptionU128:CLValue = CLValue();
        clValueOptionU128.bytes =  "01020004"
        clValueOptionU128.parsed = .OptionWrapper(.U128(U128Class.fromStringToU128(from: "1024")))
        clValueOptionU128.cl_type = .Option(.U128)
        do {
            let jsonOptionU128 = try CLValueToJson.toJsonObj(clValue: clValueOptionU128)
            NSLog("jsonOption U128:\(jsonOptionU128)")
        } catch {
            
        }
      //  NSLog("Done")
        //List of String
        /*let clValueListString:CLValue = CLValue();
        clValueListString.bytes = "020000001800000036316566663535363666353538363063393664353164396503000000616263"
        clValueListString.cl_type = .List(.String)
        clValueListString.parsed = .ListWrapper([.String("61eff5566f55860c96d51d9e"),.String("abc")])
        do {
            let jsonListString = try CLValueToJson.toJsonObj(clValue: clValueListString)
            NSLog("jsonOption List:\(jsonListString)")
        } catch {
            
        }*/
    }
}
