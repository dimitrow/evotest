//
//  NetworkImageDataService.swift
//  Evotest
//
//  Created by Eugene Dimitrow on 12/12/2018.
//  Copyright © 2018 Eugene Dimitrov. All rights reserved.
//

import UIKit
import Alamofire

class NetworkImageDataService: NetworkProtocol {
    
    func imageDataRequest(_ imageUUID: String, completion: @escaping (_ imageData: Data) -> Void, failure: @escaping (_ error: Error) -> Void) {
        print("\n *** image")
        guard NetworkReachabilityManager()!.isReachable else {
            failure(ScanError.internetConnectionMissed)
            return
        }
        
        let imageURLstring = imageDownloadURLString
        let imageURL = URL(string: imageURLstring)
        
        request(imageURLstring, method: .get).responseData { response in
            
            //TODO: check data!
            
            guard let imageData = response.data else {
                failure(ScanError.unableToLoadImageData)
                return
            }
            
            completion(imageData)
            
        }
    }
}
