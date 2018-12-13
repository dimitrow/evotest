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
    private var networkService: NetworkProtocol
    
    init(view: ScanViewProtocol) {
        
        self.view = view
        self.scanService = ScanService(view.scannerView)
        self.networkService = NetworkSearchService()
        self.scanService.attachOutput(output: self)
    }
}

extension ScanPresenter: ScanServiceOutput {
    
    func scanSuccessful(_ code: String) {
        
        networkService.basicItemSearchByBarcodeRequest(code, completion: { [weak self] item in
            self?.view?.scanSuccessful(item)
        }, failure: { [weak self] error in
            self?.view?.scanAttemptFailed(error)
        })
    }
    
    func scanFailed() {
        
        view?.scanAttemptFailed(ScanError.deviceNotCompatible)
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
