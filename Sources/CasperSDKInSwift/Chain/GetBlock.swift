//
//  GetBlock.swift
//  SampleRPCCall1
//
//  Created by Hien on 11/12/2021.
//
//https://docs.rs/casper-node/latest/casper_node/rpcs/chain/struct.GetBlock.html
//DATA BACK
/*
 
 */

import Foundation
class GetBlock {
    let methodStr : String = "chain_get_block"
    let methodURL : String = "http://65.21.227.180:7777/rpc"
    func handle_request () {
        //var ret : GetPeersResult = GetPeersResult();
        let parameters = ["id": 1, "method": methodStr,"params":"[]","jsonrpc":"2.0"] as [String : Any]
            //create the url with URL
            let url = URL(string: methodURL)! //change the url
//create the session object
            let session = URLSession.shared
   //now create the URLRequest object using the url object
            var request = URLRequest(url: url)
            request.httpMethod = "POST" //set http method as POST
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            } catch let error {
                print(error.localizedDescription)
            }
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            request.addValue("application/json", forHTTPHeaderField: "Accept")
    
//create dataTask using the session object to send data to the server

            let task = session.dataTask(with: request as URLRequest, completionHandler: {
                data, response, error in
                    guard error == nil else {
                    return
                }
                guard let data = data else {
                    return
                }
                do {
                    //create json object from data
                    if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                        print("JSON BACK:\(json)")
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            })
            task.resume()
       // return ret;
    }
}


/*
 Data back
 
 ["jsonrpc": 2.0, "result": {
     "api_version" = "1.4.3";
     block =     {
         body =         {
             "deploy_hashes" =             (
                 1dd9D8BB08676751AbEd8fa9cdabD8aB18413E16aa64a61D6058Ee9896dC8f5b
             );
             proposer = 01D949A3a1963DB686607a00862f79B76CEB185FC134d0AeEDb686F1C151f4ae54;
             "transfer_hashes" =             (
             );
         };
         hash = f575666F156346402E8F865468329575da8396A0F84654337F9e2FD12d740B36;
         header =         {
             "accumulated_seed" = f3712f4FE4af5705de18227D594b7096ae64b12947097Ef772EDF4F1d0C942f1;
             "body_hash" = dE744E615B5f0FbB6691a54Ef7836e9bd1dF93aC8DDDDF2c5f04B7546d4C1415;
             "era_end" = "<null>";
             "era_id" = 2950;
             height = 366634;
             "parent_hash" = C078B02114E5cF4ca628F13FC14FbE4991ebdEA0851349D091f08796CeBCcf84;
             "protocol_version" = "1.4.3";
             "random_bit" = 1;
             "state_root_hash" = e40feD6eCcC9c21FD65dEB6a0155802B566D7b5DA8d441d188f18932Ee8fa83C;
             timestamp = "2021-12-11T11:07:18.400Z";
         };
         proofs =         (
                         {
                 "public_key" = 0101a458aa2b551C5a49E56326f9BB298bb308E1bAbC875647AE0290c42f13FeAc;
                 signature = 01Fe40957abFf56bBEd3e6B433DE43E4CebADB13aA9C8b2669014aa50C0F7bE7FFe6fEa7301425d4A4cDE51Ad5CA809E5fE09D8e8fb4E50e34704363d721B1D10a;
             },
                         {
                 "public_key" = 0102112A711eb3beE9043ebf036FbDfd4482f0e37d1A65627E09922943713973f8;
                 signature = 0121f88660dB74a0265dB648fd6dc87db658149A90148Dc3EafD59E9A5aD1c918F1c8e29AE6acDc8Cb10E396c895f62afEd0cc84c4C88dfE2f17B1C968D83Bf00A;
             },
                         {
                 "public_key" = 01028e248170a7f328Bf7A04696d8F271A1DebB54763e05e537EefC1Cf24531BC7;
                 signature = 010Aaf3C8Cc856a13B1e690548Eb3A1E290BDD93c5a335C29aba40131127a95d3BDB260c9fFcfaE1b846f4aE85b9BF448E99cFC4349660e55caD851020062e770D;
             },
                         {
                 "public_key" = 0106618e1493F73eE0bC67FfBad4ba4E3863B995D61786d9b9a68EC7676f697981;
                 signature = 015eb54605170F6a74fa7177E7AF4BB1C6FC901A68C8C732860d189691880a1d4dB708C05c6E67e6455Cb7826d57BA6766b971e2E5b998E7A328a95ea0FD1Ceb07;
             },
                         {
                 "public_key" = 0106cA7c39cD272DbF21a86EeB3B36B7c26E2e9b94af64292419f7862936bcA2cA;
                 signature = 01369cfEEF774251F067b91E4c3b1C630F3ba54861B7ca9205B1855a4B27F10B3B299dAC8D0E956FB078f3901f403764B6f8F2bf85A5BEcAA2D38A00d66E8Fa40E;
             },
                         {
                 "public_key" = 01075eC8809C691a1d1b0250BA9ea75Da5460E3DF43C3172771C6975C989457159;
                 signature = 013ec12a0B5f8C0Ecd3D69b02d7dB60b21ED164dAb9B36Ee36446d7388E04B1e710cB68e7f724f5bd56236BcBb8CD7D55977542081CA1BcdCeB1fecb8f7f728c0c;
             },
                         {
                 "public_key" = 0107cBA5B4826A87dDBe0bA8CDa8064881b75882f05094C1a5f95e957512A3450e;
                 signature = 01F44CbB508759557625d490d3Cd35CACb1Fa9C89c6BeFDeAB809271d47Eb9c5A5881D1c94e39d26320E380c4bD508Ba4C3EeD586d6FBbAf3dCB2045d2D35cBf00;
             },
                         {
                 "public_key" = 0109B48a169e6163078a07B6248f330133236c6E390Fe915813c187C3f268c213E;
                 signature = 01D0B22A2C334F0452c560225086fBD68a4f4206bcCbC531f84a987E62Db3767bD5230893572018449732E7234685aaD598790CAcaD3ee06c4eac642B103103806;
             },
                         {
                 "public_key" = 010AF5a943baCD2A8e91792Eb4e9a25e32D536AB103372f57F89ebCaDFC59820d1;
                 signature = 01A2571578c5E344A661Cac65AF8321886a8BD0CeC581a95Dd4Ca4D5f105D64fd53072fDfe24118902aB0059C7f40d897FfB82E09f5D09D8722CD684F941797100;
             },
                         {
                 "public_key" = 010d2680f739B5151D99bE4E4eF945618193b069aecf5A4F233d471fc46eeb38D1;
                 signature = 0193B93e503d089C509671835b4640Ca58Dc71cC774370508c85AF3c71C07E0951D1FeCB18BC2f1D0407c6d5df9D6A65b3B6C5F3C08E6720A93bD837AF5278d90f;
             },
                         {
                 "public_key" = 010E5669B070545E2B32bC66363B9D3d4390fCa56bF52A05F1411b7FA18cA311C7;
                 signature = 01bfF3952bD885ffACaFAC3Adb39A4b10DD6117d15eaC1d4E55D1037F9b3c1Bc398cD0416885Fb4Cf6FE9D3BAA4aC7E5A2d5CbcCe3f02dFb358c5E4306bA997201;
             },
                         {
                 "public_key" = 01163505001835405BDb7C9E5670492d03973073CA2BE45880785C5Afc9bda486D;
                 signature = 01AB684145263BD437DC0Ca02B383989098bdc2d01aC0dEd8Dd9E60154F43695dD1704917DB0BEC72a7e3CC9f2f56f7D1EF429377f99C80a385680f2621292570C;
             },
                         {
                 "public_key" = 011691F57529Dd47A82530ad9c4a60f5efd993dD3f3E582fD2f775FB1a79C6d955;
                 signature = 017d4bc5492232bA4089418a25632629293eF393D84bA72de75d50CC520eB68F490a7198B02d777aEaa5E169F3690D2350296da6AF9c9B580711693097De6ECA0b;
             },
                         {
                 "public_key" = 011a2B510E4b45c05E28BA5a78529295923fC0945376E28C23b696E949D790a3D5;
                 signature = 01C8B3De8F114A2f945df13e1144c13aD87f4392E7B94aac50c2Ae4E00490f21dc241f73A8065D9470A5B8C0E7680510F0911fE3F2b2FCDd4F83cFd5AC87FE5D08;
             },
                         {
                 "public_key" = 011Aa6cf14e51FC20067e2945886E1c6c26F1883d1216fa8d153392FC95B56c3bD;
                 signature = 011a40A72140099Dd9ef26a2564258aDcF48943D6A611B8d204A8A9B08087e8A4ba97C708789F9f912330A94595C466E31cfD72e46c18fd1B2Ee1AFA8a1B421b05;
             },
                         {
                 "public_key" = 011c982c6419f913D94080D4A297caEea6143cfeacd53Ca6C70AEc85fbF27715B3;
                 signature = 0143173e92757d51AC50Ba45C891DA35B52D8CC51A8164C6FC753fd3463BE8B7375281BF7B3968051b8Af856229cA405927508148Fa32771CC29FCc801C4a15706;
             },
                         {
                 "public_key" = 011FbADF1d9d7F8246C36647722423690bC9b28E438d3f08f85bAb006771Ba2229;
                 signature = 01eD145dE844D5B6a6D92b2400eC0dF43Bc6435E0943f5328146a2b5906b034268A5A291da76fC0EB37e3ad003066a9F9e882afa8875c0d2B5C4D8BB6C6758aD0A;
             },
                         {
                 "public_key" = 0128D6b2c3CcDA8E674f73CcF57B6b20a23B5e4439634071C9361992C679A94Ab6;
                 signature = 012c36ce78c393694b223218815a33047bAC45b9CB1728EF7CE0B74242956FD311C2Db4c354a22cA90F38c1aa288141e28fDD6F1D996AEC927D32CB6a66A818002;
             },
                         {
                 "public_key" = 01299Abb48f611203b63c712d840F195d7Ec74454272d3F272dfbf56cc3c3ae744;
                 signature = 01db8489Fd31669B52f2e9D0E2A58E89b1092B77F7EbaAAca2f50b7d68Fa76f8A2e8bBd3aF344d334a3b48188F80107ba43D56c7c077ce123157974D4F5705B300;
             },
                         {
                 "public_key" = 0129A40cF2738f2b74606Ea25a3ddF8Cd88F5f729a1018b929795adaB19D44DC90;
                 signature = 01Fa82cCecf126755Cf3d06c700dD8A0F50BFdfFD34d0FfB790CfBE5d01C00b5556F98c469DD925F27a0ED381777c73e5a396D887CFafBf5E430805148415c5905;
             },
                         {
                 "public_key" = 012b77BfAb443AaE5957d4D2d4991e55f692FA3eB56C2AC1179a188881a575292A;
                 signature = 0140679808DD19CaD4fC3084808e948aDD3fD6B9B4cb0c0925D1395356B0e6839232d91De3d851F0E8831ff25Ee2cCD468A93C2d70EF4136Aa8e12fac01f7bC50A;
             },
                         {
                 "public_key" = 012B7dF800E8Ab659a66162284f080a0fE71f6e9534aDB425649ce6f6eCa7AC7C7;
                 signature = 01b07843f5cadE70359083919d1B139325bC7FB21c5beEE023f03Ceda54a44aa6Be04173726447E81e7cd0a17CD2C78236857a3b4C4A7D48e7A6EAD576c071fA0E;
             },
                         {
                 "public_key" = 012DAD6e750391C0D12891aFA4f27386A1ADfd118068b396165AD8EB9f6a85f1e5;
                 signature = 019868Ee4c18A6733F24324243875A4548146BD4747373E1409CFa1f2Ef8A154149a67B398e3373eB3a1Fe5612debd85b616401Ae35a90E2BBF08d37548272c105;
             },
                         {
                 "public_key" = 01302aAf1DA72670287E9B892c0327A5D0829aA2496db314a587cdF68E58B47ddC;
                 signature = 01e3b94e89CB4eeB8D2e574f6f7B05f54A00a1035cABA2669f5E16347A0DFDdb6beb17A0BF5Df1dFD37F65b46538A048266a7D10420C117d4572a3A127d016EB04;
             },
                         {
                 "public_key" = 01309f108CAb2D5b62DEfdC7c031C8c6e4F1c8094effEEaB155a0a944EF5890fCE;
                 signature = 0118D1eE684757Dc0BFeA72c06472F8601fD51D855f75cAa3FEA6af62337e95575C30024bf19198a5AC9D11ADE5105e62849e8E4e507084FC841B379a7cB1eD90f;
             },
                         {
                 "public_key" = 0132C537377c56FeE29469C2f2484346BA0A008265319D7cd4770e5953C1321EfE;
                 signature = 01578E0D48542e69128A420BD04f8EB465f6479281BAAaa617Aa42e1f39b902eE5aAe2471C97361348A74Ef0f1b5Af372d2B600bB17937CC1f2945347C77d7d20B;
             },
                         {
                 "public_key" = 01358A7e107668aE2Eb092DcFBeB97d2Ec3CC8354d2a77bc8f232fff6630A826c3;
                 signature = 01fbEa13AadE0950c8E0598AF045Bf77342Dfed5689a04cfB6a4cD2BCA2FAB6E4944F5510Db348Eaf807c65f96bFfA7fED249c55E1564a2D2Ed6b0B8B1523F8B03;
             },
                         {
                 "public_key" = 013941026C5347CA9eb6dDfDaD57D2C305c21108b2F3D97a6Bb6E52440a1be9664;
                 signature = 01142b7BEc7Ffcf390A7519EDD5397f38c0B51ccE92dbC561bF142f0e5c2F72152e1599833e135515b83a438A845B3943B08e4078471848E41621b1d7C7E292f09;
             },
                         {
                 "public_key" = 013Cf6D30266728538302eb8130B2336D1CaCA61240c25c362C99a894Fd0B43507;
                 signature = 01daD6695fe1007B462D1f32e9D46C8D3646B01C372A9B133550CC1E124f75F7BBcB6132d58aA28eA52aA4C4daCb5770310A160a95f3822dd921DB7Cd697dE7000;
             },
                         {
                 "public_key" = 01405133E73Ef2946Fe3A2d76A4C75d305a04ad6b969f3c4a8a0d27235eb260f87;
                 signature = 015f8b7e5B6E0DaA6561227aC2507477d4b36E05c9B72F1a44589fFBb65797c3cf3278f14EC1A41842c67Ce19D8Bc4b9A9cE188fD4f860A4c0c7De1c9d9a031B09;
             },
                         {
                 "public_key" = 0140FD354Cc240092f7D0b0BB3ADEd017222f354C2ECd608a68ca33Ada1A70EA53;
                 signature = 01E895d8dC7431c5d66E9E9c28D5A73F04D7108Ba927cED19D602De0A13Dd5500978D71E4e4A44c02e3ACC82DF53b9b648F96C9689774a9bDF23B2B5AaBFEBb709;
             },
                         {
                 "public_key" = 01421fB44078C2eB8d7d3414B81D4D9e81B49983Eb96644A9978782b9aAb0468b4;
                 signature = 01f750Eb1f1a69c549438034e1Ea2738b124E91fd8be2D1c501c0b0B7e1b191cCa44FF70d5a93c147b0Db467f014F2f11C36C78e8Cbb73A33d74A6e6622cbB4603;
             },
                         {
                 "public_key" = 0144e35abc4886168A53338539A8a3649aB1257D9f0C235Ce38961624a025d40dD;
                 signature = 01da10ea13c15e3c1EA3c7B213a3037eD165d82B0AA086388f61c64386a559f8652EBA9B278c520F415626668D8315c97DdFe26949d7D3981C8401535DB3F13903;
             },
                         {
                 "public_key" = 0148D2B4f68aDf837cB06F08925ed4D30aA830Cc66b88533d38adeFDd66B4D51c5;
                 signature = 01dc3050bD7e8607CfFA0cF6137e4f49E546895501247477035A06BB0E78C0f212ABABE7838041972CcEEd4B61f8a5ff87efD8BaCbd859eC5d706D8263513f780C;
             },
                         {
                 "public_key" = 014A9e43acfD9138AF80ea26Ba6621164Bc3fbEadd5bf7973b226f0276969fE55D;
                 signature = 017CB15bF1090E0CcF4cE825017dce21c609f8656D29E6C17C5Db1cD7E15C359E5Fb9D0a59257125889d6139969Fba3A3FFB22bF4680cdcA56f09f2B4C47620700;
             },
                         {
                 "public_key" = 014fa95d1E60f8a5Af1e4118AA14011C61B05847B32548aa0e0419f2dAF09C8923;
                 signature = 01Cf52A31608Cc660156BC4ABa045c4db488da03aE065c75620AC4A88F204123BC443F79674164076206F18D9bAFd77821DCc1A91014567E049f4Ebb4A8404d201;
             },
                         {
                 "public_key" = 0152fCF4e979C1f52793dcA7E509286f7c65DD6fd1A564743045DD37c156DBD118;
                 signature = 01499770D1357960d513C5FE1A64a9ba999518c70282517E5dF8b4Ab1deeFe83914Cd30e9e5f340d46Dc6326585699F287185AD0085a794dB15203E62E993c4d02;
             },
                         {
                 "public_key" = 0154e5b45EAadE5fC8f0afD45624E4B69973d999B42292ca1993D323c98E067732;
                 signature = 01CCe8BC1EC7Ee6A2713094ad46b0C284bB5dBFE62d037D7Db7f8F71bF396495bc237Ca02C9eAD2083D14Ad868f7EB5B4A0b257128b78BBc04220980a1e61C3308;
             },
                         {
                 "public_key" = 01561b9C416F85e9227c41D08B1f20B1abdF34a93C5A84a95e9e0FC5712cd3B9e6;
                 signature = 01a56CD85F1c5B02671a027Eccd99999d80a0E5680855DD31374F71B813fAc44CAA45D085D15DD532B127552835eCD52b422B857A8cCEdfCA2c1bc15F7E1738606;
             },
                         {
                 "public_key" = 0157f18d47996F1bbb059f2043bAfEA9C218D7f50e4d4Dd508BC3661844300C3D1;
                 signature = 01F91E1031848cfcAb2D6F9ff1A32b9e753F04454C36C16FEb4127C833747E6A8e16F9351a000534501Fed4859b9048C42631df67eE2A96544Eec7F0300968aC00;
             },
                         {
                 "public_key" = 0158ED3b452164D0F79e65E05cec9052F6B0aCB6C470159Bd9ed41037bd20C0100;
                 signature = 0144e9fFb9F36b974C8A3d6005B659eeE3842AF9D49F1f86F029F3F45a1b47Ef965c961BAdA225a70acc9F3b1B8F76B73Da8E8f4E8aF4e4409C1CD69124E219F09;
             },
                         {
                 "public_key" = 015c6A4f1b5290E5cD0f63Ca6C69226334b38782fDaDDD3cBB95E4574f3FbFda03;
                 signature = 01dC7E4485A2cF7FA0f7C90e25d1C4036751a9385b20E01A9Eee25bD75D085Add287b3133dD95e5F8901E86e2A82dB0D0D84f2c523a7bf202B1B124C237Bad7608;
             },
                         {
                 "public_key" = 015d2C1e1cFf298962c98D53aA9296376DAa58de8A7DfFA754487467F4C64d0FaE;
                 signature = 01c335792Ad7ef6E01Ede6Db210C7A951A627dF78A71Fb0770702c0c982395E915a9E3F530011310270Aa23522D9CcF1547837D457d24FC46b2dA8584162e7760A;
             },
                         {
                 "public_key" = 0163498976E39A0ccE15dBe9788E357db04C734bc6fBeF4AD2623A014159782BA0;
                 signature = 015792f5b702c1e818C5db7cAe02c97e76d0426aD04307375ee1bA13de40590ed9be7C65F4d04b04E69D53659C50DB05FE054739fD4d6B646D4fA2C2d80f62120C;
             },
                         {
                 "public_key" = 01639CB43fc5D525A01eF3EF3606c7dd44f0aec17243dA5c1b3f504F8C0DB6d30E;
                 signature = 01938f8314243Dd91B3f0b2eF63b146DDd957599E165A6EBCB4c76Dfa698981239771E679b9D61955b8a6304F8995A6C465db21B3124EbD50a89c48f87644bAa0E;
             },
                         {
                 "public_key" = 0164AeCB4375C697Aa4018fE0Ccc9174EaFe573406a837aEEb59a6f435757F62b6;
                 signature = 0137c010Df87513D7221Dd157A7155BDeE5C52Bbb64943966bD5868972E61Fb5204C9D468D68479AEa4d9d6f308f0B05598784Fb095C426B1eA3Bf6A7D32446308;
             },
                         {
                 "public_key" = 01669E9E4329ED78E951Eb02Ca94BB34064aF53ebcd64c90d2622cb83345814e4A;
                 signature = 01C9614c672a5b7770322Ae1F1F98f070c41738FfB1ADEd96a1A415DE6AfD37C3f67D9bCA04e5E603B36832cace9d26C634Cbd32Caf3f814a165118885c9674a0d;
             },
                         {
                 "public_key" = 01696Cb7FC2D348a47E0C23De32b04aaE2E7fb8C94C1d4Da43b5938e4Cc0c5D085;
                 signature = 01A148DecDC28C947eCFc1c724d49B02F63590d67eD5564949D7466A2D7b48c11629cA698e77CE78214dF238AD30EEC4340F87a04CDe79192610d999882669CC03;
             },
                         {
                 "public_key" = 0169a47b13e403c22576113e9693d6fae26eAcFE0CD97478efB99f892B51f9c248;
                 signature = 017d7943b217849B2a39bC081FCACD534Bd66c1A6644bAF3439381544B3BB71b213c92532328391b5451E09D3240653F242A85e5DF1eFA025A09831C42A13AaE02;
             },
                         {
                 "public_key" = 016CB9a5A9128CDeEd92BEa3CE4fFa14b6F849247dd5F14d9779867b45Db457Eb0;
                 signature = 012f7795D8c377793a4C2f49D3176759878C5F6b4e7AC6F60552fAa8c2216c43f93Fba492931c867772aABF4EEe770AF1074512Cead113585d12C50CcfeD2aA50e;
             },
                         {
                 "public_key" = 016E252784fC0b027f993511Bc0fA4305De99b4461022c7BBcfB99FfF0Af67b275;
                 signature = 01ebF434c046F01Ae9D89988b15ef60F02656B6Ce6A5f31B84aF57a51f234adaa4558F4a3EE9657D637Ff8D1548916625EfA52851AB14f35590dDC88545661D602;
             },
                         {
                 "public_key" = 016EE08E3f25921bf062b3Fe3CABD736C266f8437d418299D61ccAD11c6387C8B4;
                 signature = 01C7Ae272f6Db388165E8219945CDC9b9Ed7BedB9Cc99EB4C9C0902681F8f33C973DF245280d8dDc42A85002cFF9910e0B66776Cd9329126F1F00D26C02427470b;
             },
                         {
                 "public_key" = 016f6eD70E4a5aCEc750dc087674e5dE2ad7B6d9595945c4059C5ca1a47d4DD3Ab;
                 signature = 01c8d73139481e9705F626AdFE58391948907C2c3c317b3cC34Cf9Dbf67D6b16d0284ccA7f9591F5A4E236A7C065117ACd572B2574ec1dc59E3764fBD75E63a400;
             },
                         {
                 "public_key" = 01733db90051702370899Eb40a91a8ce70c59bdeB780e79EBBa5C389e3933fC037;
                 signature = 010c22cfc1a6a5f5150EBbdAe87E04b8c2500e8CdccA3ea6F8DaB49b0ABe2d54A5C2c3cDf4B9DEF6253709918b44aecc0e79Ec9130c6365A1ffbADf29053cF9406;
             },
                         {
                 "public_key" = 017399E6fe6c16D6807bCf5706A35ae6eFF577c1eCC06436DDE4a39b0ffe9859a0;
                 signature = 0122b0cc046a5FBB9a5bCF482d3ae25298cddd0690269257c64699617532Fb94c09336c96f10ff69D667a8F4C667cf6fE6E2D2159d86063df4C3472eb3a364250B;
             },
                         {
                 "public_key" = 017b2eC8A8e79D144596459FF48b60434c747f51265393DFDCbDcA9B07797d01cC;
                 signature = 01fDF3F144D9C4D282E601e7A8578Bd77D23213b0c02E699186784763E513FC56DD068BEaFAeFa9406e874055bCefCD39a116C0839071aaF4c5A6EBd455aAF3605;
             },
                         {
                 "public_key" = 017Bf11f01a8c40c072d32B82Ad3F446Ce4be0c017e59f69F3b83E4Ac7cFD8B813;
                 signature = 0111f6B2c0bF6217368106BC286Ba7486ACad10f1D5b30d4c1e134c8712F3e580C53651952470030Aec98b65487d92eAb2F0A71bD4ADb113fBCAd6F7c2b7FDd907;
             },
                         {
                 "public_key" = 017d96B9A63abCB61c870A4F55187a0a7AC24096bdB5fc585C12A686a4D892009e;
                 signature = 01Fd7dfECcb1830F497bbEB499dd7D8F8808C808A878a092BD05F792F05c9729AA661f0630eA44A38764e1F91C4a5Ee459D509A4Cc3612d60c45E77471dF31aa08;
             },
                         {
                 "public_key" = 017d9Aa0b86413d7FF9A9169182c53f0baCAA80D34c211ADAb007ed4876AF17077;
                 signature = 01EFFEFc6D13c039339856C2a01bC86B9BbA7A86687A3B9961cA82a9b2bde4f6EacB867FCFa7879942de49e09C1671CE6b381cc24a230ea1d334baF3fC81d1A706;
             },
                         {
                 "public_key" = 017E32C43D6Fc5B64C1e3a0987e5aff10D1BD796cAaF1a4cAD3a6955Ddc4f2aA2E;
                 signature = 0198BCE88618714DFe135b21dE990D8B631dEB45946E63cb0C17dF3bae2C6ce72eE9e5f94F621B4409a5EF10CaE7838Ee8aee204751E2Dc1D8D2Efe98a2dd32806;
             },
                         {
                 "public_key" = 01832ba5De98Bf18e3E0E9816A091878379e57e962069d5EC1A2d1daA05f652Fb0;
                 signature = 012db4692697225f6BAFD0fE4E74eBecA33EdF7442Cf1A49F79E395b4378dff4553d6bdEED98C705a85a5455227A86B63e32293ABC15314682754d7D6c3720AF01;
             },
                         {
                 "public_key" = 018f8f5e984288E1272196b736a57107B1b8Ff680AE256e77227174e0C443579c2;
                 signature = 0171fDB9320bF6e405d41F727Bd675625A54948BB1B7f5c048035069D3e6828C0fb02c5Be5f95C7515c8247Cf491648d16f3c3C7212996860C7a9cB4771Ab79d0F;
             },
                         {
                 "public_key" = 018F972B76868297F5a3FE2DA8ed57153F35c4B8508C65254F6445259aAd3942f2;
                 signature = 01Ccc3E8489b1d67E5530a8c172a9f2098cCF2D2022e78262170896a5519847E8D818DcF5bFC87D1Cc2E3483F699FeCA6B637D03b8f90332aB15a65184e9eb0a0b;
             },
                         {
                 "public_key" = 01950D2D8fEF54D8810Eb5FA42f543Ad381f973932189DefEB773e5b8A4a8fCEad;
                 signature = 01bF9d3FFf37Bf538FB6B35e5A6695ba52D6a7F38F2130E6549bb634011109bF207fBe0555BD575C7B68C46Dd04A38F2b21544fda07a8c852f761249A3e675Fa04;
             },
                         {
                 "public_key" = 0196948158bF5b35C0c84F680F110B8dEbAA4e7628E13ba336a95651a214d3B9BD;
                 signature = 012b809efaf1580297EDC82D500A63fdFD0535eBd8C1aCDccBFF1777004AcECF4397cb2e8a9a6596940F23770AC5f0eC747E35FACc207c81f89FD0dca4074dd80D;
             },
                         {
                 "public_key" = 019b55177Da7c11428B14e1AaC4DE0674d649EeD66F73B39A5a4b23177287034dF;
                 signature = 01e3007e5c2779afd3a7c2929CBEA9500205240D746B4F2850b9a4786fEb52c0499595Af6F88d496d747c9bc9117A7e8Fc4E10d7ed481629323E2343BE6C5c2f0A;
             },
                         {
                 "public_key" = 019c8766207d0A8A9ae12f3D7B576895080DeAC2eD0CFBfd1250097528A7078B4d;
                 signature = 017D5CF89752B1C664e2EF36e8C4e8d798aDCd50a4677A30584A72Bee0F46270113446eA92F3E333A96A4e630a51942B8CA377964c22781c787a51908Ca6223D0d;
             },
                         {
                 "public_key" = 019cAE8cFa3EB19910Dc046276Ce77B3dC90C6c360237BAD2b45a047d1794Ca938;
                 signature = 0194AF5D9D48a64a6f31b1FD7cA3D93900606AA71f73C319FD9A057841CDa3D4519d2801812fFE6be4c7eBbc8a51a5CFE14CCE1311dB94d12d3F8aE63ed4902a08;
             },
                         {
                 "public_key" = 019cC0cb7bdAb05946C44Df559f32FF676Fa769729F3a338b01aD286BCC756974C;
                 signature = 01DB0D0663D80e93DC2bA3F412d1A88BF802906A3686f26B44fA398517E307a330160381761B3F4ACE6fA4b250dD2a02aa86c06ED4e09b6C5b72E3146c79D54303;
             },
                         {
                 "public_key" = 019e10bA299Fdba84EE5cE1F6984F762bf0d621Eb83e91bC26715c5999393BCA1f;
                 signature = 016DaC12E79C716d54C8711D9f0a0a0b29C5BbC76A0c00d143dde3491cDf2A9350723527A147c65Be2Df8E7000693088B9246e508f97921d49f248fb83Cb3A9D03;
             },
                         {
                 "public_key" = 01A03C687285634A0115C0AF1015aB0a53809f4826EE863c94E32ce48bCfdF447D;
                 signature = 01C45e5858c853ae7Ff2cA3B62a37d8a388256Dc7907A321bd0FbC8D44096B392fA9555206e5C67Cc7eAAdC4e4215944BAe55f1C3E8d0f581E32cA442C81071503;
             },
                         {
                 "public_key" = 01A431208AEC283b8D8b801922a7f0a65Bdb6E8446B275947fEcA8aCA32633A8FE;
                 signature = 01B732C493a559b938B6175679Bc3f4691F770BfD29d2a2a4Ebd39cE6676eD4FF7BC948E2407503F76fc5F71517D2504Bc1842E0F473d5c2943c74e43120fC2d07;
             },
                         {
                 "public_key" = 01aa17F7B9889480B1bD34C3F94F263b229C7a9b01Dd4dda19c2Dd1D38d176c7a0;
                 signature = 01C77dE6fe8926Ae9de29cA4a5D901b3f89D3795Aa858Dd2D5aB25E6d9a2840702c9A9f91a7633197C058eDcc52A3655260fab970F55128c2dCC317c9cd80C7301;
             },
                         {
                 "public_key" = 01ACe6578907Bfe6EbA3a618e863bBE7274284C88e405E2857BE80DD094726a223;
                 signature = 01fe3042B4F77F991ecDAeccDeE83D42655A01c21768CE50f5EA18De3F0D22B1A24B051fcE00a1A39A563D8AC1E0f7e18AE45aAB1A9bE9755959B6Bb6c29C72D0A;
             },
                         {
                 "public_key" = 01Aea86E5FcCDF72DaA7C65Cc8b3d2CA96a006a0dcd70D3617F85FEf00B9d78464;
                 signature = 018F680E3Dd44B646e2f65C9c33af10cBEcD55e5E6eB1067F83b601a50090D9075c06A0e72f81E95E4d9f4F95F78C720846cd493c9f7919f54FBe3AEF0F283bf0A;
             },
                         {
                 "public_key" = 01b09B9CecC7d75C6BfA3D3AA04E2B9639DF38daE7Aa18A5e4AC82679f29a248b5;
                 signature = 01201ea326Fb8F7ECEee26701D7d85A0Dd225D1E0369Bdcf44F1e698C494d9e1F1C08fbA68db49E454578FC36F26edd77E697206Aa1A6B27E5021185e75Bc64809;
             },
                         {
                 "public_key" = 01b0BDC47d7c7A4aE2a46E08A18A9Ef6f441Aa2d876B201C9caD6C593734DCD0fe;
                 signature = 01D411c51bC948240a01D3A2c9CA3D34882B65b94B5A06E4c6E3f79F6434A917f97339c3b36392e16Ba5caCc49B0D5BfE0352151DD4ce67E890BCb8BcE3F5fD304;
             },
                         {
                 "public_key" = 01b4Cab2F166C400D7f637C76256aD0430Df53936AC0a6E1df4c05063b6D014D30;
                 signature = 019627DF5b845dAbc43898b1baa9dCD65f5126Dc54f5234Df5730bBe82F03543c372514bCe98e94DAEBBaEEf3dE9a7C62c4E1195804c1dCef4616C0976c5556507;
             },
                         {
                 "public_key" = 01b5d00a38E1783345fFE0bFa8423e026b76480683E0b19966ee47c7f68a827c00;
                 signature = 01bE25D0542aDB9f96EcF90EF0409479702f78cF0ceC47A2Bdc7d99e16941f7908327Caf1ac7271f0bd9e6257EB30dE1519D0caef7CEA42814Bc86CC29E7681206;
             },
                         {
                 "public_key" = 01B7773eCc2C7B984fa90D75b17f01f2bCE563499c4d7b102E75361E2A1fAD2f40;
                 signature = 010eB21A777ea7ee800436746a811a573A1e8a096E0E460546e41aA54827910Ab622427ba1E2Dd7550E53cd68ac97533b63dE59e3b6443530c70330726BF5CDF0D;
             },
                         {
                 "public_key" = 01B7dE9A3cFf7Aa2492D3194B060D9AF4d75A2a06aB2Fc277046212D11840d8B4F;
                 signature = 01793551dc4bF35D103Fb49c16874Fecadd32c25B907975cf475126674a829EA7387fFC3EF491f52572E654EBc06C4507C6630938aa3ACF213bfC692ab88EB9704;
             },
                         {
                 "public_key" = 01B87CDd890d9084A80e221D0Fa28172Bf1c561F76BA18c5A8eab4031E308A6243;
                 signature = 0191687Bfb51cF96cd21303E6381d93917EC40386D8cFd6FF98dfAC46558f600E7e686a78a0f7D4c89280F96A25c111750EEeDA30d28D5cd3510F80d368Aeb5706;
             },
                         {
                 "public_key" = 01bA0DbAC1BADC60551166B14aA5b3287410cA05d09daDCB3275D7a978f5b5c0ad;
                 signature = 013363D5d4Df389BF46199b4EB24e4df01558c9547eeFE1d17598Cb9D23b0eee1693b0Afcf18ED8f86d7D60734e27BAb1B68fF4373E1ad594c26C96BBba4d14209;
             },
                         {
                 "public_key" = 01bBc59027CcfBBA6C5c07d395B488c1f9d7515A23050Fd9Ffc9bE800c729711fa;
                 signature = 018116aE505F05Af09Cece66fC631102E4f7573e12b7510a9D40f7f815e2efD9D1067F1468d7fBd328a0a1E071adEBff2DE5293060f48EF80f3bdf513BAd610606;
             },
                         {
                 "public_key" = 01Bc4F13011Da02b4BBf9974225F6b1Ff8235a65806AE05f684266dA6a136C521b;
                 signature = 015642E3711ceA4dE16d297861f04C2Cbd085Ba962b479f9B169384DcC3415122D61F9bE59DB5132Ee5D3D096f4A27d64E6D9fab4FD899A0B8F0a1B4B39E6b400b;
             },
                         {
                 "public_key" = 01bd483C29aba4fd119Bd552475362F37A7d4A0D8a2ADCD9Fe89C37d2c74C10c1f;
                 signature = 01C63e6B02f2F57E7458a810886a63eCDC270d8b96581C065E02F0BD8939a377E49442ed18e9f016FafD323213775038F8C255660B037a44EC85C61c7E855B2109;
             },
                         {
                 "public_key" = 01bd8FC6BFab5F7fC0fABdbd04eF6B8Df0c28dAB71A7D2EaA6a7Fa125c835DAbb0;
                 signature = 013Cd19FcAD7BD89C3FF6f9a7fa93A3348908EB84d0893AA076ca518934D0f757d6D8ee1083809e78d13F235D701F823Af360c68D2478e333E9c7a7385FD39B50d;
             },
                         {
                 "public_key" = 01c13172b96F4D9D06Aef5B1f4DaF6384b1318c9dbBb44e0fF37D75055F135b7B8;
                 signature = 01591cFBF591003238AfBFc8C2167B96C624D8cBD79043bd2Cc13dA4214E990e9008096d61722D65c4fc8A42b8558D97e128fcF367073f063107556763826cB90C;
             },
                         {
                 "public_key" = 01C375B425a36dE25Dc325c9182861679dB2f634aBcaCd9ae2ee27B84Ba62AC1F7;
                 signature = 010757905B8b335bf510b2262D3713ad77C09E7d379D5A4A0c13a9D67bECdBd3BBcACaf1c533029225a7b27312eACB71b4207AEa15C67491e44fF3887Db5eF1D06;
             },
                         {
                 "public_key" = 01C437dEFEcd110035669B2C51470AFF9513B1655457cEf841F5423979cBCFb8D8;
                 signature = 0133d0bd32f48917900dB2128DAE477bFed7A791D7b516b85B9cCf25D9d55cCFb4680500264cf4a4625DeBdc0dB96F59c4F6b323d23770DDd4EA7d232E075b410c;
             },
                         {
                 "public_key" = 01cd807fb41345d8dD5A61da7991e1468173acbEE53920E4DFe0D28Cb8825AC664;
                 signature = 0116692274e12BDB11Edad645d420400bCBb3F15Cc9702a9EbcCECcfE0C1003743bb3Db8189485EDaD539eE01c659D0182610e457904d6977D65e8a285c0dba705;
             },
                         {
                 "public_key" = 01Ce901316ACefbd7b18119110a814FC6592b98a2370E0fF47EC143C21b8C7E590;
                 signature = 01f8289fe8950BebF192f8E264e21a81ADCd5326D232f4aD4d37e8cd8D570BD007635A25307abE0fD886c1d7F26ec679E8D0Afc789D2bcfebf649E44F27fb1ed09;
             },
                         {
                 "public_key" = 01Cf402039eDA40f2eD1669cE5e3f4d412313B1D3CEaFB568F8f9CC494a52bF6db;
                 signature = 01ba75027e87126d305670BB30f25Fa44D3d5e9bD2894C357c57Af9DAb035f41E7dA310eae1016239CE41f94286D37C2FfC04D1088651447F894e6F7384BFBA108;
             },
                         {
                 "public_key" = 01d19ea39BB8324d50B33087FDE44C5308eC7b59Bd3bdC6f3146fF2E3f72aEa24C;
                 signature = 01C5fe3556Bb70931b1aF34D2501b5509cF5BfAB25b9376958822C453D1893d67FA920785D9554fB002a06286B4c96877e5089953B3ac65b35A8B548b6C735e009;
             },
                         {
                 "public_key" = 01D2e1392Dbc73DE9F896C62a21163f6B3816C3ec1D6c59Da1600d882E2A788013;
                 signature = 0112818A15dD8BbEEdF9ebD90bdE16eBec2Fa0cCeB98f698b3cEf1B61AC0B70e30242FA0ad4E65Fdf1B8eE563FC80668F95e142D1a64C6E3d45A9f50Bb412DAD09;
             },
                         {
                 "public_key" = 01D949A3a1963DB686607a00862f79B76CEB185FC134d0AeEDb686F1C151f4ae54;
                 signature = 0139D624Eb12499413E70792Cbaf8b6EeAf69904BEcCe905B9a2f36857C1d8bBA3f96F3aF16d9031dd1e74F653A7b6c2f702966A03aC891D19FA34fc347bff9B0A;
             },
                         {
                 "public_key" = 01e27bfadD38d601f4DFBAaEa4691E565DaF732c863deC3575a5e7743C874E5A0a;
                 signature = 018f0F8e09b221b0f384Bdb649B2A8258Bfb9Df6551425c24BabDdA5e12D7f673Be1ee7D36D14fDcF4d255D09BD41dDD712657F684579a3BC37CC4e34C2C005c09;
             },
                         {
                 "public_key" = 01e3552FAD3b10F0C3f6f21065b5cA8b14019D4170511fAA46445902571294bce0;
                 signature = 01e6450C4c608e46D7F0777E0baF7D65CB3590777f2e92E15067ca46cAB7020D8D1d7CD564800fdF551A3651Fb6B66C3DEb91Cb5A52eBF402BED9659a36fcE6d0d;
             },
                         {
                 "public_key" = 01e6c56c86cA97D7387d0c989c061ceeB205eeb04ADf9Ec41569292120ed9aE4a5;
                 signature = 01A8b63bc2B6292CB32C7C7924B57a07B505765bc9040F52654869576094ba73e17079992538E5358E805942dD5c2B524Bb299438Eb11739e06c505Ad4f285a605;
             },
                         {
                 "public_key" = 01f340df2c32F25391e8F7924A99E93caB3A6F230ff7aF1CaCbfC070772cbeBD94;
                 signature = 01F2083606a748076fBE5Eb617f9a0629d74CA8f0E804349A5A9B9266e6b5D7AbC98Ebc74cD8Db878E82c8fcf560c228667C752769F58dcca9dC1AAB885bf46206;
             }
         );
     };
 }, "id": 1]

 */
