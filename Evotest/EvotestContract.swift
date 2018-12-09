//
//  EvotestContract.swift
//  Evotest
//
//  Created by Eugene Dimitrow on 12/7/18.
//  Copyright © 2018 Eugene Dimitrov. All rights reserved.
//

import UIKit


let requestURLString = "https://catalog.napolke.ru/search/catalog"
let regionUUID = "0c5b2444-70a0-4932-980c-b4dc0d3f02b5"

protocol ScanViewProtocol: class {
    
    var scannerView: UIView { get }
    
    func scanSuccessful(_ model: ItemModel?)
    func scanFailure()
}

protocol ScanPresenterProtocol: class {
    
    func startScan()
    func stopScan()
}

protocol ScanServiceOutput: class {
    
    func scanSuccessful(_ code: String)
    func scanFailed()
}
