//
//  GetAuctionInfo.swift
//  SampleRPCCall1
//
//  Created by Hien on 13/12/2021.
//
//https://docs.rs/casper-node/latest/casper_node/rpcs/state/struct.GetAuctionInfo.html
//DATA BACK
/*
 ["id": 1, "result": {
     "api_version" = "1.4.3";
     "auction_state" =     {
         bids =         (
                         {
                 bid =                 {
                     "bonding_purse" = "uref-68f12244CF9e37759aA78E3146C431cC4577Fc122272989b9F9ebF2E8F27d741-007";
                     "delegation_rate" = 10;
                     delegators =                     (
                                                 {
                             "bonding_purse" = "uref-401F87167d733d8DD7D3EFBf135a91cCd42FFFB77b02D4A0075b963f14F1FBb4-007";
                             delegatee = 01001B79b9A6E13d2b96E916f7Fa7Dff40496ba5188479263ca0FB2CCF8B714305;
                             "public_key" = 018b34b15e023844531621cB52d42E216a2ea56034f0F40bF7cee566c32eAe4f83;
                             "staked_amount" = 30268476029;
                         }
                     );
                     inactive = 1;
                     "staked_amount" = 908982507030;
                 };
                 "public_key" = 01001B79b9A6E13d2b96E916f7Fa7Dff40496ba5188479263ca0FB2CCF8B714305;
             },
                         {
                 bid =                 {
                     "bonding_purse" = "uref-33222ffAE1C18188FD1715097D4B0c6f74DDd4C490366905b25439d46bEFAe93-007";
                     "delegation_rate" = 10;
                     delegators =                     (
                     );
                     inactive = 1;
                     "staked_amount" = 943354239674;
                 };
                 "public_key" = 0100D89e0684002F6AC2673aF21954EE2737c276FED07bc22fC40a2EbaC385a3E0;
             },
                         {
                 bid =                 {
                     "bonding_purse" = "uref-802A969b9133cD5a0D8349122f76a54195A2E4B36d3341457dF3B028dD1DB4d4-007";
                     "delegation_rate" = 10;
                     delegators =                     (
                     );
                     inactive = 1;
                     "staked_amount" = 900000000000;
                 };
                 "public_key" = 0100F92443e4D11C5c6716F4D03978530f5F0864b9251aA6B3bC7925E2B55f52a3;
             },
 .....
 ... very long ... discover later
 
 */

import Foundation
class GetAuctionInfo:RpcWithOptionalParams,RpcWithOptionalParamsExt {
    let methodStr : String = "state_get_auction_info"
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
