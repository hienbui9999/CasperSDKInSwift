import Foundation
/**
 class for CLType and CLValue serialization
 */
public class CLTypeSerializeHelper {
    /**
     Serialize for CLType
     - Parameter : CLType
     - Returns: String represent the serialization of the CLType of the input
     */
    public static func CLTypeSerialize(input:CLType) -> String {
        switch input {
        case .Bool:
            return "00"
        case .I32:
            return "01"
        case .I64:
            return "02"
        case .U8:
            return "03"
        case .U32:
            return "04"
        case .U64:
            return "05"
        case .U128:
            return "06"
        case .U256:
            return "07"
        case .U512:
            return "08"
        case .Unit:
            return "09"
        case .String:
            return "0a"
        case .URef:
            return "0b"
        case .Key:
            return "0c"
        case .PublicKey:
            //no return
            break;
        case .Option(let cLType):
            return "0d"
        case .List(let cLType):
            return "0e"
        case .BytesArray(let uInt32):
            return "0f"//review again
            break;
        case .Result(let cLType1, let cLType2):
            return "10"
        case .Map(let cLType1, let cLType2):
            return "11"
        case .Tuple1(let cLType):
            return "12"
        case .Tuple2(let cLType1, let cLType2):
            return "13"
        case .Tuple3(let cLType1, let cLType2, let cLType3):
            return "14"
        case .CLAny:
            return "15"
        case .NONE:
            //no return
            break;
        default:
            return "-1"
        }
       return "-1"
    }
    /**
     Serialize for CLValue
     - Parameters:
        - CLValue, wrapped in a CLValueWrapper object
        - withPrefix0x - if set to true then the serialization String will be with prefix "0x", otherwise no prefix "0x" is added. The default value is false.
     - Returns: String represent the serialization of the CLValue of the input
     */
    public static func CLValueSerialize(input:CLValueWrapper,withPrefix0x:Bool = false)throws -> String {
        switch input {
        case .Bool(let bool):
            return CLTypeSerializeHelper.BoolSerialize(input: bool)
        case .I32(let int32):
            return CLTypeSerializeHelper.Int32Serialize(input: int32)
        case .I64(let int64):
            return CLTypeSerializeHelper.Int64Serialize(input: int64)
        case .U8(let uInt8):
            return CLTypeSerializeHelper.UInt8Serialize(input: uInt8,withPrefix0x:withPrefix0x)
        case .U32(let uInt32):
            return CLTypeSerializeHelper.UInt32Serialize(input: uInt32,withPrefix0x:withPrefix0x)
        case .U64(let uInt64):
            return CLTypeSerializeHelper.UInt64Serialize(input: uInt64,withPrefix0x:withPrefix0x)
        case .U128(let u128Class):
            do {
                let result = try CLTypeSerializeHelper.BigNumberSerialize(input: u128Class.valueInStr,withPrefix0x:withPrefix0x)
                return result
            } catch (CasperError.invalidNumber) {
                throw CasperError.invalidNumber
            }
        case .U256(let u256Class):
            do {
                let result = try CLTypeSerializeHelper.BigNumberSerialize(input: u256Class.valueInStr,withPrefix0x:withPrefix0x)
                return result
            } catch (CasperError.invalidNumber) {
                throw CasperError.invalidNumber
            }
        case .U512(let u512Class):
            do {
                let result = try CLTypeSerializeHelper.BigNumberSerialize(input: u512Class.valueInStr,withPrefix0x:withPrefix0x)
                return result
            } catch (CasperError.invalidNumber) {
                throw CasperError.invalidNumber
            }
        case .Unit(let string):
            return ""
        case .String(let string):
            return CLTypeSerializeHelper.StringSerialize(input: string,withPrefix0x:withPrefix0x)
        case .Key(let string):
            if string.contains("account-hash") {
                let elements = string.components(separatedBy: "-")
                return "00" + elements[2]
            } else if string.contains("hash") {
                let elements = string.components(separatedBy: "-")
                return "01" + elements[1]
            } else if string.contains("uref-") {
                let elements = string.components(separatedBy: "-")
                if elements.count < 2 {
                    return ""
                } else {
                    let result = elements[1]
                    let accessRight:String = String(elements[2].suffix(2))
                    return "02" + result + accessRight
                }
            }
            break;
        case .URef(let string):
            let elements = string.components(separatedBy: "-")
            if elements.count < 2 {
                return ""
            } else {
                let result = elements[1]
                let accessRight:String = String(elements[2].suffix(2))
                return result + accessRight
            }
            break
        case .PublicKey(let string):
            return string
            break
        case .BytesArray(let string):
            return string
            break
        case .OptionWrapper(let cLValueWrapper):
            switch cLValueWrapper {
            case .NONE:
                if withPrefix0x {
                    return "0x00"
                } else {
                    return "00"
                }
            default:
                do {
                    var ret = try CLTypeSerializeHelper.CLValueSerialize(input: cLValueWrapper,withPrefix0x:false)
                    if withPrefix0x {
                        ret = "0x01" + ret
                    } else {
                        ret = "01" + ret
                    }
                    return ret
                } catch {
                    throw CasperError.invalidNumber
                }
            }
            
        case .ListWrapper(let array):
            let arraySize:UInt32 = UInt32(array.count)
            var result = CLTypeSerializeHelper.UInt32Serialize(input: arraySize)
            do {
                for e in array {
                    let ret = try CLTypeSerializeHelper.CLValueSerialize(input: e,withPrefix0x: false)
                    result = result + ret
                }
                return result
            } catch {
                throw CasperError.invalidNumber
            }
            
        case .FixedListWrapper(let array):
            var result = ""
            do {
                for e in array {
                    let ret = try CLTypeSerializeHelper.CLValueSerialize(input: e,withPrefix0x: false)
                    result = result + ret
                }
                return result
            } catch {
                throw CasperError.invalidNumber
            }
            
        case .ResultWrapper(let string, let cLValueWrapper):
            var result = ""
            if string == "Ok" {
                if withPrefix0x == true {
                    result = "0x01"
                } else {
                    result = "01"
                }
                do {
                    let ret = try CLTypeSerializeHelper.CLValueSerialize(input: cLValueWrapper, withPrefix0x: false)
                    result = result + ret
                    return result
                } catch {
                    throw CasperError.invalidNumber
                }
            } else if string == "Err" {
                if withPrefix0x == true {
                    result = "0x00"
                } else {
                    result = "00"
                }
                do {
                    let ret = try CLTypeSerializeHelper.CLValueSerialize(input: cLValueWrapper, withPrefix0x: false)
                    result = result + ret
                    return result
                } catch {
                    throw CasperError.invalidNumber
                }
            }
            
        case .MapWrapper(let array1, let array2):
            return ""
            
        case .Tuple1Wrapper(let cLValueWrapper):
            do {
                var ret = "0x"
                if withPrefix0x == false {
                    ret = ""
                }
                let ret2 = try CLTypeSerializeHelper.CLValueSerialize(input: cLValueWrapper, withPrefix0x: false)
                return ret + ret2
            } catch {
                throw CasperError.invalidNumber
            }
            
        case .Tuple2Wrapper(let cLValueWrapper1, let cLValueWrapper2):
            do {
                var ret = "0x"
                if withPrefix0x == false {
                    ret = ""
                }
                let ret1 =  try CLTypeSerializeHelper.CLValueSerialize(input: cLValueWrapper1, withPrefix0x: false)
                let ret2 = try CLTypeSerializeHelper.CLValueSerialize(input: cLValueWrapper2, withPrefix0x: false)
                return ret + ret1 + ret2
            } catch {
                throw CasperError.invalidNumber
            }
            
        case .Tuple3Wrapper(let cLValueWrapper1, let cLValueWrapper2, let cLValueWrapper3):
            do {
                var ret = "0x"
                if withPrefix0x == false {
                    ret = ""
                }
                let ret1 = try CLTypeSerializeHelper.CLValueSerialize(input: cLValueWrapper1, withPrefix0x: false)
                let ret2 = try CLTypeSerializeHelper.CLValueSerialize(input: cLValueWrapper2, withPrefix0x: false)
                let ret3 =  try CLTypeSerializeHelper.CLValueSerialize(input: cLValueWrapper3, withPrefix0x: false)
                return ret + ret1 + ret2 + ret3
            } catch {
                throw CasperError.invalidNumber
            }
            
        case .AnyCLValue(let anyObject):
            //non-serializable object
            break
        case .NULL:
            return ""
        case .NONE:
            return ""
        }
        return ""
    }
    
    /**
     Serialize for CLValue of CLType Bool
     - Parameters:bool value
     - Returns: String with value "01" if input == true,  "00" if input == false
     */
    public static func BoolSerialize(input:Bool)->String {
        if input == true {
            return "01"
        }
        return "00"
    }
    /**
     Serialize for CLValue of CLType Int32
     - Parameters:Int32 value
     - Returns: Serialization of UInt32 if input >= 0.
     If input < 0 Serialization of UInt32.max complement to the input
     */
    
    public static func Int32Serialize(input:Int32)->String {
        if input >= 0 {
            return CLTypeSerializeHelper.UInt32Serialize(input: UInt32(input))
        } else {
            let input2 = -input
            let input3 = UInt32.max - UInt32(input2) + 1
            return CLTypeSerializeHelper.UInt32Serialize(input: UInt32(input3))
        }
    }
    /**
     Serialize for CLValue of CLType Int64
     - Parameters:Int64 value
     - Returns: Serialization of UInt64 if input >= 0.
     If input < 0 Serialization of UInt64.max complement to the input
     */
    public static func Int64Serialize(input:Int64)->String {
        if input >= 0 {
            return CLTypeSerializeHelper.UInt64Serialize(input: UInt64(input))
        } else {
            let input2 = -input
            let input3 = UInt64.max - UInt64(input2) + 1
            return CLTypeSerializeHelper.UInt64Serialize(input: UInt64(input3))
        }
    }
    /**
     Serialize for CLValue of CLType UInt8
     - Parameters:UInt8 value
     - Returns: String represents the serialization of UInt8, which is a String of size 2. Example: Input UInt8(15) then output is "0f"
     */
    public static func UInt8Serialize(input:UInt8,withPrefix0x:Bool = false)->String{
        let value = UInt8(bigEndian: input)
        if withPrefix0x {
            return "0x" + String(format:"%02x",value.littleEndian)
        } else {
            return String(format:"%02x",value.littleEndian)
        }
    }
    /**
     Serialize for CLValue of CLType UInt32
     - Parameters:UInt32 value
     - Returns: String represents the serialization of UInt32 in little endian, which is a String of size 8. Example: Input UInt32(15) then output is "0f000000"
     */
    
    public static func UInt32Serialize(input:UInt32,withPrefix0x:Bool = false)->String {
        let value = UInt32(bigEndian: input)
        if withPrefix0x {
            return "0x" +  String(format:"%08x",value.littleEndian)
        } else {
            return String(format:"%08x",value.littleEndian)
        }
    }
    /**
     Serialize for CLValue of CLType UInt64
     - Parameters:UInt64 value
     - Returns: String represents the serialization of UInt64 in little endian, which is a String of size 16. Example: Input UInt32(15) then output is "0f00000000000000"
     */
    public static func UInt64Serialize(input:UInt64,withPrefix0x:Bool = false) -> String {
        return CLTypeSerializeHelper.SmallNumberSerialize(input: String(input), numBytes: 8,withPrefix0x : withPrefix0x)
    }
    public static func divideBy16(input:String)->(String,Int) {
        var retValue:String = "";
        if input.isNumeric {
            let inputLength = input.count
            var counter = 2
            let index = input.index(input.startIndex,offsetBy: 2)
            let first2 = input[..<index]
            var first2Value = Int(first2)!
            if first2Value < 16 {
                let index = input.index(input.startIndex,offsetBy: 3)
                let first2 = input[..<index]
                first2Value = Int(first2)!
                counter = 3
            }
            let (q,r) = first2Value.quotientAndRemainder(dividingBy: 16)
            retValue = String(q)
            var remainder:Int = r;
            while counter < inputLength {
                let startIndex = input.index(input.startIndex,offsetBy: counter)
                let endIndex = input.index(input.startIndex,offsetBy: counter+1)
                let range = startIndex..<endIndex
                let subStr = input[range]
                let value = remainder * 10 + Int(subStr)!
                let (q,r) = value.quotientAndRemainder(dividingBy:16)
                retValue = retValue + String(q)
                remainder = r;
                counter += 1
            }
            return (retValue,remainder)
        } else {
            return ("",-1)
        }
    }
    public static func from10To16(input:Int,lowerCase:Bool=true)->String {
        if input < 10 {
            return String(input)
        } else {
            switch input {
            case 10:
                if lowerCase == true {
                    return "a"
                } else {
                    return "A"
                }
            case 11:
                if lowerCase == true {
                    return "b"
                } else {
                    return "B"
                }
            case 12:
                if lowerCase == true {
                    return "c"
                } else {
                    return "C"
                }
            case 13:
                if lowerCase == true {
                    return "d"
                } else {
                    return "D"
                }
            case 14:
                if lowerCase == true {
                    return "e"
                } else {
                    return "E"
                }
            case 15:
                if lowerCase == true {
                    return "f"
                } else {
                    return "F"
                }
            default:
                return "?"
            }
            
        }
    }
    /**
     Serialize for CLValue of CLType U512 - big number
     - Parameters:U512 value in String format
     - Throws:CasperError.invalidNumber if the input String can not convert to number
     - Returns: String represents the serialization of U512 in little endian, with first byte represent the length of the serialization string, next is the serialization string. Example: Input U512("15") then output is "010f"
     */
    public static func U512Serialize(input:String,withPrefix0x:Bool = false) throws -> String {
        do {
           let ret = try CLTypeSerializeHelper.BigNumberSerialize(input: input,withPrefix0x: withPrefix0x)
            return ret
        } catch {
            throw CasperError.invalidNumber
        }
    }
    /**
     Serialize for CLValue of CLType U256 - big number
     - Parameters:U256 value in String format
     - Throws:CasperError.invalidNumber if the input String can not convert to number
     - Returns: String represents the serialization of U256 in little endian, with first byte represent the length of the serialization string, next is the serialization string. Example: Input U256("15") then output is "010f"
     */
    public static func U256Serialize(input:String,withPrefix0x:Bool = false) throws -> String {
        do {
           let ret = try CLTypeSerializeHelper.BigNumberSerialize(input: input,withPrefix0x: withPrefix0x)
            return ret
        } catch {
            throw CasperError.invalidNumber
        }
    }
    /**
     Serialize for CLValue of CLType U128 - big number
     - Parameters:U128 value in String format
     - Throws:CasperError.invalidNumber if the input String can not convert to number
     - Returns: String represents the serialization of U256 in little endian, with first byte represent the length of the serialization string, next is the serialization string. Example: Input U128("15") then output is "010f"
     */
    public static func U128Serialize(input:String,withPrefix0x:Bool = false) throws -> String {
        do {
           let ret = try CLTypeSerializeHelper.BigNumberSerialize(input: input,withPrefix0x: withPrefix0x)
            return ret
        } catch {
            throw CasperError.invalidNumber
        }
    }
    /**
     Serialize for  big number in general - this function is used to deal with U512, U256 and U128 Serialization
     - Parameters:Big number value in String format
     - Throws:CasperError.invalidNumber if the String can not convert to number
     - Returns: String represents the serialization of big number in little endian, with first byte represent the length of the serialization string, next is the serialization string. Example: Input ("15") then output is "010f"
     */
    public static func BigNumberSerialize(input:String,withPrefix0x:Bool = false) throws ->String {
        if input.isNumeric {
            let numberSerialize:String = CLTypeSerializeHelper.NumberSerialize(input: input)
            return CLTypeSerializeHelper.fromBigToLittleEdian(input: numberSerialize,withPrefix0x:withPrefix0x)
        } else {
            throw CasperError.invalidNumber
        }
    }
    //default UInt64
    public static func SmallNumberSerialize(input:String,numBytes:Int=16,withPrefix0x:Bool = false) -> String {
        var result:String = ""
        let numberSerialize:String = CLTypeSerializeHelper.NumberSerialize(input: input)
        result = CLTypeSerializeHelper.fromBigToLittleEdianU64AndLess(input: numberSerialize,numBytes: numBytes,withPrefix0x:withPrefix0x)
        return result
    }
    /**
     Serialize for big number to hexa String
     - Parameters:Big number in String format
     - Returns: String represents the serialization of Big number in little endian. Example: Input ("999888666555444999887988887777666655556666777888999666999") then output is "37f578fca55492f299ea354eaca52b6e9de47d592453c728"
     */
    public static func NumberSerialize(input:String) ->  String {
        var result:String = "";
        if input.isNumeric {
            if input.count < 5 {
                var hexa = String(UInt32(input)!, radix: 16)
                if hexa.count % 2 == 1 {
                    hexa = "0" + hexa
                }
                return hexa
            }
            let (retValue,remainder) = CLTypeSerializeHelper.divideBy16(input: input)
            var retV = retValue
            //var remain = remainder
            result = CLTypeSerializeHelper.from10To16(input: remainder)
            while(retV.count > 2) {
                let (rv,rm) = CLTypeSerializeHelper.divideBy16(input: retV)
                retV = rv
                //remain = rm
                result = CLTypeSerializeHelper.from10To16(input: rm) + result
            }
            if (Int(retV)! < 16) {
                result = CLTypeSerializeHelper.from10To16(input: Int(retV)!) + result
            } else {
                let (rv,rm) = CLTypeSerializeHelper.divideBy16(input: retV)
                retV = rv
                //remain = rm
                result = CLTypeSerializeHelper.from10To16(input: rm) + result
                result = CLTypeSerializeHelper.from10To16(input: Int(retV)!) + result
            }
        } else {
            NSLog("Input is not numeric")
        }
        return result
    }
    public static func fromBigToLittleEdianU64AndLess(input:String,numBytes:Int=16,withPrefix0x:Bool = false) -> String {//default UInt64
        var input2:String = input;
        var result:String = ""
        var prefix0:String = ""
        if input.count % 2 == 1 {
            input2 = "0" + input
        }
        let inputLength = input2.count/2
        var counter : Int = 0
        while (counter < numBytes - inputLength) {
            prefix0 = "00" + prefix0
            counter += 1
        }
        counter = 0
        while (counter < inputLength) {
            let startIndex = input2.index(input2.endIndex,offsetBy: -counter*2 - 1)
            let endIndex = input2.index(input2.endIndex,offsetBy: -(counter+1) * 2)
            let range = endIndex...startIndex
            let subStr = input2[range]
            result =  result + subStr
            counter += 1
        }
        result =  result + prefix0
        if (withPrefix0x == true) {
            result = "0x" + result
        }
        return result
    }
    public static func fromBigToLittleEdian(input:String,withPrefix0x:Bool = false) -> String {
        var input2:String = input;
        var result:String = ""
        var prefixLength:String = ""
        if input.count % 2 == 1 {
            input2 = "0" + input
        }
        let inputLength = input2.count/2
        var inputLengthHexa:String = String(inputLength,radix: 16)
        if inputLengthHexa.count % 2 == 1 {
            inputLengthHexa = "0" + inputLengthHexa
        }
        prefixLength = inputLengthHexa
        var counter : Int = 0
        while (counter < inputLength) {
            let startIndex = input2.index(input2.endIndex,offsetBy: -counter*2 - 1)
            let endIndex = input2.index(input2.endIndex,offsetBy: -(counter+1) * 2)
            let range = endIndex...startIndex
            let subStr = input2[range]
            result =  result + subStr
            counter += 1
        }
        if withPrefix0x {
            result = "0x" + prefixLength + result
        } else {
            result = prefixLength + result
        }
        return result
    }
    /**
     Serialize for CLValue of CLType String
     - Parameters:String value
     - Returns: String represents the serialization of the input String, with the Serialization of UInt32(String.length) of the input concatenated with the String serialization itself.
     Example:input "Hello, World!" will be serialized as "0d00000048656c6c6f2c20576f726c6421"
        or "lWJWKdZUEudSakJzw1tn" will be serialized as "140000006c574a574b645a5545756453616b4a7a7731746e"
     */
    public static func StringSerialize(input:String,withPrefix0x:Bool = false)->String {
        var result = ""
        let strLength : UInt32 = UInt32(input.count)
        result = CLTypeSerializeHelper.UInt32Serialize(input: strLength, withPrefix0x: withPrefix0x)
        for v in input.utf8 {
            let hexaCode =  CLTypeSerializeHelper.UInt8Serialize(input: UInt8(exactly: v)!)
            result = result + hexaCode
        }
        return result
    }
    /**
     Serialize for CLValue of CLType String
        Just return emtpy String
     */
    public static func UnitSerialize()->String {
        return ""
    }
    
}
