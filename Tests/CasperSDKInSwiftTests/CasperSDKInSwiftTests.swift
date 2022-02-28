import XCTest
@testable import CasperSDKInSwift

final class CasperSDKInSwiftTests: XCTestCase {
    func testAll() throws {
        let testCLTypeSerialization: TestCLTypeSerialization = TestCLTypeSerialization()
        testCLTypeSerialization.testAll()
        let testCLValueSerialization: TestCLValueSerialization = TestCLValueSerialization()
        do {
            try testCLValueSerialization.testAll()
        } catch {
            NSLog("Error test serialization:\(error)")
        }
        let testDeploySerialization : TestDeploySerialization = TestDeploySerialization()
        testDeploySerialization.testAll()
        let casperSDK:CasperSDK = CasperSDK(url:"https://node-clarity-testnet.make.services/rpc");
        //casperSDK.setMethodUrl(url: "https://node-clarity-mainnet.make.services/rpc")
        //-----------------------------------------------------------------------------
        //1. Test for chain_info_get_state_root_hash
        let getStateRootHashParam:GetStateRootHashParam = GetStateRootHashParam();
        //TEST 1: no param for sending request, latest state_root_hash is sent back
        do {
            try casperSDK.getStateRootHash(getStateRootHashParam: getStateRootHashParam)
        } catch {
            throw error
        }
        //TEST 2: get state_root_hash with block_hash as param
        do {
            getStateRootHashParam.block_identifier = .Hash("20e6cf8001a9456e9e202f0923393b1f551470934683800f62d11c1685d4710d")
            try casperSDK.getStateRootHash(getStateRootHashParam: getStateRootHashParam)
        } catch {
            throw error
        }
        //TEST 3: get state_root_hash with block_height as param
        do {
            getStateRootHashParam.block_identifier = .Height(473861)
            try casperSDK.getStateRootHash(getStateRootHashParam: getStateRootHashParam)
        } catch {
            throw error
        }
        //TEST 4: get state_root_hash with block_height as param but block_height too big
        //This will throw an Error of following content:
        //Error:CasperError(code: -32001, message: "block not known", methodCall: "chain_get_state_root_hash")
        do {
            getStateRootHashParam.block_identifier = .Height(473861000)
            try casperSDK.getStateRootHash(getStateRootHashParam: getStateRootHashParam)
        } catch {
            throw error
        }
        //-----------------------------------------------------------------------------
        //2. Test for info_get_peers
        do {
            try casperSDK.getPeers()
        } catch {
            throw error
        }
        //-----------------------------------------------------------------------------
        
        //3. Test for info_get_deploy
        //3.1. Test for existing deployHash
        do {
             let deployHash:String = "AaB4aa0C14a37Bc9386020609aa1CabaD895c3E2E104d877B936C6Ffa2302268";
              let getDeployParam:GetDeployParams = GetDeployParams();
              getDeployParam.deploy_hash = deployHash;
              try casperSDK.getDeploy(getDeployParam: getDeployParam)
        } catch {
            throw error
          }
        //3.1. Test for fake (non-existing) deployHash - this will throw an Error of following content
        //CasperError(code: -32602, message: "Invalid params", methodCall: "info_get_deploy")
        do {
             let deployHash:String = "11B4aa0C14a37Bc9386020609aa1CabaD895c3E2E104d877B936C6Ffa2302268";
              let getDeployParam:GetDeployParams = GetDeployParams();
              getDeployParam.deploy_hash = deployHash;
              try casperSDK.getDeploy(getDeployParam: getDeployParam)
        } catch {
            throw error
          }
        //-----------------------------------------------------------------------------
        //4.Test for info_get_status
        do {
            try casperSDK.getStatus()
        } catch {
            throw error
        }
       
        //5.Test for chain_get_block_transfers
        //5.1 get block transfer by block height
        do {
            let block_identifier  : BlockIdentifier = .Height(448471)
            try casperSDK.getBlockTransfers(input: block_identifier)
        }  catch {
            throw error
        }
        //5.2 get block transfer by block hash
        do {
            let block_identifier : BlockIdentifier = .Hash("ae173969cb6ce3c99439c81e5b803c15797a8559796d980daa99f52beb7192e3")
            try casperSDK.getBlockTransfers(input: block_identifier)
        }  catch {
            throw error
        }
        //5.3 get block transfer by block height but block height too big, will throw an Error of following content:
        //Error:CasperError(code: -32001, message: "block not known", methodCall: "chain_get_block_transfers")
        do {
            let block_identifier  : BlockIdentifier = .Height(4484710000)
            try casperSDK.getBlockTransfers(input: block_identifier)
        }  catch {
            throw error
        }
        //5.4 get block transfer by fake block hash (non-existing block hash)
        //latest block transfer hash is returned
        do {
            let block_identifier : BlockIdentifier = .Hash("FFEAE393969cb6ce3c99439c81e5b803c15797a8559796d980daa99FFE2beb7192e3")
            try casperSDK.getBlockTransfers(input: block_identifier)
        }  catch {
            throw error
        }
        //6.Test for chain_get_block
        
        //6.1. get block with block hash
        do {
            let block_identifier2 : BlockIdentifier = .Hash("830fd58dd08189981d7535fc9de0606bc789b2c8ef2af895ebce5ffc23c4530e")
            try casperSDK.getBlock(input: block_identifier2)
        }  catch {
            throw error
        }
        //6.2. get block with block height
        do {
            let block_identifier:BlockIdentifier = .Height(449797)
            try casperSDK.getBlock(input: block_identifier)
        }  catch {
            throw error
        }
        //6.3. get block with fake block hash (non-existing block hash)
        //latest block is returned
        do {
            let block_identifier2 : BlockIdentifier = .Hash("FFCC0fd58dd08189981d7535fc9de0606bc789b2c8ef2af895ebce5ffc23c4530e")
            try casperSDK.getBlock(input: block_identifier2)
        }  catch {
            throw error
        }
        //6.4. get block with too big block height (non-existing block height), an Error with following content will be thrown
        //Error:CasperError(code: -32001, message: "block not known", methodCall: "chain_get_block")
        do {
            let block_identifier:BlockIdentifier = .Height(44979700000)
            try casperSDK.getBlock(input: block_identifier)
        }  catch {
            throw error
        }
        //7.Test for chain_get_era_info_by_switch_block
        //7.1. get era by block height
        do {
            let block_identifier:BlockIdentifier = .Height(441636)
            try casperSDK.getEraBySwitchBlock(input: block_identifier)
        } catch {
            throw error
        }
        //7.2. get era by block hash
        do {
            let block_identifier:BlockIdentifier = .Hash("449a2570d5b8c4480565d05bfa17e3cd4249fcf6570132a4f8031fbc24cffb71")
            try casperSDK.getEraBySwitchBlock(input: block_identifier)
        } catch {
            throw error
        }
        //7.3. get era by too big block height (non-existing block height), an Error with the following content will be thrown
        //Error:CasperError(code: -32001, message: "block not known", methodCall: "chain_get_era_info_by_switch_block")
        do {
            let block_identifier:BlockIdentifier = .Height(4416360000)
            try casperSDK.getEraBySwitchBlock(input: block_identifier)
        } catch {
            throw error
        }
        //7.4. get era by fake block hash (non-existing block hash), an Error with the following content will be thrown
        //Error:CasperError(code: -32001, message: "block not known", methodCall: "chain_get_block")
        do {
            let block_identifier:BlockIdentifier = .Hash("FFGG2570d5b8c4480565d05bfa17e3cd4249fcf6570132a4f8031fbc24cffb71")
            try casperSDK.getEraBySwitchBlock(input: block_identifier)
        } catch {
            throw error
        }
        //8.Test for state_get_item
        do {
            let getStateItemParam:GetItemParams = GetItemParams();
            
            //Some alternative calls with different parameters to get different StoredValue back
            
            //Transfer
           // getStateItemParam.state_root_hash = "1416302b2c637647e2fe8c0b9f7ee815582cc7a323af5823313ff8a8684c8cf8"
           // getStateItemParam.key = "transfer-8218fa8c55c19264e977bf2bae9f5889082aee4d2c4eaf9642478173c37d1ed4"
            
            //DeployInfo
            //getStateItemParam.state_root_hash = "1416302b2c637647e2fe8c0b9f7ee815582cc7a323af5823313ff8a8684c8cf8"
            //getStateItemParam.key = "deploy-a49c06f9b2adf02812a7b2fdcad08804a2ce4896ffec7c06c920d417e7e39cfe"
            
            //Account Hash
            //getStateItemParam.state_root_hash = "b31f42523b6799d6d403a3119596c958abf2cdba31066322f01e5fa38ef999aa"
            //getStateItemParam.key = "account-hash-ff2ae80f71c1ffcac4921100a21b67ddecf59a30fb86eb6979f47c8838b3b7d3"
            
            //Bid - mainnest
            //casperSDK.setMethodUrl(url: "https://node-clarity-mainnet.make.services/rpc")
            //getStateItemParam.state_root_hash = "647C28545316E913969B032Cf506d5D242e0F857061E70Fb3DF55980611ace86"
            //getStateItemParam.key = "bid-24b6D5Aabb8F0AC17D272763A405E9CECa9166B75B745Cf200695E172857c2dD"
            //casperSDK.setMethodUrl(url: "https://node-clarity-testnet.make.services/rpc")
          
            //ContractPagage
            //getStateItemParam.state_root_hash = "83f6dca28102ecf1cf79d2e32172044b2eacf527e47a8781cead3850d01e6328"
            //getStateItemParam.key = "hash-b36478fa545160796de902e61ac504b33bc14624eea245a9df525b4d92d150bc"
            
            //Withdraw
            getStateItemParam.state_root_hash = "d360e2755f7cee816cce3f0eeb2000dfa03113769743ae5481816f3983d5f228"
            getStateItemParam.key = "withdraw-df067278a61946b1b1f784d16e28336ae79f48cf692b13f6e40af9c7eadb2fb1"
            try casperSDK.getItem(input: getStateItemParam)
        } catch {
            throw error
        }
        //8.2. use fake state_root_hash, an Error with the following content will be thrown
        //Error:CasperError(code: -32602, message: "Invalid params", methodCall: "state_get_item")
        do {
            let getStateItemParam:GetItemParams = GetItemParams();
            getStateItemParam.state_root_hash = "MMM0e2755f7cee816cce3f0eeb2000dfa03113769743ae5481816f3983d5f228"
            getStateItemParam.key = "withdraw-df067278a61946b1b1f784d16e28336ae79f48cf692b13f6e40af9c7eadb2fb1"
            try casperSDK.getItem(input: getStateItemParam)
        } catch {
            throw error
        }
        //8.3. use fake key, an Error with the following content will be thrown
        //Error:CasperError(code: -32002, message: "failed to parse key: withdraw-key from string error: Invalid byte `b\'f\'`, at index 1.", methodCall: "state_get_item")
        do {
            let getStateItemParam:GetItemParams = GetItemParams();
            getStateItemParam.state_root_hash = "d360e2755f7cee816cce3f0eeb2000dfa03113769743ae5481816f3983d5f228"
            getStateItemParam.key = "withdraw-DF167278a61946b1b1f784d16e28336ae79f48cf692b13f6e40af9c7eadb2fb1"
            try casperSDK.getItem(input: getStateItemParam)
        } catch {
            throw error
        }
        //8.4. use fake key without prefix, an Error with the following content will be thrown
        //Error:CasperError(code: -32002, message: "failed to parse key: unknown prefix for key", methodCall: "state_get_item")
        do {
            let getStateItemParam:GetItemParams = GetItemParams();
            getStateItemParam.state_root_hash = "d360e2755f7cee816cce3f0eeb2000dfa03113769743ae5481816f3983d5f228"
            getStateItemParam.key = "dEf067278a61946b1b1f784d16e28336ae79f48cf692b13f6e40af9c7eadb2fb1"
            try casperSDK.getItem(input: getStateItemParam)
        } catch {
            throw error
        }
        //9.Test for state_get_dictionary_item
        //9.1. test with correct parameter
         do {
             let getDic : GetDictionaryItemParams = GetDictionaryItemParams();
             getDic.state_root_hash = "146b860f82359ced6e801cbad31015b5a9f9eb147ab2a449fd5cdb950e961ca8";
             getDic.dictionary_identifier = DictionaryIdentifier.AccountNamedKey(key: "account-hash-ad7e091267d82c3b9ed1987cb780a005a550e6b3d1ca333b743e2dba70680877", dictionary_name: "dict_name", dictionary_item_key: "abc_name")
             
             //Some alternative calls with other parameter values, uncomment any do to the test with such values
             
             //getDic.dictionary_identifier = DictionaryIdentifier.ContractNamedKey(key: "hash-d5308670dc1583f49a516306a3eb719abe0ba51651cb08e606fcfc1f9b9134cf", dictionary_name: "dictname", dictionary_item_key: "abcname")
            // getDic.dictionary_identifier = DictionaryIdentifier.URef(seed_uref: "uref-30074a46a79b2d80cff437594d2422383f6c754de453b732448cc711b9f7e129-007", dictionary_item_key: "abc_name")
            // getDic.dictionary_identifier  = DictionaryIdentifier.Dictionary( "dictionary-5d3e90f064798d54e5e53643c4fce0cbb1024aadcad1586cc4b7c1358a530373")
             
              try casperSDK.getDictionaryItem(from: getDic)
         }  catch {
             throw error
         }
        //9.2. test with fake dictionary_identifier, an Error with the following content will be thrown
        //Error:CasperError(code: -32002, message: "Failed to parse key", methodCall: "state_get_dictionary_item")
        do {
            let getDic : GetDictionaryItemParams = GetDictionaryItemParams();
            getDic.state_root_hash = "146b860f82359ced6e801cbad31015b5a9f9eb147ab2a449fd5cdb950e961ca8";
            getDic.dictionary_identifier = DictionaryIdentifier.AccountNamedKey(key: "account-hash-AAFF091267d82c3b9ed1987cb780a005a550e6b3d1ca333b743e2dba70680877", dictionary_name: "dict_name", dictionary_item_key: "abc_name")
             try casperSDK.getDictionaryItem(from: getDic)
        }  catch {
            throw error
        }
        //10.Test for state_get_balance
        //10.1. test with correct parameter
        do {
            let getBP : GetBalanceParams = GetBalanceParams();
            getBP.state_root_hash = "8b463b56f2d124f43e7c157e602e31d5d2d5009659de7f1e79afbd238cbaa189";
            getBP.purse_uref = "uref-be1dc0fd639a3255c1e3e5e2aa699df66171e40fa9450688c5d718b470e057c6-007";
            try casperSDK.getStateBalance(input: getBP)
        }  catch {
            throw error
        }
        //10.2. test with fake purse_uref, an Error with the following content will be thrown
        //CasperError(code: -32005, message: "failed to parse purse_uref: Hex(InvalidByte { index: 0, byte: 102 })", methodCall: "state_get_balance")
        do {
            let getBP : GetBalanceParams = GetBalanceParams();
            getBP.state_root_hash = "8b463b56f2d124f43e7c157e602e31d5d2d5009659de7f1e79afbd238cbaa189";
            getBP.purse_uref = "uref-FF1dc0fd639a3255c1e3e5e2aa699df66171e40fa9450688c5d718b470e057c6-007";
            try casperSDK.getStateBalance(input: getBP)
        }  catch {
            throw error
        }
        //11.Test for state_get_auction_info
        //11.1 test with correct block hash parameter
        do {
            let block_identifier:BlockIdentifier = .Hash("cb8dab9f455538bc6cedb217a6234faeece8ce32c94d053b5b770450290b3a30")
            try casperSDK.getAuctionInfo(input: block_identifier)
        } catch {
            throw error
        }
        //11.2 test with correct block height parameter
        do {
            let block_identifier:BlockIdentifier = .Height(473576)
            try casperSDK.getAuctionInfo(input: block_identifier)
        } catch {
            throw error
        }
        //11.3 test with fake block hash (non-existing block hash) parameter, auction info for latest block is returned
        do {
            let block_identifier:BlockIdentifier = .Hash("FF8Eab9f455538bc6cedb217a6234faeece8ce32c94d053b5b770450290b3a30")
            try casperSDK.getAuctionInfo(input: block_identifier)
        } catch {
            throw error
        }
        //11.4 test with too big block height (non-existing block height) parameter
        //an Error with the following content will be thrown
        //CasperError(code: -32001, message: "get-auction-info failed to get specified block", methodCall: "state_get_auction_info")
        do {
            let block_identifier:BlockIdentifier = .Height(4735760000)
            try casperSDK.getAuctionInfo(input: block_identifier)
        } catch {
            throw error
        }
        
    }
}
