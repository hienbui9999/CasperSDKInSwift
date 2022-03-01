import XCTest
import Blake2
@testable import CasperSDKInSwift
final public class TestPutDeploy : XCTestCase {
    var signatureValue:String = "";
    let accountStr:String =  "01dbad8a77a1a00cd070412bee48dd690d3b0ad58933493ad01447a7ee2165b394"
    public func testAll() {
        do {
            let deploy:Deploy = Deploy();
            //Deploy header initialization
            let deployHeader:DeployHeader = DeployHeader();
            deployHeader.account = accountStr;
            deployHeader.body_hash = "";
            deployHeader.gas_price = 1
            deployHeader.ttl = "1h 30m"
            let timestamp = NSDate().timeIntervalSince1970
            let tE = String(timestamp).components(separatedBy:".");
            let mili = tE[1];
            let indexMili = mili.index(mili.startIndex,offsetBy: 3);
            let miliStr = mili[..<indexMili]
            let myTimeInterval = TimeInterval(timestamp)
            let time = NSDate(timeIntervalSince1970: TimeInterval(myTimeInterval))
            let timeStr = String(time.description)
            let timeElements = timeStr.components(separatedBy:" ");
            let newTimeStr = timeElements[0] + "T" + timeElements[1] + ".\(miliStr)Z";
            deployHeader.timestamp = newTimeStr
            deployHeader.chain_name = "casper-test"
            
            //Deploy payment initialization
            let clValue:CLValue = CLValue();
            clValue.bytes = "0400ca9a3b";
            clValue.cl_type = .U512
            clValue.parsed = .U512(U512Class.fromStringToU512(from: "1000000000"))
            let namedArg:NamedArg = NamedArg();
            namedArg.name = "amount"
            namedArg.argsItem = clValue
            let runTimeArgs:RuntimeArgs = RuntimeArgs();
            runTimeArgs.listNamedArg = [namedArg];
            let payment = ExecutableDeployItem.ModuleBytes(module_bytes: Bytes.fromStrToBytes(from: ""), args: runTimeArgs)
            
            
           //Deploy session initialization, base on this
            //https://testnet.cspr.live/deploy/f49fbc552914fb3fcbbcf948a613c5413ef3f1afe2c29b9c8aea3ecc89207a8a
            //1st namedArg
            let clValueSession1:CLValue = CLValue();
            clValueSession1.bytes = "04005ed0b2";
            clValueSession1.parsed = .U512(U512Class.fromStringToU512(from: "3000000000"))
            clValueSession1.cl_type = .U512
            let namedArgSession1:NamedArg = NamedArg();
            namedArgSession1.name = "amount"
            namedArgSession1.argsItem = clValueSession1
            
            //2nd namedArg
            let clValueSession2:CLValue = CLValue();
            clValueSession2.bytes = "02021172744b5e6bdc83a591b75765712e068e5d40a3be8ae360274fb26503b4ad38";
            clValueSession2.parsed = .PublicKey("02021172744b5e6bdc83a591b75765712e068e5d40a3be8ae360274fb26503b4ad38")
            clValueSession2.cl_type = .PublicKey
            let namedArgSession2:NamedArg = NamedArg();
            namedArgSession2.name = "target"
            namedArgSession2.argsItem = clValueSession2
            
            //3rd namedArg
            let clValueSession3:CLValue = CLValue();
            clValueSession3.bytes = "010000000000000000";
            clValueSession3.parsed = .OptionWrapper(.U64(0))
            clValueSession3.cl_type = .Option(.U64)
            let namedArgSession3:NamedArg = NamedArg();
            namedArgSession3.name = "id"
            namedArgSession3.argsItem = clValueSession3
            
            let runTimeArgsSession:RuntimeArgs = RuntimeArgs();
            runTimeArgsSession.listNamedArg = [namedArgSession1,namedArgSession2,namedArgSession3];
            let session:ExecutableDeployItem = .Transfer(args: runTimeArgsSession)
            
           
            //Deploy approvals
            
            //Deploy initialization
            deploy.header = deployHeader;
            deploy.payment = payment;
            deploy.session = session;
            deployHeader.body_hash = DeploySerialization.getBodyHash(fromDeploy: deploy)//
            deploy.hash = DeploySerialization.getHeaderHash(fromDeployHeader: deployHeader);
            let ed25519Cryto : Ed25519Cryto = Ed25519Cryto();
            do {
                
                let privateKey = try ed25519Cryto.readPrivateKeyFromPemFile(pemFileName: "ValidSwiftPrivateKey.pem")
                let signedMessage = try ed25519Cryto.signMessage(messageToSign: Data(deploy.hash.hexaBytes),withPrivateKey: privateKey)
                signatureValue = "01" + signedMessage.hexEncodedString()
            } catch {
                NSLog("Error:\(error)")
            }
            let dai1 : DeployApprovalItem = DeployApprovalItem();
            dai1.signer = accountStr
            dai1.signature = signatureValue;
            let approvals:[DeployApprovalItem] = [dai1];
            deploy.approvals = approvals;
            let casperSDK:CasperSDK = CasperSDK(url:"https://node-clarity-testnet.make.services/rpc");
            try casperSDK.putDeploy(input: deploy)
        } catch {
            NSLog("Error put deploy:\(error)")
        }
    }
}
