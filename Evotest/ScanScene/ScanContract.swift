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
    
    func scanSuccessful(_ item: ItemModel?)
    func scanAttemptFailed(_ error: Error)
}

protocol ScanPresenterProtocol: class {
    
    func startScan()
    func stopScan()
}

protocol ScanServiceOutput: class {
    
    func scanSuccessful(_ code: String)
    func scanFailed()
}
