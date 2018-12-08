//
//  ScanPresenter.swift
//  Evotest
//
//  Created by Eugene Dimitrow on 12/8/18.
//  Copyright © 2018 Eugene Dimitrov. All rights reserved.
//

import UIKit

class ScanPresenter {
    
    weak var view: ScanViewProtocol?
    private var scanService: ScanService
    
    init(_ view: ScanViewProtocol) {
        
        self.view = view
        self.scanService = ScanService(view.scannerView)
        
        scanService.attachOutput(output: self)

    }
}

extension ScanPresenter: ScanServiceOutput {
    
    func scanSuccessful(_ code: String) {
        
        self.view?.scanSuccessful(nil)
    }
    
    func scanFailed() {
        
        self.view?.scanFailure()
    }
    
}

extension ScanPresenter: ScanPresenterProtocol {
    
    func startScan() {
        
        scanService.startScan()
    }
    
    func stopScan() {
        
        scanService.stopScan()
    }
    
}
