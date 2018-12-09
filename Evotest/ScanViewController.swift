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
        
        presenter = ScanPresenter(view: self)
        
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
    
    func scanSuccessful(_ item: ItemModel?) {
        
        if let _ = item {
//            print("\n*** FOUND ITEM: \(model!)")
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let itemDetailsViewController = storyboard.instantiateViewController(withIdentifier: "ItemDetailsViewController") as! ItemDetailsViewController
            itemDetailsViewController.modalPresentationStyle = .overCurrentContext
            itemDetailsViewController.modalTransitionStyle = .crossDissolve
            itemDetailsViewController.item = item
            self.present(itemDetailsViewController, animated: true, completion: nil)
        }
    }
    
    func scanAttemptFailed(_ error: Error) {
        
        print("\n*** Failed with error: \(error)")
    }
}
