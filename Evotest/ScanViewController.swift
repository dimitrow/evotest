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
    @IBOutlet weak var startScanButton: UIButton!
    @IBOutlet weak var cancelScanButton: UIButton!
    
    var presenter: ScanPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = ScanPresenter(view: self)
        
        // initial state:
        cancelScanButton.isUserInteractionEnabled = false
        startScanButton.isUserInteractionEnabled = true
    }
    
    @IBAction func scanAction(_ sender: UIButton) {
        
        presenter.startScan()
        DispatchQueue.main.async { [weak self] in
            self?.cancelScanButton.isUserInteractionEnabled = true
            self?.startScanButton.isUserInteractionEnabled = false
        }
    }
    
    @IBAction func cancelScanAction(_ sender: UIButton) {
        
        presenter.stopScan()
        DispatchQueue.main.async { [weak self] in
            self?.cancelScanButton.isUserInteractionEnabled = false
            self?.startScanButton.isUserInteractionEnabled = true
        }
    }
    
    func showAlertWithError(_ title: String)  {
        
        print("\n*** Failed with error: \(title)")
    }
}

extension ScanViewController: ScanViewProtocol {
    
    var scannerView: UIView {
        return scanView
    }
    
    func scanSuccessful(_ item: ItemModel?) {
        
        if let _ = item {
            print("\n*** FOUND ITEM: \(item!)")
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let itemDetailsViewController = storyboard.instantiateViewController(withIdentifier: "ItemDetailsViewController") as! ItemDetailsViewController
            itemDetailsViewController.modalPresentationStyle = .overCurrentContext
            itemDetailsViewController.modalTransitionStyle = .crossDissolve
            itemDetailsViewController.item = item
            self.present(itemDetailsViewController, animated: true, completion: nil)
        }
    }
    
    func scanAttemptFailed(_ error: Error) {
        
        showAlertWithError(error.localizedDescription)
    }
}
