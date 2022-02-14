import XCTest
@testable import CasperSDKInSwift
final class TestCLTypeSerialization: XCTestCase {
    func testAll() throws {
        do {
            let clType:CLType = .NONE
            XCTAssert(CLTypeSerializeHelper.CLTypeSerialize(input: .Bool)   == "00")
            XCTAssert(CLTypeSerializeHelper.CLTypeSerialize(input: .I32)    == "01")
            XCTAssert(CLTypeSerializeHelper.CLTypeSerialize(input: .I64)    == "02")
            XCTAssert(CLTypeSerializeHelper.CLTypeSerialize(input: .U8)     == "03")
            XCTAssert(CLTypeSerializeHelper.CLTypeSerialize(input: .U32)    == "04")
            XCTAssert(CLTypeSerializeHelper.CLTypeSerialize(input: .U64)    == "05")
            XCTAssert(CLTypeSerializeHelper.CLTypeSerialize(input: .U128)   == "06")
            XCTAssert(CLTypeSerializeHelper.CLTypeSerialize(input: .U256)   == "07")
            XCTAssert(CLTypeSerializeHelper.CLTypeSerialize(input: .U512)   == "08")
            XCTAssert(CLTypeSerializeHelper.CLTypeSerialize(input: .Unit)   == "09")
            XCTAssert(CLTypeSerializeHelper.CLTypeSerialize(input: .String) == "0a")
            XCTAssert(CLTypeSerializeHelper.CLTypeSerialize(input: .URef)   == "0b")
            XCTAssert(CLTypeSerializeHelper.CLTypeSerialize(input: .Key)    == "0c")
            XCTAssert(CLTypeSerializeHelper.CLTypeSerialize(input: .Option(clType))                 == "0d")
            XCTAssert(CLTypeSerializeHelper.CLTypeSerialize(input: .List(clType))                   == "0e")
            XCTAssert(CLTypeSerializeHelper.CLTypeSerialize(input: .Result(clType, clType))         == "10")
            XCTAssert(CLTypeSerializeHelper.CLTypeSerialize(input: .Map(clType,clType))             == "11")
            XCTAssert(CLTypeSerializeHelper.CLTypeSerialize(input: .Tuple1(clType))                 == "12")
            XCTAssert(CLTypeSerializeHelper.CLTypeSerialize(input: .Tuple2(clType, clType))         == "13")
            XCTAssert(CLTypeSerializeHelper.CLTypeSerialize(input: .Tuple3(clType,clType,clType))   == "14")
            XCTAssert(CLTypeSerializeHelper.CLTypeSerialize(input: .CLAny)                          == "15")

        } catch {
            
        }
    }
}
