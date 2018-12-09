//
//  NetworkService.swift
//  Evotest
//
//  Created by Eugene Dimitrow on 07/12/2018.
//  Copyright © 2018 Eugene Dimitrov. All rights reserved.
//

import UIKit
import Alamofire

class NetworkService: NSObject {

    func basicItemSearchRequestByBarcode(_ barcode: String) {

        let params: [String : Any] = ["text" : barcode, "region" : [regionUUID]]

        request(requestURLString, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { response in
            
            let products: SearchResponseModel = try! JSONDecoder().decode(SearchResponseModel.self, from: response.data!)
 
        }
        
    }
    
}
