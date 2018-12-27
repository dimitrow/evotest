//
//  NetworkSearchService.swift
//  Evotest
//
//  Created by Eugene Dimitrow on 07/12/2018.
//  Copyright © 2018 Eugene Dimitrov. All rights reserved.
//

import UIKit
import Alamofire

class NetworkSearchService: NetworkProtocol {

    func basicItemSearchByBarcodeRequest(_ barcode: String, completion: @escaping (_ item: ItemModel) -> Void, failure: @escaping (_ error: Error) -> Void) {

        guard NetworkReachabilityManager()!.isReachable else {
            failure(ScanError.internetConnectionMissed)
            return
        }

        let params: [String : Any] = ["text" : barcode, "region" : [regionUUID]]

        request(requestURLString, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { response in
            
            do {
                
                let products: SearchResponseModel = try JSONDecoder().decode(SearchResponseModel.self, from: response.data!)
                completion(products.data!.first!)
            } catch {
                failure(ScanError.itemNotFound)
            }

        }
    }
    
}
