import XCTest
@testable import CasperSDKInSwift
final class TestSerialization: XCTestCase {
    func testAll() throws {
        do {
            //Serialization test
            
            //test for bool
            var bool_true:String = CLTypeSerializeHelper.BoolSerialize(input: true)
            var bool_false:String = CLTypeSerializeHelper.BoolSerialize(input: false)
            XCTAssert(bool_true == "01")
            XCTAssert(bool_false == "00")
            
            //test for u8
            var u8_1:String = CLTypeSerializeHelper.UInt8Serialize(input: 197)
            var u8_2:String = CLTypeSerializeHelper.UInt8Serialize(input: 7)
            var u8_3:String = CLTypeSerializeHelper.UInt8Serialize(input: 0)
            XCTAssert(u8_1 == "c5")
            XCTAssert(u8_2 == "07")
            XCTAssert(u8_3 == "00")
            
            //test for i32
            let i32_1:String = CLTypeSerializeHelper.Int32Serialize(input: -1024)
            let i32_2:String = CLTypeSerializeHelper.Int32Serialize(input: 1000)
            let i32_3:String = CLTypeSerializeHelper.Int32Serialize(input: 0)
            XCTAssert(i32_1=="00fcffff")
            XCTAssert(i32_2=="e8030000")
            XCTAssert(i32_3=="00000000")

            //test for i64
            let i64_1:String = CLTypeSerializeHelper.Int64Serialize(input: -1024)
            let i64_2:String = CLTypeSerializeHelper.Int64Serialize(input: 1000)
            let i64_3:String = CLTypeSerializeHelper.Int64Serialize(input: 0)
            XCTAssert(i64_1=="00fcffffffffffff")
            XCTAssert(i64_2=="e803000000000000")
            XCTAssert(i64_3=="0000000000000000")
            
            //test for u32
            let u32_1:String = CLTypeSerializeHelper.UInt32Serialize(input: 1024)
            let u32_2:String = CLTypeSerializeHelper.UInt32Serialize(input: 5531024)
            let u32_3:String = CLTypeSerializeHelper.UInt32Serialize(input: 0)
            XCTAssert(u32_1 == "00040000")
            XCTAssert(u32_2 == "90655400")
            XCTAssert(u32_3 == "00000000")
            
            //test for u64
            let u64_1:String = CLTypeSerializeHelper.UInt64Serialize(input: 1024)
            let u64_2:String = CLTypeSerializeHelper.UInt64Serialize(input: 33009900995531024)
            let u64_3:String = CLTypeSerializeHelper.UInt64Serialize(input: 0)
            XCTAssert(u64_1 == "0004000000000000")
            XCTAssert(u64_2 == "10d1e87e54467500")
            XCTAssert(u64_3 == "0000000000000000")
            
            //test for u128
            let u128_1 =  try CLTypeSerializeHelper.U128Serialize(input:"123456789101112131415")
            let u128_2 =  try CLTypeSerializeHelper.U128Serialize(input:"1024")
            let u128_3 =  try CLTypeSerializeHelper.U128Serialize(input:"0")
            XCTAssert(u128_1 == "0957ff1ada959f4eb106")
            XCTAssert(u128_2 == "020004")
            XCTAssert(u128_3 == "0100")
            
            //test for u256
            let u256_1 =  try CLTypeSerializeHelper.U256Serialize(input:"999988887777666655556666777888999")
            let u256_2 =  try CLTypeSerializeHelper.U256Serialize(input:"2048")
            let u256_3 =  try CLTypeSerializeHelper.U256Serialize(input:"0")
            XCTAssert(u256_1 == "0ee76837d2ca215879f7bc5ca24d31")
            XCTAssert(u256_2 == "020008")
            XCTAssert(u256_3 == "0100")
            
            //test for u512
            let u512_1 =  try CLTypeSerializeHelper.U512Serialize(input:"999888666555444999887988887777666655556666777888999666999")
            let u512_2 =  try CLTypeSerializeHelper.U512Serialize(input:"4096")
            let u512_3 =  try CLTypeSerializeHelper.U512Serialize(input:"0")
            let u512_4 =  try CLTypeSerializeHelper.U512Serialize(input: "100000000")
            XCTAssert(u512_1 == "1837f578fca55492f299ea354eaca52b6e9de47d592453c728")
            XCTAssert(u512_2 == "020010")
            XCTAssert(u512_3 == "0100")
            XCTAssert(u512_4 == "0400e1f505")
            
            //test for string
            let str:String = "Hello, World!"
            let strSerialize = CLTypeSerializeHelper.StringSerialize(input: "Hello, World!")
            XCTAssert(strSerialize == "0d00000048656c6c6f2c20576f726c6421")
            let str2:String = "lWJWKdZUEudSakJzw1tn"
            let strSerialize2 = CLTypeSerializeHelper.StringSerialize(input: str2)
            XCTAssert(strSerialize2 == "140000006c574a574b645a5545756453616b4a7a7731746e")
            let str3:String = "S1cXRT3E1jyFlWBAIVQ8"
            let str3Serialize = CLTypeSerializeHelper.StringSerialize(input: str3)
            XCTAssert(str3Serialize == "140000005331635852543345316a79466c57424149565138")
            let str4:String = "123456789123456789123456789123456789123456789123456789"
            let str4Serialize = CLTypeSerializeHelper.StringSerialize(input: str4)
            XCTAssert(str4Serialize=="36000000313233343536373839313233343536373839313233343536373839313233343536373839313233343536373839313233343536373839")
            //test for Unit
            let unit : CLValueWrapper = .Unit("")
            do {
                let unitSerialize = try CLTypeSerializeHelper.CLValueSerialize(input: unit)
                XCTAssert(unitSerialize=="")
            } catch {
                throw CasperError.invalidNumber
            }
            //test for Key
            //1. Account Hash
            let key1 : CLValueWrapper = .Key("account-hash-d0bc9cA1353597c4004B8F881b397a89c1779004F5E547e04b57c2e7967c6269")
            do {
                let keySerialize = try CLTypeSerializeHelper.CLValueSerialize(input: key1)
                print("keySerialize:\(keySerialize)")
                XCTAssert(keySerialize == "00d0bc9cA1353597c4004B8F881b397a89c1779004F5E547e04b57c2e7967c6269")
            } catch {
                throw CasperError.invalidNumber
            }
            //test for URef
            //test for PublicKey
            //test for Option
            //test for List
            //test for ByteArray
            let ba:CLValueWrapper = .BytesArray("006d0be2fb64bcc8d170443fbadc885378fdd1c71975e2ddd349281dd9cc59cc")
            do {
                let baSerialize = try CLTypeSerializeHelper.CLValueSerialize(input: ba, withPrefix0x: false)
                XCTAssert(baSerialize == "006d0be2fb64bcc8d170443fbadc885378fdd1c71975e2ddd349281dd9cc59cc")
            } catch {
                throw CasperError.invalidNumber
            }
            //test for Result
            //test for Tuple1
            //test for Tuple2
            //test for Tuple3
            
        } catch {
            
        }
    }
}
