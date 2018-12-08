//
//  EvotestContract.swift
//  Evotest
//
//  Created by Eugene Dimitrow on 12/7/18.
//  Copyright © 2018 Eugene Dimitrov. All rights reserved.
//

import UIKit


let requestURLString = "https://catalog.napolke.ru/search/catalog"

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
