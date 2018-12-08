//
//  ScanViewController.swift
//  Evotest
//
//  Created by Eugene Dimitrow on 07/12/2018.
//  Copyright © 2018 Eugene Dimitrov. All rights reserved.
//

import UIKit
import AVFoundation

class ScanViewController: UIViewController {

    @IBOutlet weak var scanView: UIView!
    
    var presenter: ScanPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = ScanPresenter(self)
        
    }
    
    @IBAction func scanAction(_ sender: UIButton) {
        
        presenter.startScan()
    }
    
    @IBAction func cancelScanAction(_ sender: UIButton) {
        
        presenter.stopScan()
    }
    
}

extension ScanViewController: ScanViewProtocol {
    
    var scannerView: UIView {
        return scanView
    }
    
    func scanSuccessful(_ model: ItemModel?) {
        
    }
    
    func scanFailure() {
        
        print("Device is not compatible")
        
    }
}
