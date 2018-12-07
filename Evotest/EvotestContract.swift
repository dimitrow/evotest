//
//  EvotestContract.swift
//  Evotest
//
//  Created by Eugene Dimitrow on 12/7/18.
//  Copyright © 2018 Eugene Dimitrov. All rights reserved.
//

import UIKit

protocol ScanViewProtocol: class {
    
    var scannerView: UIView { get }
    
    func codeScanned(_ code: String)
    func scannerFailure()
}

protocol ScanPresenterProtocol: class {
    
    func startScan()
    func stopScan()
    
}

protocol ScanServiceOutput: class {
    
    func scanSuccessfull(with code: String)
}
