import XCTest
@testable import CasperSDKInSwift
final class TestCLValueSerialization: XCTestCase {

    func testAll() throws {
        do {
            // Serialization test
            // test for bool
            let boolTrue: String = CLTypeSerializeHelper.boolSerialize(input: true)
            let boolFalse: String = CLTypeSerializeHelper.boolSerialize(input: false)
            XCTAssert(boolTrue == "01")
            XCTAssert(boolFalse == "00")
            // test for u8
            let u81: String = CLTypeSerializeHelper.uInt8Serialize(input: 197)
            let u82: String = CLTypeSerializeHelper.uInt8Serialize(input: 7)
            let u83: String = CLTypeSerializeHelper.uInt8Serialize(input: 0)
            XCTAssert(u81 == "c5")
            XCTAssert(u82 == "07")
            XCTAssert(u83 == "00")
            // test for i32
            let i321: String = CLTypeSerializeHelper.int32Serialize(input: -1024)
            let i322: String = CLTypeSerializeHelper.int32Serialize(input: 1000)
            let i323: String = CLTypeSerializeHelper.int32Serialize(input: 0)
            let i324: String = CLTypeSerializeHelper.int32Serialize(input: -12369)
            XCTAssert(i321=="00fcffff")
            XCTAssert(i322=="e8030000")
            XCTAssert(i323=="00000000")
            XCTAssert(i324 == "afcfffff")
            // test for i64
            let i641: String = CLTypeSerializeHelper.int64Serialize(input: -1024)
            let i642: String = CLTypeSerializeHelper.int64Serialize(input: 1000)
            let i643: String = CLTypeSerializeHelper.int64Serialize(input: 0)
            let i644: String = CLTypeSerializeHelper.int64Serialize(input: -123456789)
            let i645: String = CLTypeSerializeHelper.int64Serialize(input: -56789)
            let i646: String = CLTypeSerializeHelper.int64Serialize(input: 56789)
            XCTAssert(i641=="00fcffffffffffff")
            XCTAssert(i642=="e803000000000000")
            XCTAssert(i643=="0000000000000000")
            XCTAssert(i644=="eb32a4f8ffffffff")
            XCTAssert(i645=="2b22ffffffffffff")
            XCTAssert(i646=="d5dd000000000000")
            // test for u32
            let u321: String = CLTypeSerializeHelper.uInt32Serialize(input: 1024)
            let u322: String = CLTypeSerializeHelper.uInt32Serialize(input: 5531024)
            let u323: String = CLTypeSerializeHelper.uInt32Serialize(input: 0)
            let u324: String = CLTypeSerializeHelper.uInt32Serialize(input: 334455)
            let u325: String = CLTypeSerializeHelper.uInt32Serialize(input: 4099)
            XCTAssert(u321 == "00040000")
            XCTAssert(u322 == "90655400")
            XCTAssert(u323 == "00000000")
            XCTAssert(u324 == "771a0500")
            XCTAssert(u325 == "03100000")
            // test for u64
            let u641: String = CLTypeSerializeHelper.uInt64Serialize(input: 1024)
            let u642: String = CLTypeSerializeHelper.uInt64Serialize(input: 33009900995531024)
            let u643: String = CLTypeSerializeHelper.uInt64Serialize(input: 0)
            let u644: String = CLTypeSerializeHelper.uInt64Serialize(input: 300000)
            let u645: String = CLTypeSerializeHelper.uInt64Serialize(input: 123456789)
            XCTAssert(u641 == "0004000000000000")
            XCTAssert(u642 == "10d1e87e54467500")
            XCTAssert(u643 == "0000000000000000")
            XCTAssert(u644 == "e093040000000000")
            XCTAssert(u645 == "15cd5b0700000000")
            // test for u128
            let u1281 =  try CLTypeSerializeHelper.u128Serialize(input: "123456789101112131415")
            let u1282 =  try CLTypeSerializeHelper.u128Serialize(input: "1024")
            let u1283 =  try CLTypeSerializeHelper.u128Serialize(input: "0")
            XCTAssert(u1281 == "0957ff1ada959f4eb106")
            XCTAssert(u1282 == "020004")
            XCTAssert(u1283 == "00")
            // test for u256
            let u2561 =  try CLTypeSerializeHelper.u256Serialize(input: "999988887777666655556666777888999")
            let u2562 =  try CLTypeSerializeHelper.u256Serialize(input: "2048")
            let u2563 =  try CLTypeSerializeHelper.u256Serialize(input: "0")
            XCTAssert(u2561 == "0ee76837d2ca215879f7bc5ca24d31")
            XCTAssert(u2562 == "020008")
            XCTAssert(u2563 == "00")
            // test for u512
            let u5121 =  try CLTypeSerializeHelper.u512Serialize(input: "999888666555444999887988887777666655556666777888999666999")
            let u5122 =  try CLTypeSerializeHelper.u512Serialize(input: "4096")
            let u5123 =  try CLTypeSerializeHelper.u512Serialize(input: "0")
            let u5124 =  try CLTypeSerializeHelper.u512Serialize(input: "100000000")
            XCTAssert(u5121 == "1837f578fca55492f299ea354eaca52b6e9de47d592453c728")
            XCTAssert(u5122 == "020010")
            XCTAssert(u5123 == "00")
            XCTAssert(u5124 == "0400e1f505")
            // test for string
            let str: String = "Hello, World!"
            let strSerialize = CLTypeSerializeHelper.stringSerialize(input: str)
            XCTAssert(strSerialize == "0d00000048656c6c6f2c20576f726c6421")
            let str2: String = "lWJWKdZUEudSakJzw1tn"
            let strSerialize2 = CLTypeSerializeHelper.stringSerialize(input: str2)
            XCTAssert(strSerialize2 == "140000006c574a574b645a5545756453616b4a7a7731746e")
            let str3: String = "S1cXRT3E1jyFlWBAIVQ8"
            let str3Serialize = CLTypeSerializeHelper.stringSerialize(input: str3)
            XCTAssert(str3Serialize == "140000005331635852543345316a79466c57424149565138")
            let str4: String = "123456789123456789123456789123456789123456789123456789"
            let str4Serialize = CLTypeSerializeHelper.stringSerialize(input: str4)
            XCTAssert(str4Serialize=="36000000313233343536373839313233343536373839313233343536373839313233343536373839313233343536373839313233343536373839")
            let str5: String = "target"
            let str5Serialize = CLTypeSerializeHelper.stringSerialize(input: str5)
           XCTAssert(str5Serialize=="06000000746172676574")
            // test for Unit
            let unit: CLValueWrapper = .unit("")
            let unitSerialize = try CLTypeSerializeHelper.CLValueSerialize(input: unit)
            XCTAssert(unitSerialize=="")
            // test for Key
            // 1. Account Hash
            let key1: CLValueWrapper = .key("account-hash-d0bc9cA1353597c4004B8F881b397a89c1779004F5E547e04b57c2e7967c6269")
            // 2.Hash
            let key2: CLValueWrapper = .key("hash-8cf5e4acf51f54eb59291599187838dc3bc234089c46fc6ca8ad17e762ae4401")
            // 3.URef
            let key3: CLValueWrapper = .key("uref-be1dc0fd639a3255c1e3e5e2aa699df66171e40fa9450688c5d718b470e057c6-007")
            let key1Serialization = try CLTypeSerializeHelper.CLValueSerialize(input: key1)
            let key2Serialization = try CLTypeSerializeHelper.CLValueSerialize(input: key2)
            let key3Serialization = try CLTypeSerializeHelper.CLValueSerialize(input: key3)
            XCTAssert(key1Serialization == "00d0bc9cA1353597c4004B8F881b397a89c1779004F5E547e04b57c2e7967c6269")
            XCTAssert(key2Serialization == "018cf5e4acf51f54eb59291599187838dc3bc234089c46fc6ca8ad17e762ae4401")
            XCTAssert(key3Serialization == "02be1dc0fd639a3255c1e3e5e2aa699df66171e40fa9450688c5d718b470e057c607")
            // test for URef
            let uref: CLValueWrapper = .uRef("uref-be1dc0fd639a3255c1e3e5e2aa699df66171e40fa9450688c5d718b470e057c6-007")
            let urefSerialization = try CLTypeSerializeHelper.CLValueSerialize(input: uref)
            XCTAssert(urefSerialization=="be1dc0fd639a3255c1e3e5e2aa699df66171e40fa9450688c5d718b470e057c607")
            // test for PublicKey
            let publicKey: CLValueWrapper = .publicKey("01394476bd8202887ac0e42ae9d8f96d7e02d81cc204533506f1fd199e95b1fd2b")
            let publicKeySerialization = try CLTypeSerializeHelper.CLValueSerialize(input: publicKey)
            XCTAssert(publicKeySerialization == "01394476bd8202887ac0e42ae9d8f96d7e02d81cc204533506f1fd199e95b1fd2b")
            // test for Option
            // Option None
            let optionNone: CLValueWrapper = .optionWrapper(.none)
            let optionNoneSerialization = try CLTypeSerializeHelper.CLValueSerialize(input: optionNone)
            XCTAssert(optionNoneSerialization=="00")
            // Option with value U32
            let option: CLValueWrapper = .optionWrapper(.u32(10))
            let optionSerialization = try CLTypeSerializeHelper.CLValueSerialize(input: option)
            XCTAssert(optionSerialization == "010a000000")
            // Option with value U64
            let option64: CLValueWrapper = .optionWrapper(.u64(123456))
            let optionSerialization64 = try CLTypeSerializeHelper.CLValueSerialize(input: option64)
            XCTAssert(optionSerialization64 == "0140e2010000000000")
            // Option with value String("Hello, World!")
            let optionString: CLValueWrapper = .optionWrapper(.string("Hello, World!"))
            let optionStringSerialization = try CLTypeSerializeHelper.CLValueSerialize(input: optionString)
            XCTAssert(optionStringSerialization == "010d00000048656c6c6f2c20576f726c6421")
            // test for List
            // List of 3 U32 numbers
            let item1: CLValueWrapper = .u32(1)
            let item2: CLValueWrapper = .u32(2)
            let item3: CLValueWrapper = .u32(3)
            let clValue: CLValueWrapper = .listWrapper([item1, item2, item3])
            let clValueSerialization = try CLTypeSerializeHelper.CLValueSerialize(input: clValue)
            XCTAssert(clValueSerialization=="03000000010000000200000003000000")
            // List of 3 String
            let listStr1: CLValueWrapper = .string("Hello, World!")
            let listStr2: CLValueWrapper = .string("Bonjour le monde")
            let listStr3: CLValueWrapper = .string("Hola Mundo")
            let clValueStringList: CLValueWrapper = .listWrapper([listStr1, listStr2, listStr3])
            let clStringListSerialization = try CLTypeSerializeHelper.CLValueSerialize(input: clValueStringList)
            XCTAssert(clStringListSerialization=="030000000d00000048656c6c6f2c20576f726c642110000000426f6e6a6f7572206c65206d6f6e64650a000000486f6c61204d756e646f")
            // Test for FixedList
            // FixedList of 3 U32 numbers
            let fitem1: CLValueWrapper = .u32(1)
            let fitem2: CLValueWrapper = .u32(2)
            let fitem3: CLValueWrapper = .u32(3)
            let fclValue: CLValueWrapper = .fixedListWrapper([fitem1, fitem2, fitem3])
            let fclValueSerialization = try CLTypeSerializeHelper.CLValueSerialize(input: fclValue)
            XCTAssert(fclValueSerialization=="010000000200000003000000")
            // FixedList of 3 String
            let flistStr1: CLValueWrapper = .string("Hello, World!")
            let flistStr2: CLValueWrapper = .string("Bonjour le monde")
            let flistStr3: CLValueWrapper = .string("Hola Mundo")
            let fclValueStringList: CLValueWrapper = .fixedListWrapper([flistStr1, flistStr2, flistStr3])
            let fclStringListSerialization = try CLTypeSerializeHelper.CLValueSerialize(input: fclValueStringList)
            XCTAssert(fclStringListSerialization=="0d00000048656c6c6f2c20576f726c642110000000426f6e6a6f7572206c65206d6f6e64650a000000486f6c61204d756e646f")
            // test for ByteArray
            let ba: CLValueWrapper = .bytesArray("006d0be2fb64bcc8d170443fbadc885378fdd1c71975e2ddd349281dd9cc59cc")
            let baSerialization = try CLTypeSerializeHelper.CLValueSerialize(input: ba)
            XCTAssert(baSerialization == "006d0be2fb64bcc8d170443fbadc885378fdd1c71975e2ddd349281dd9cc59cc")
            // test for Result
            // Result ok
            let resultCLValue: CLValueWrapper = .resultWrapper("Ok", .u64(314))
            let resultCLValueSerialization = try CLTypeSerializeHelper.CLValueSerialize(input: resultCLValue)
            XCTAssert(resultCLValueSerialization=="013a01000000000000")
            // Result err
            let resultErrCLValue: CLValueWrapper = .resultWrapper("Err", .string("Uh oh"))
            let resultCLValueErrSerialization = try CLTypeSerializeHelper.CLValueSerialize(input: resultErrCLValue)
            XCTAssert(resultCLValueErrSerialization=="00050000005568206f68")
            // test for map
            // test map of type (key, value) = (String, String)
            let keyArray: [CLValueWrapper] = [.string("event_type"), .string("recipient"), .string("token_id"), .string("contract_package_hash")]
            let valueArray: [CLValueWrapper] = [.string("cep47_mint_one"), .string("Key::Account(d0bc9ca1353597c4004b8f881b397a89c1779004f5e547e04b57c2e7967c6269)"), .string("2"), .string("a3b469a1e8b65b50e3c0c13e8f335de59203f7febe6ca41a95cdcb94c1c048e7")]
            let mapCLValue: CLValueWrapper = .mapWrapper(keyArray, valueArray)
            let mapSeriallizaion = try CLTypeSerializeHelper.CLValueSerialize(input: mapCLValue)
            XCTAssert(mapSeriallizaion == "0400000015000000636f6e74726163745f7061636b6167655f6861736840000000613362343639613165386236356235306533633063313365386633333564653539323033663766656265366361343161393563646362393463316330343865370a0000006576656e745f747970650e00000063657034375f6d696e745f6f6e6509000000726563697069656e744e0000004b65793a3a4163636f756e7428643062633963613133353335393763343030346238663838316233393761383963313737393030346635653534376530346235376332653739363763363236392908000000746f6b656e5f69640100000032")
            // test map of type (key, value) = (String, String) 2
            let keyArrayStr2: [CLValueWrapper] = [.string("amount1In"), .string("amount0In"), .string("amount0Out"), .string("contract_package_hash"), .string("amount1Out"), .string("event_type"), .string("sender"), .string("to")]
            let valueArrayStr2: [CLValueWrapper] = [.string("0"), .string("1000000000000000000"), .string("0"), .string("d32DE152c0bBFDcAFf5b2a6070Cd729Fc0F3eaCF300a6b5e2abAB035027C49bc"), .string("2394349025849241507"), .string("swap"), .string("Key::Hash(dDE7472639058717A42e22D297D6Cf3E07906bB57Bc28EfcEac3677f8A3Dc83b)"), .string("Key::Account(205DbED48272Ca02B45D9e3dCa89D6cA42D47E5cf836c8260118761DaD927b7c)")]
            let mapCLValueStr2: CLValueWrapper = .mapWrapper(keyArrayStr2, valueArrayStr2)
            let mapSeriallizaionStr2 = try CLTypeSerializeHelper.CLValueSerialize(input: mapCLValueStr2)
            XCTAssert(mapSeriallizaionStr2 == "0800000009000000616d6f756e7430496e13000000313030303030303030303030303030303030300a000000616d6f756e74304f7574010000003009000000616d6f756e7431496e01000000300a000000616d6f756e74314f7574130000003233393433343930323538343932343135303715000000636f6e74726163745f7061636b6167655f6861736840000000643332444531353263306242464463414666356232613630373043643732394663304633656143463330306136623565326162414230333530323743343962630a0000006576656e745f7479706504000000737761700600000073656e6465724b0000004b65793a3a4861736828644445373437323633393035383731374134326532324432393744364366334530373930366242353742633238456663456163333637376638413344633833622902000000746f4e0000004b65793a3a4163636f756e74283230354462454434383237324361303242343544396533644361383944366341343244343745356366383336633832363031313837363144614439323762376329")
            // test map of type (key, value) = (UInt32, String)
            let keyArray32: [CLValueWrapper] = [.u32(10), .u32(20), .u32(100)]
            let valueArrayString: [CLValueWrapper] = [.string("amount"), .string("d32DE152c0bBFDcAFf5b2a6070Cd729Fc0F3eaCF300a6b5e2abAB035027C49bc"), .string("Key::Account(205DbED48272Ca02B45D9e3dCa89D6cA42D47E5cf836c8260118761DaD927b7c)")]
            let mapCLValue32: CLValueWrapper = .mapWrapper(keyArray32, valueArrayString)
            let mapSeriallizaion32 = try CLTypeSerializeHelper.CLValueSerialize(input: mapCLValue32)
            XCTAssert(mapSeriallizaion32 == "030000000a00000006000000616d6f756e74140000004000000064333244453135326330624246446341466635623261363037304364373239466330463365614346333030613662356532616241423033353032374334396263640000004e0000004b65793a3a4163636f756e74283230354462454434383237324361303242343544396533644361383944366341343244343745356366383336633832363031313837363144614439323762376329")
            // test map of type (key, value) = (U512, String)
            let keyArrayU512: [CLValueWrapper] = [.u512(U512Class.fromStringToU512(from: "9900020009990098908090909089809")), .u512(U512Class.fromStringToU512(from: "123456789")), .u512(U512Class.fromStringToU512(from: "33"))]
            let valueArrayString2: [CLValueWrapper] = [.string("sender"), .string("2394349025849241507"), .string("Key::Account(1000000000000000000)")]
            let mapCLValueU512: CLValueWrapper = .mapWrapper(keyArrayU512, valueArrayString2)
            let mapSeriallizaionU512 = try CLTypeSerializeHelper.CLValueSerialize(input: mapCLValueU512)
            XCTAssert(mapSeriallizaionU512 == "030000000121210000004b65793a3a4163636f756e742831303030303030303030303030303030303030290415cd5b0713000000323339343334393032353834393234313530370d116064140541c00fbc9db0f47c0600000073656e646572")
            // test for Tuple1
            let tuple1CLValue: CLValueWrapper = .tuple1Wrapper(.string("Hello, World!"))
            let tuple2CLValue: CLValueWrapper = .tuple1Wrapper(.u32(1))
            let tuple3CLValue: CLValueWrapper = .tuple1Wrapper(.bool(true))
            let tuple1Serialization = try CLTypeSerializeHelper.CLValueSerialize(input: tuple1CLValue)
            XCTAssert(tuple1Serialization == "0d00000048656c6c6f2c20576f726c6421")
            let tuple1Serialization2 = try CLTypeSerializeHelper.CLValueSerialize(input: tuple2CLValue)
            XCTAssert(tuple1Serialization2 == "01000000")
            let tuple1Serialization3 = try CLTypeSerializeHelper.CLValueSerialize(input: tuple3CLValue)
            XCTAssert(tuple1Serialization3 == "01")
            // test for Tuple2
            let tupleType2: CLValueWrapper = .tuple2Wrapper(tuple1CLValue, tuple2CLValue)
            let tupleType2Serialization = try CLTypeSerializeHelper.CLValueSerialize(input: tupleType2)
            XCTAssert(tupleType2Serialization == "0d00000048656c6c6f2c20576f726c642101000000")
            // test for Tuple3
            let tupleType3: CLValueWrapper = .tuple3Wrapper(tuple2CLValue, tuple1CLValue, tuple3CLValue)
            let tupleType3Serialization = try CLTypeSerializeHelper.CLValueSerialize(input: tupleType3)
            XCTAssert(tupleType3Serialization == "010000000d00000048656c6c6f2c20576f726c642101")
        } catch {
        }
    }

}
