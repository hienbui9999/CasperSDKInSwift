import XCTest
@testable import CasperSDKInSwift
final class TestCLTypeSerialization: XCTestCase {

    func testAll() {
        let clType: CLType = .none
        XCTAssert(CLTypeSerializeHelper.CLTypeSerialize(input: .boolClType)   == "00")
        XCTAssert(CLTypeSerializeHelper.CLTypeSerialize(input: .i32ClType)    == "01")
        XCTAssert(CLTypeSerializeHelper.CLTypeSerialize(input: .i64ClType)    == "02")
        XCTAssert(CLTypeSerializeHelper.CLTypeSerialize(input: .u8ClType)     == "03")
        XCTAssert(CLTypeSerializeHelper.CLTypeSerialize(input: .u32ClType)    == "04")
        XCTAssert(CLTypeSerializeHelper.CLTypeSerialize(input: .u64)    == "05")
        XCTAssert(CLTypeSerializeHelper.CLTypeSerialize(input: .u128ClType)   == "06")
        XCTAssert(CLTypeSerializeHelper.CLTypeSerialize(input: .u256ClType)   == "07")
        XCTAssert(CLTypeSerializeHelper.CLTypeSerialize(input: .u512)   == "08")
        XCTAssert(CLTypeSerializeHelper.CLTypeSerialize(input: .unitClType)   == "09")
        XCTAssert(CLTypeSerializeHelper.CLTypeSerialize(input: .stringClType) == "0a")
        XCTAssert(CLTypeSerializeHelper.CLTypeSerialize(input: .urefClType)   == "0c")
        XCTAssert(CLTypeSerializeHelper.CLTypeSerialize(input: .keyClType)    == "0b")
        XCTAssert(CLTypeSerializeHelper.CLTypeSerialize(input: .option(clType))                 == "0d" + CLTypeSerializeHelper.CLTypeSerialize(input: clType))
        XCTAssert(CLTypeSerializeHelper.CLTypeSerialize(input: .listClType(clType))                   == "0e")
        XCTAssert(CLTypeSerializeHelper.CLTypeSerialize(input: .resultClType(clType, clType))         == "10")
        XCTAssert(CLTypeSerializeHelper.CLTypeSerialize(input: .mapClType(clType, clType))             == "11")
        XCTAssert(CLTypeSerializeHelper.CLTypeSerialize(input: .tuple1(clType))                 == "12")
        XCTAssert(CLTypeSerializeHelper.CLTypeSerialize(input: .tuple2(clType, clType))         == "13")
        XCTAssert(CLTypeSerializeHelper.CLTypeSerialize(input: .tuple3(clType, clType, clType))   == "14")
        XCTAssert(CLTypeSerializeHelper.CLTypeSerialize(input: .clTypeAny)                          == "15")
        XCTAssert(CLTypeSerializeHelper.CLTypeSerialize(input: .publicKey)                      == "16")
    }

}
