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
        
        self.toggleButtons(true)
    }
    
    @IBAction func scanAction(_ sender: UIButton) {
        
        presenter.startScan()
        DispatchQueue.main.async { [weak self] in
            
            self?.toggleButtons(false)
        }
    }
    
    @IBAction func cancelScanAction(_ sender: UIButton) {
        
        presenter.stopScan()
        self.toggleButtons(true)        
    }
    
    func toggleButtons(_ enabled: Bool) {
        
        self.cancelScanButton.isEnabled = !enabled
        self.startScanButton.isEnabled = enabled
        
        self.cancelScanButton.backgroundColor = !enabled ? evoBlueColor : evoButtonDisabledColor
        self.startScanButton.backgroundColor = enabled ? evoRedColor : evoButtonDisabledColor
    }
    
    func showAlertWithError(_ message: String)  {
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { _ in
            
            DispatchQueue.main.async { [weak self] in
                
                self?.toggleButtons(true)
            }
        }
        
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
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
            
            DispatchQueue.main.async { [weak self] in
                
                self?.toggleButtons(true)
            }
        }
    }
    
    func scanAttemptFailed(_ error: Error) {
        
        showAlertWithError(error.localizedDescription)
    }
}
