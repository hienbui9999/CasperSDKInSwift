import XCTest
import Blake2
@testable import CasperSDKInSwift
final public class TestPutDeploy : XCTestCase {
    
    var signatureValue:String = "";
    //ed25519
    var accountStr:String = "016c0bd4cd54fa6d74e7831a5ed31b00d7fefac4231c7229eec7ac8f8a0800220a"
   // "02029e8e8ce2f7101643b98a5a56382c128ca65429e9b4d4ca7e8d7c9f0d10b21c4c"// -- Account for secp256k1
    public func testAll() {
       
        //test 1 put a deploy of transfer type
        testPutDeployTransfer()
        
        //test 2 put a deploy in which session is a StoredContractByHash
        testPutDeployStoredContractByHash()
        
        //test3 put a deploy in which session is a StoredContractByName
        testPutDeployStoredContractByName();
        
        //test 4 put a deploy in which session is a StoredVersionedContractByHash
        testPutDeployStoredVersionedContractByHash()
        
        //test 5 put a deploy in which session is a StoredVersionedContractByName
        testPutDeployStoredVersionedContractByName();
        
    }
    public func testPutDeployStoredVersionedContractByName() {
        do {
            let deploy:Deploy = Deploy();
            //Deploy header initialization
            let deployHeader:DeployHeader = DeployHeader();
            deployHeader.account = accountStr;
            deployHeader.body_hash = "";
            deployHeader.gas_price = 1
            deployHeader.ttl = "1h"
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
            clValue.bytes = "0500e40b5402";
            clValue.cl_type = .U512
            clValue.parsed = .U512(U512Class.fromStringToU512(from: "10000000000"))
            let namedArg:NamedArg = NamedArg();
            namedArg.name = "amount"
            namedArg.argsItem = clValue
            let runTimeArgs:RuntimeArgs = RuntimeArgs();
            runTimeArgs.listNamedArg = [namedArg];
            let payment = ExecutableDeployItem.ModuleBytes(module_bytes: Bytes.fromStrToBytes(from: ""), args: runTimeArgs)
            
           //Deploy session initialization,
            //1st namedArg
            let clValueSession1:CLValue = CLValue();
            clValueSession1.bytes = " 0117202d448a32af52252a21c8296c9562c10a1f3da69efc5a5d01678aac753b7e";
            clValueSession1.parsed = .Key("hash-17202d448a32af52252a21c8296c9562c10a1f3da69efc5a5d01678aac753b7e")
            clValueSession1.cl_type = .Key
            let namedArgSession1:NamedArg = NamedArg();
            namedArgSession1.name = "token"
            namedArgSession1.argsItem = clValueSession1
            
            //2nd namedArg
            let clValueSession2:CLValue = CLValue();
            clValueSession2.bytes = "02ae08";
            clValueSession2.parsed = .U256(U256Class.fromStringToU256(from: "2222"))
            clValueSession2.cl_type = .U256
            let namedArgSession2:NamedArg = NamedArg();
            namedArgSession2.name = "amount"
            namedArgSession2.argsItem = clValueSession2
            
            let runTimeArgsSession:RuntimeArgs = RuntimeArgs();
            runTimeArgsSession.listNamedArg = [namedArgSession1,namedArgSession2];
            let session:ExecutableDeployItem = .StoredVersionedContractByName(name: "carbon_emissions_reward", version: versionMissing, entry_point: "flash_borrow", args: runTimeArgs)
            
            //Deploy initialization
            deploy.header = deployHeader;
            deploy.payment = payment;
            deploy.session = session;
            deployHeader.body_hash = DeploySerialization.getBodyHash(fromDeploy: deploy)//
            deploy.hash = DeploySerialization.getHeaderHash(fromDeployHeader: deployHeader);
            //sign with ed25519
            let ed25519Cryto : Ed25519Cryto = Ed25519Cryto();
            do {
                let privateKey = try ed25519Cryto.readPrivateKeyFromPemFile(pemFileName: "Assets/Ed25519/ReadSwiftPrivateKeyEd25519.pem")
                 let signedMessage = try ed25519Cryto.signMessage(messageToSign: Data(deploy.hash.hexaBytes),withPrivateKey: privateKey)
                 signatureValue = "01" + signedMessage.hexEncodedString()
            } catch {
                
            }
            //sign for secp256k1
            do {
                let secp256k1:Secp256k1Crypto = Secp256k1Crypto();
                let privateKeySecp256k1 = try secp256k1.readPrivateKeyFromFile(pemFileName: "Assets/Secp256k1/ReadSwiftPrivateKeySecp256k1.pem")
                let signMessageSecp256k1 = secp256k1.signMessage(messageToSign: Data(deploy.hash.hexaBytes),withPrivateKey: privateKeySecp256k1)
                let signatureSecp256k1Full = "02" + signMessageSecp256k1.r.data.hexEncodedString() + signMessageSecp256k1.s.data.hexEncodedString()
                //use this signature if you use secp256k1 signing
            } catch {
                NSLog("Error:\(error)")
            }
            let dai1 : DeployApprovalItem = DeployApprovalItem();
            dai1.signer = accountStr
            dai1.signature = signatureValue;
            
            //Deploy approvals
            let approvals:[DeployApprovalItem] = [dai1];
            deploy.approvals = approvals;
            let casperSDK:CasperSDK = CasperSDK(url:"https://node-clarity-testnet.make.services/rpc");
            try casperSDK.putDeploy(input: deploy)
        } catch {
            NSLog("Error put deploy:\(error)")
        }
    }
    public func testPutDeployStoredVersionedContractByHash() {
        //data is based on this deploy at this address
        //https://testnet.cspr.live/deploy/9d13abf758dce8663c070a223d95cca8b2e6f014d91fc6cd6f40ed21dbf55aba
        do {
            let deploy:Deploy = Deploy();
            //Deploy header initialization
            let deployHeader:DeployHeader = DeployHeader();
            deployHeader.account = accountStr;
            deployHeader.body_hash = "";
            deployHeader.gas_price = 1
            deployHeader.ttl = "1h"
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
            clValue.bytes = "0500e40b5402";
            clValue.cl_type = .U512
            clValue.parsed = .U512(U512Class.fromStringToU512(from: "10000000000"))
            let namedArg:NamedArg = NamedArg();
            namedArg.name = "amount"
            namedArg.argsItem = clValue
            let runTimeArgs:RuntimeArgs = RuntimeArgs();
            runTimeArgs.listNamedArg = [namedArg];
            let payment = ExecutableDeployItem.ModuleBytes(module_bytes: Bytes.fromStrToBytes(from: ""), args: runTimeArgs)
            
           //Deploy session initialization,
            //1st namedArg
            let clValueSession1:CLValue = CLValue();
            clValueSession1.bytes = " 0117202d448a32af52252a21c8296c9562c10a1f3da69efc5a5d01678aac753b7e";
            clValueSession1.parsed = .Key("hash-17202d448a32af52252a21c8296c9562c10a1f3da69efc5a5d01678aac753b7e")
            clValueSession1.cl_type = .Key
            let namedArgSession1:NamedArg = NamedArg();
            namedArgSession1.name = "token"
            namedArgSession1.argsItem = clValueSession1
            
            //2nd namedArg
            let clValueSession2:CLValue = CLValue();
            clValueSession2.bytes = "02ae08";
            clValueSession2.parsed = .U256(U256Class.fromStringToU256(from: "2222"))
            clValueSession2.cl_type = .U256
            let namedArgSession2:NamedArg = NamedArg();
            namedArgSession2.name = "amount"
            namedArgSession2.argsItem = clValueSession2
            
            let runTimeArgsSession:RuntimeArgs = RuntimeArgs();
            runTimeArgsSession.listNamedArg = [namedArgSession1,namedArgSession2];
            let session:ExecutableDeployItem = .StoredVersionedContractByHash(hash: "5daa83c7d18629fcdf3910ef4a284b6a3288e8879b24b199966857e857244844", version: versionMissing, entry_point: "flash_borrow", args: runTimeArgs)
            
            //Deploy initialization
            deploy.header = deployHeader;
            deploy.payment = payment;
            deploy.session = session;
            deployHeader.body_hash = DeploySerialization.getBodyHash(fromDeploy: deploy)//
            deploy.hash = DeploySerialization.getHeaderHash(fromDeployHeader: deployHeader);
            //sign with ed25519
            let ed25519Cryto : Ed25519Cryto = Ed25519Cryto();
            do {
                let privateKey = try ed25519Cryto.readPrivateKeyFromPemFile(pemFileName: "Assets/Ed25519/ReadSwiftPrivateKeyEd25519.pem")
                 let signedMessage = try ed25519Cryto.signMessage(messageToSign: Data(deploy.hash.hexaBytes),withPrivateKey: privateKey)
                 signatureValue = "01" + signedMessage.hexEncodedString()
            } catch {
                
            }
            //sign for secp256k1
            do {
                let secp256k1:Secp256k1Crypto = Secp256k1Crypto();
                let privateKeySecp256k1 = try secp256k1.readPrivateKeyFromFile(pemFileName: "Assets/Secp256k1/ReadSwiftPrivateKeySecp256k1.pem")
                let signMessageSecp256k1 = secp256k1.signMessage(messageToSign: Data(deploy.hash.hexaBytes),withPrivateKey: privateKeySecp256k1)
                let signatureSecp256k1Full = "02" + signMessageSecp256k1.r.data.hexEncodedString() + signMessageSecp256k1.s.data.hexEncodedString()
                //use this signature if you use secp256k1 signing
            } catch {
                NSLog("Error:\(error)")
            }
            let dai1 : DeployApprovalItem = DeployApprovalItem();
            dai1.signer = accountStr
            dai1.signature = signatureValue;
            
            //Deploy approvals
            let approvals:[DeployApprovalItem] = [dai1];
            deploy.approvals = approvals;
            let casperSDK:CasperSDK = CasperSDK(url:"https://node-clarity-testnet.make.services/rpc");
            try casperSDK.putDeploy(input: deploy)
        } catch {
            NSLog("Error put deploy:\(error)")
        }
    }
    public func testPutDeployStoredContractByName() {
        do {
            let deploy:Deploy = Deploy();
            //Deploy header initialization
            let deployHeader:DeployHeader = DeployHeader();
            deployHeader.account = accountStr;
            deployHeader.body_hash = "";
            deployHeader.gas_price = 1
            deployHeader.ttl = "1h"
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
            clValue.bytes = "0500902f5009";
            clValue.cl_type = .U512
            clValue.parsed = .U512(U512Class.fromStringToU512(from: "40000000000"))
            let namedArg:NamedArg = NamedArg();
            namedArg.name = "amount"
            namedArg.argsItem = clValue
            let runTimeArgs:RuntimeArgs = RuntimeArgs();
            runTimeArgs.listNamedArg = [namedArg];
            let payment = ExecutableDeployItem.ModuleBytes(module_bytes: Bytes.fromStrToBytes(from: ""), args: runTimeArgs)
            
           //Deploy session initialization, base on this
            //https://testnet.cspr.live/deploy/f686c52f49f35c5e8ded7f8b5d83af1075715483c4e2f296a4ffa7285841db47
            //1st namedArg
            let clValueSession1:CLValue = CLValue();
            clValueSession1.bytes = " 0400000031313030";
            clValueSession1.parsed = .String("1100")
            clValueSession1.cl_type = .String
            let namedArgSession1:NamedArg = NamedArg();
            namedArgSession1.name = "carbon_emission"
            namedArgSession1.argsItem = clValueSession1
            
            //2nd namedArg
            let clValueSession2:CLValue = CLValue();
            clValueSession2.bytes = "0500000031322f3135";
            clValueSession2.parsed = .String("12/15")
            clValueSession2.cl_type = .String
            let namedArgSession2:NamedArg = NamedArg();
            namedArgSession2.name = "month_year"
            namedArgSession2.argsItem = clValueSession2
            
            let runTimeArgsSession:RuntimeArgs = RuntimeArgs();
            runTimeArgsSession.listNamedArg = [namedArgSession1,namedArgSession2];
            let session:ExecutableDeployItem = .StoredContractByName(name: "carbon_emissions_reward", entry_point: "input_data", args: runTimeArgs)
            
            //Deploy initialization
            deploy.header = deployHeader;
            deploy.payment = payment;
            deploy.session = session;
            deployHeader.body_hash = DeploySerialization.getBodyHash(fromDeploy: deploy)//
            deploy.hash = DeploySerialization.getHeaderHash(fromDeployHeader: deployHeader);
            //sign with ed25519
            let ed25519Cryto : Ed25519Cryto = Ed25519Cryto();
            do {
                let privateKey = try ed25519Cryto.readPrivateKeyFromPemFile(pemFileName: "Assets/Ed25519/ReadSwiftPrivateKeyEd25519.pem")
                 let signedMessage = try ed25519Cryto.signMessage(messageToSign: Data(deploy.hash.hexaBytes),withPrivateKey: privateKey)
                 signatureValue = "01" + signedMessage.hexEncodedString()
            } catch {
                
            }
            //sign for secp256k1
            do {
                let secp256k1:Secp256k1Crypto = Secp256k1Crypto();
                let privateKeySecp256k1 = try secp256k1.readPrivateKeyFromFile(pemFileName: "Assets/Secp256k1/ReadSwiftPrivateKeySecp256k1.pem")
                let signMessageSecp256k1 = secp256k1.signMessage(messageToSign: Data(deploy.hash.hexaBytes),withPrivateKey: privateKeySecp256k1)
                let signatureSecp256k1Full = "02" + signMessageSecp256k1.r.data.hexEncodedString() + signMessageSecp256k1.s.data.hexEncodedString()
                //use this signature if you use secp256k1 signing
            } catch {
                NSLog("Error:\(error)")
            }
            let dai1 : DeployApprovalItem = DeployApprovalItem();
            dai1.signer = accountStr
            dai1.signature = signatureValue;
            
            //Deploy approvals
            let approvals:[DeployApprovalItem] = [dai1];
            deploy.approvals = approvals;
            let casperSDK:CasperSDK = CasperSDK(url:"https://node-clarity-testnet.make.services/rpc");
            try casperSDK.putDeploy(input: deploy)
        } catch {
            NSLog("Error put deploy:\(error)")
        }
    }
    public func testPutDeployStoredContractByHash() {
        do {
            let deploy:Deploy = Deploy();
            //Deploy header initialization
            let deployHeader:DeployHeader = DeployHeader();
            deployHeader.account = accountStr;
            deployHeader.body_hash = "";
            deployHeader.gas_price = 1
            deployHeader.ttl = "1h"
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
            clValue.bytes = "04005ed0b2";
            clValue.cl_type = .U512
            clValue.parsed = .U512(U512Class.fromStringToU512(from: "3000000000"))
            let namedArg:NamedArg = NamedArg();
            namedArg.name = "amount"
            namedArg.argsItem = clValue
            let runTimeArgs:RuntimeArgs = RuntimeArgs();
            runTimeArgs.listNamedArg = [namedArg];
            let payment = ExecutableDeployItem.ModuleBytes(module_bytes: Bytes.fromStrToBytes(from: ""), args: runTimeArgs)
            
           //Deploy session initialization, base on this
            //https://testnet.cspr.live/deploy/b17f553233318829740de569b98c30682e32ec3056faab8c9957949730f52a6f
            //1st namedArg
            let clValueSession1:CLValue = CLValue();
            clValueSession1.bytes = "01fe22495761529662e76ede1437ead7fcd4af7ba52b0656b9f6964ed17fd3b60b";
            clValueSession1.parsed = .Key("hash-fe22495761529662e76ede1437ead7fcd4af7ba52b0656b9f6964ed17fd3b60b")
            clValueSession1.cl_type = .Key
            let namedArgSession1:NamedArg = NamedArg();
            namedArgSession1.name = "token"
            namedArgSession1.argsItem = clValueSession1
            
            //2nd namedArg
            let clValueSession2:CLValue = CLValue();
            clValueSession2.bytes = "01a8ca8f795c2d7e33b62b18db0e28577a9f8c8cecda26080cae862f58fa5bb24e";
            clValueSession2.parsed = .PublicKey("hash-a8ca8f795c2d7e33b62b18db0e28577a9f8c8cecda26080cae862f58fa5bb24e")
            clValueSession2.cl_type = .PublicKey
            let namedArgSession2:NamedArg = NamedArg();
            namedArgSession2.name = "contract_hash"
            namedArgSession2.argsItem = clValueSession2
            
            //3rd namedArg
            let clValueSession3:CLValue = CLValue();
            clValueSession3.bytes = "010a";
            clValueSession3.parsed = .U256(U256Class.fromStringToU256(from: "10"))
            clValueSession3.cl_type = .U256
            let namedArgSession3:NamedArg = NamedArg();
            namedArgSession3.name = "value"
            namedArgSession3.argsItem = clValueSession3
            
            let runTimeArgsSession:RuntimeArgs = RuntimeArgs();
            runTimeArgsSession.listNamedArg = [namedArgSession1,namedArgSession2,namedArgSession3];
            let session:ExecutableDeployItem = .StoredContractByHash(hash: "56c8e4ebb005e6679bb48887ca7e3c37768a85893f93cd7bcdbdd6bdc41acde5", entry_point: "testing_erc20_transfer", args: runTimeArgs)
            
           
            //Deploy approvals
            
            //Deploy initialization
            deploy.header = deployHeader;
            deploy.payment = payment;
            deploy.session = session;
            deployHeader.body_hash = DeploySerialization.getBodyHash(fromDeploy: deploy)//
            deploy.hash = DeploySerialization.getHeaderHash(fromDeployHeader: deployHeader);
            //sign with ed25519
            let ed25519Cryto : Ed25519Cryto = Ed25519Cryto();
            do {
                let privateKey = try ed25519Cryto.readPrivateKeyFromPemFile(pemFileName: "Assets/Ed25519/ReadSwiftPrivateKeyEd25519.pem")
                 let signedMessage = try ed25519Cryto.signMessage(messageToSign: Data(deploy.hash.hexaBytes),withPrivateKey: privateKey)
                 signatureValue = "01" + signedMessage.hexEncodedString()
            } catch {
                
            }
            //sign for secp256k1
            do {
                let secp256k1:Secp256k1Crypto = Secp256k1Crypto();
                let privateKeySecp256k1 = try secp256k1.readPrivateKeyFromFile(pemFileName: "Assets/Secp256k1/ReadSwiftPrivateKeySecp256k1.pem")
                let signMessageSecp256k1 = secp256k1.signMessage(messageToSign: Data(deploy.hash.hexaBytes),withPrivateKey: privateKeySecp256k1)
                let signatureSecp256k1Full = "02" + signMessageSecp256k1.r.data.hexEncodedString() + signMessageSecp256k1.s.data.hexEncodedString()
                //use this signature if you use secp256k1 signing
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
    public func testPutDeployTransfer() {
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
            //sign with ed25519
            let ed25519Cryto : Ed25519Cryto = Ed25519Cryto();
            do {
                let privateKey = try ed25519Cryto.readPrivateKeyFromPemFile(pemFileName: "Assets/Ed25519/ReadSwiftPrivateKeyEd25519.pem")
                 let signedMessage = try ed25519Cryto.signMessage(messageToSign: Data(deploy.hash.hexaBytes),withPrivateKey: privateKey)
                 signatureValue = "01" + signedMessage.hexEncodedString()
            } catch {
                
            }
            //sign for secp256k1
            do {
                let secp256k1:Secp256k1Crypto = Secp256k1Crypto();
                let privateKeySecp256k1 = try secp256k1.readPrivateKeyFromFile(pemFileName: "Assets/Secp256k1/ReadSwiftPrivateKeySecp256k1.pem")
                let signMessageSecp256k1 = secp256k1.signMessage(messageToSign: Data(deploy.hash.hexaBytes),withPrivateKey: privateKeySecp256k1)
                let signatureSecp256k1Full = "02" + signMessageSecp256k1.r.data.hexEncodedString() + signMessageSecp256k1.s.data.hexEncodedString()
                //use this signature if you use secp256k1 signing
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
