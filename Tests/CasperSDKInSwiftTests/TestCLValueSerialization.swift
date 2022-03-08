import XCTest
@testable import CasperSDKInSwift
final class TestCLValueSerialization: XCTestCase {
    func testAll() throws {
        do {
            //Serialization test
            
            //test for bool
            let bool_true:String = CLTypeSerializeHelper.BoolSerialize(input: true)
            let bool_false:String = CLTypeSerializeHelper.BoolSerialize(input: false)
            XCTAssert(bool_true == "01")
            XCTAssert(bool_false == "00")
            
            //test for u8
            let u8_1:String = CLTypeSerializeHelper.UInt8Serialize(input: 197)
            let u8_2:String = CLTypeSerializeHelper.UInt8Serialize(input: 7)
            let u8_3:String = CLTypeSerializeHelper.UInt8Serialize(input: 0)
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
            XCTAssert(u128_3 == "00")
            
            //test for u256
            let u256_1 =  try CLTypeSerializeHelper.U256Serialize(input:"999988887777666655556666777888999")
            let u256_2 =  try CLTypeSerializeHelper.U256Serialize(input:"2048")
            let u256_3 =  try CLTypeSerializeHelper.U256Serialize(input:"0")
            XCTAssert(u256_1 == "0ee76837d2ca215879f7bc5ca24d31")
            XCTAssert(u256_2 == "020008")
            XCTAssert(u256_3 == "00")
            
            //test for u512
            let u512_1 =  try CLTypeSerializeHelper.U512Serialize(input:"999888666555444999887988887777666655556666777888999666999")
            let u512_2 =  try CLTypeSerializeHelper.U512Serialize(input:"4096")
            let u512_3 =  try CLTypeSerializeHelper.U512Serialize(input:"0")
            let u512_4 =  try CLTypeSerializeHelper.U512Serialize(input: "100000000")
            XCTAssert(u512_1 == "1837f578fca55492f299ea354eaca52b6e9de47d592453c728")
            XCTAssert(u512_2 == "020010")
            XCTAssert(u512_3 == "00")
            XCTAssert(u512_4 == "0400e1f505")
            
            //test for string
            let str:String = "Hello, World!"
            let strSerialize = CLTypeSerializeHelper.StringSerialize(input: str)
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
            let str5:String = "target"
            let str5Serialize = CLTypeSerializeHelper.StringSerialize(input: str5)
           XCTAssert(str5Serialize=="06000000746172676574")
            //test for Unit
            let unit : CLValueWrapper = .Unit("")
            let unitSerialize = try CLTypeSerializeHelper.CLValueSerialize(input: unit)
            XCTAssert(unitSerialize=="")
            
            //test for Key
            //1. Account Hash
            let key1 : CLValueWrapper = .Key("account-hash-d0bc9cA1353597c4004B8F881b397a89c1779004F5E547e04b57c2e7967c6269")
            //2.Hash
            let key2 : CLValueWrapper = .Key("hash-8cf5e4acf51f54eb59291599187838dc3bc234089c46fc6ca8ad17e762ae4401")
            //3.URef
            let key3 : CLValueWrapper = .Key("uref-be1dc0fd639a3255c1e3e5e2aa699df66171e40fa9450688c5d718b470e057c6-007")
           
            let key1Serialization = try CLTypeSerializeHelper.CLValueSerialize(input: key1)
            let key2Serialization = try CLTypeSerializeHelper.CLValueSerialize(input: key2)
            let key3Serialization = try CLTypeSerializeHelper.CLValueSerialize(input: key3)

            XCTAssert(key1Serialization == "00d0bc9cA1353597c4004B8F881b397a89c1779004F5E547e04b57c2e7967c6269")
            XCTAssert(key2Serialization == "018cf5e4acf51f54eb59291599187838dc3bc234089c46fc6ca8ad17e762ae4401")
            XCTAssert(key3Serialization == "02be1dc0fd639a3255c1e3e5e2aa699df66171e40fa9450688c5d718b470e057c607")
           
            
            //test for URef
            let uref:CLValueWrapper = .URef("uref-be1dc0fd639a3255c1e3e5e2aa699df66171e40fa9450688c5d718b470e057c6-007")
            let urefSerialization = try CLTypeSerializeHelper.CLValueSerialize(input: uref)
            XCTAssert(urefSerialization=="be1dc0fd639a3255c1e3e5e2aa699df66171e40fa9450688c5d718b470e057c607")
            
            //test for PublicKey
            let publicKey:CLValueWrapper = .PublicKey("01394476bd8202887ac0e42ae9d8f96d7e02d81cc204533506f1fd199e95b1fd2b")
            let publicKeySerialization = try CLTypeSerializeHelper.CLValueSerialize(input: publicKey)
            XCTAssert(publicKeySerialization == "01394476bd8202887ac0e42ae9d8f96d7e02d81cc204533506f1fd199e95b1fd2b")
           
            //test for Option
            //Option None
            let optionNone:CLValueWrapper = .OptionWrapper(.NONE)
            let optionNoneSerialization = try CLTypeSerializeHelper.CLValueSerialize(input: optionNone)
            XCTAssert(optionNoneSerialization=="00")
            
            //Option with value U32
            let option:CLValueWrapper = .OptionWrapper(.U32(10))
            let optionSerialization = try CLTypeSerializeHelper.CLValueSerialize(input: option)
            XCTAssert(optionSerialization == "010a000000")
            
            //Option with value String("Hello, World!")
            let optionString:CLValueWrapper = .OptionWrapper(.String("Hello, World!"))
            let optionStringSerialization = try CLTypeSerializeHelper.CLValueSerialize(input: optionString)
            XCTAssert(optionStringSerialization == "010d00000048656c6c6f2c20576f726c6421")
            
            //test for List
            //List of 3 U32 numbers
            let item1:CLValueWrapper = .U32(1)
            let item2:CLValueWrapper = .U32(2)
            let item3:CLValueWrapper = .U32(3)
            let clValue:CLValueWrapper = .ListWrapper([item1,item2,item3])
            
            let clValueSerialization = try CLTypeSerializeHelper.CLValueSerialize(input: clValue)
            XCTAssert(clValueSerialization=="03000000010000000200000003000000")
            
            //List of 3 String
            let listStr1:CLValueWrapper = .String("Hello, World!")
            let listStr2:CLValueWrapper = .String("Bonjour le monde")
            let listStr3:CLValueWrapper = .String("Hola Mundo")
            let clValueStringList:CLValueWrapper = .ListWrapper([listStr1,listStr2,listStr3])
            let clStringListSerialization = try CLTypeSerializeHelper.CLValueSerialize(input: clValueStringList)
            XCTAssert(clStringListSerialization=="030000000d00000048656c6c6f2c20576f726c642110000000426f6e6a6f7572206c65206d6f6e64650a000000486f6c61204d756e646f")
            //Test for FixedList
            //FixedList of 3 U32 numbers
            let fitem1:CLValueWrapper = .U32(1)
            let fitem2:CLValueWrapper = .U32(2)
            let fitem3:CLValueWrapper = .U32(3)
            let fclValue:CLValueWrapper = .FixedListWrapper([fitem1,fitem2,fitem3])
            
            let fclValueSerialization = try CLTypeSerializeHelper.CLValueSerialize(input: fclValue)
            XCTAssert(fclValueSerialization=="010000000200000003000000")
            
            //FixedList of 3 String
            let flistStr1:CLValueWrapper = .String("Hello, World!")
            let flistStr2:CLValueWrapper = .String("Bonjour le monde")
            let flistStr3:CLValueWrapper = .String("Hola Mundo")
            let fclValueStringList:CLValueWrapper = .FixedListWrapper([flistStr1,flistStr2,flistStr3])
            let fclStringListSerialization = try CLTypeSerializeHelper.CLValueSerialize(input: fclValueStringList)
            XCTAssert(fclStringListSerialization=="0d00000048656c6c6f2c20576f726c642110000000426f6e6a6f7572206c65206d6f6e64650a000000486f6c61204d756e646f")
            //test for ByteArray
            let ba:CLValueWrapper = .BytesArray("006d0be2fb64bcc8d170443fbadc885378fdd1c71975e2ddd349281dd9cc59cc")
            let baSerialization = try CLTypeSerializeHelper.CLValueSerialize(input: ba)
            XCTAssert(baSerialization == "006d0be2fb64bcc8d170443fbadc885378fdd1c71975e2ddd349281dd9cc59cc")
           
            //test for Result
            //Result ok
            let resultCLValue : CLValueWrapper = .ResultWrapper("Ok", .U64(314))
            let resultCLValueSerialization = try CLTypeSerializeHelper.CLValueSerialize(input: resultCLValue)
            XCTAssert(resultCLValueSerialization=="013a01000000000000")
            
            //Result err
            let resultErrCLValue : CLValueWrapper = .ResultWrapper("Err", .String("Uh oh"))
            let resultCLValueErrSerialization = try CLTypeSerializeHelper.CLValueSerialize(input: resultErrCLValue)
            XCTAssert(resultCLValueErrSerialization=="00050000005568206f68")
          
            //test for map
            //test map of type (key,value) = (String,String)
            let keyArray:[CLValueWrapper] = [.String("event_type"),.String("recipient"),.String("token_id"),.String("contract_package_hash")];
            let valueArray:[CLValueWrapper] = [.String("cep47_mint_one"),.String("Key::Account(d0bc9ca1353597c4004b8f881b397a89c1779004f5e547e04b57c2e7967c6269)"),.String("2"),.String("a3b469a1e8b65b50e3c0c13e8f335de59203f7febe6ca41a95cdcb94c1c048e7")];
            let mapCLValue:CLValueWrapper = .MapWrapper(keyArray, valueArray);
            let mapSeriallizaion = try CLTypeSerializeHelper.CLValueSerialize(input: mapCLValue)
            XCTAssert(mapSeriallizaion == "0400000015000000636f6e74726163745f7061636b6167655f6861736840000000613362343639613165386236356235306533633063313365386633333564653539323033663766656265366361343161393563646362393463316330343865370a0000006576656e745f747970650e00000063657034375f6d696e745f6f6e6509000000726563697069656e744e0000004b65793a3a4163636f756e7428643062633963613133353335393763343030346238663838316233393761383963313737393030346635653534376530346235376332653739363763363236392908000000746f6b656e5f69640100000032")
            
            //test map of type (key,value) = (String,String) 2
            
            let keyArrayStr2:[CLValueWrapper] = [.String("amount1In"),.String("amount0In"),.String("amount0Out"),.String("contract_package_hash"),.String("amount1Out"),.String("event_type"),.String("sender"),.String("to")];
            let valueArrayStr2:[CLValueWrapper] = [.String("0"),.String("1000000000000000000"),.String("0"),.String("d32DE152c0bBFDcAFf5b2a6070Cd729Fc0F3eaCF300a6b5e2abAB035027C49bc"),.String("2394349025849241507"),.String("swap"),.String("Key::Hash(dDE7472639058717A42e22D297D6Cf3E07906bB57Bc28EfcEac3677f8A3Dc83b)"),.String("Key::Account(205DbED48272Ca02B45D9e3dCa89D6cA42D47E5cf836c8260118761DaD927b7c)")];
            let mapCLValueStr2:CLValueWrapper = .MapWrapper(keyArrayStr2, valueArrayStr2);
            let mapSeriallizaionStr2 = try CLTypeSerializeHelper.CLValueSerialize(input: mapCLValueStr2)
            XCTAssert(mapSeriallizaionStr2 == "0800000009000000616d6f756e7430496e13000000313030303030303030303030303030303030300a000000616d6f756e74304f7574010000003009000000616d6f756e7431496e01000000300a000000616d6f756e74314f7574130000003233393433343930323538343932343135303715000000636f6e74726163745f7061636b6167655f6861736840000000643332444531353263306242464463414666356232613630373043643732394663304633656143463330306136623565326162414230333530323743343962630a0000006576656e745f7479706504000000737761700600000073656e6465724b0000004b65793a3a4861736828644445373437323633393035383731374134326532324432393744364366334530373930366242353742633238456663456163333637376638413344633833622902000000746f4e0000004b65793a3a4163636f756e74283230354462454434383237324361303242343544396533644361383944366341343244343745356366383336633832363031313837363144614439323762376329")
            
            //test map of type (key,value) = (UInt32,String)
            let keyArray32:[CLValueWrapper] = [.U32(10),.U32(20),.U32(100)];
            let valueArrayString:[CLValueWrapper] = [.String("amount"),.String("d32DE152c0bBFDcAFf5b2a6070Cd729Fc0F3eaCF300a6b5e2abAB035027C49bc"),.String("Key::Account(205DbED48272Ca02B45D9e3dCa89D6cA42D47E5cf836c8260118761DaD927b7c)")];
            let mapCLValue32:CLValueWrapper = .MapWrapper(keyArray32, valueArrayString);
            let mapSeriallizaion32 = try CLTypeSerializeHelper.CLValueSerialize(input: mapCLValue32)
            XCTAssert(mapSeriallizaion32 == "030000000a00000006000000616d6f756e74140000004000000064333244453135326330624246446341466635623261363037304364373239466330463365614346333030613662356532616241423033353032374334396263640000004e0000004b65793a3a4163636f756e74283230354462454434383237324361303242343544396533644361383944366341343244343745356366383336633832363031313837363144614439323762376329")
            
            //test map of type (key,value) = (U512,String)
            let keyArrayU512:[CLValueWrapper] = [.U512(U512Class.fromStringToU512(from: "9900020009990098908090909089809")),.U512(U512Class.fromStringToU512(from: "123456789")),.U512(U512Class.fromStringToU512(from: "33"))]
            let valueArrayString2:[CLValueWrapper] = [.String("sender"),.String("2394349025849241507"),.String("Key::Account(1000000000000000000)")];
            let mapCLValueU512:CLValueWrapper = .MapWrapper(keyArrayU512, valueArrayString2);
            let mapSeriallizaionU512 = try CLTypeSerializeHelper.CLValueSerialize(input: mapCLValueU512)
            XCTAssert(mapSeriallizaionU512 == "030000000121210000004b65793a3a4163636f756e742831303030303030303030303030303030303030290415cd5b0713000000323339343334393032353834393234313530370d116064140541c00fbc9db0f47c0600000073656e646572")
            
           
            //test for Tuple1
            let tuple1CLValue : CLValueWrapper = .Tuple1Wrapper(.String("Hello, World!"))
            let tuple2CLValue : CLValueWrapper = .Tuple1Wrapper(.U32(1))
            let tuple3CLValue : CLValueWrapper = .Tuple1Wrapper(.Bool(true))
            let tuple1Serialization = try CLTypeSerializeHelper.CLValueSerialize(input: tuple1CLValue)
            XCTAssert(tuple1Serialization == "0d00000048656c6c6f2c20576f726c6421")
            let tuple1Serialization2 = try CLTypeSerializeHelper.CLValueSerialize(input: tuple2CLValue)
            XCTAssert(tuple1Serialization2 == "01000000")
            let tuple1Serialization3 = try CLTypeSerializeHelper.CLValueSerialize(input: tuple3CLValue)
            XCTAssert(tuple1Serialization3 == "01")
           
            //test for Tuple2
            
            let tupleType2 : CLValueWrapper = .Tuple2Wrapper(tuple1CLValue, tuple2CLValue)
            let tupleType2Serialization = try CLTypeSerializeHelper.CLValueSerialize(input: tupleType2)
            XCTAssert(tupleType2Serialization == "0d00000048656c6c6f2c20576f726c642101000000")
           
            //test for Tuple3
            let tupleType3 : CLValueWrapper = .Tuple3Wrapper(tuple2CLValue, tuple1CLValue, tuple3CLValue)
            let tupleType3Serialization = try CLTypeSerializeHelper.CLValueSerialize(input: tupleType3)
            XCTAssert(tupleType3Serialization == "010000000d00000048656c6c6f2c20576f726c642101")
           
        } catch {
            
        }
    }
}
