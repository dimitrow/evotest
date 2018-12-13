//
//  NetworkContract.swift
//  Evotest
//
//  Created by Eugene Dimitrow on 12/12/2018.
//  Copyright © 2018 Eugene Dimitrov. All rights reserved.
//

import Foundation

protocol NetworkProtocol: class {
    
    func basicItemSearchByBarcodeRequest(_ barcode: String, completion: @escaping (_ item: ItemModel) -> Void, failure: @escaping (_ error: Error) -> Void)
    func imageDataRequest(_ imageUUID: String, completion: @escaping (_ imageData: Data) -> Void, failure: @escaping (_ error: Error) -> Void)
}

extension NetworkProtocol {
    
    func basicItemSearchByBarcodeRequest(_ barcode: String, completion: @escaping (_ item: ItemModel) -> Void, failure: @escaping (_ error: Error) -> Void) {
        
    }
    
    func imageDataRequest(_ imageUUID: String, completion: @escaping (_ imageData: Data) -> Void, failure: @escaping (_ error: Error) -> Void) {
        
    }
}
