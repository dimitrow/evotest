//
//  ItemDetailsViewController.swift
//  Evotest
//
//  Created by Eugene Dimitrow on 12/9/18.
//  Copyright © 2018 Eugene Dimitrov. All rights reserved.
//

import UIKit

class ItemDetailsViewController: UIViewController {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemDescription: UILabel!
    @IBOutlet weak var itemView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var item: ItemModel?
    var presenter: ItemDetailsPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpItemView()
        setUpItemImage()
        itemDescription.text = item?.itemName ?? ""

    }

    private func setUpItemView() {
        
        itemView.layer.cornerRadius = 10.0
        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = view.bounds
        view.addSubview(blurredEffectView)
        blurredEffectView.contentView.addSubview(itemView)
        activityIndicator.isHidden = true
        itemImage.image = nil
    }
    
    private func setUpItemImage() {
        
        if let imageUUID = item?.mainPictureUUID {
            
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            presenter = ItemDetailsPresenter(view: self)
            presenter.downloadImageData(for: imageUUID)
        } else {
            itemImage.image = UIImage(named: "missedItemPlaceholder")
        }
    }
    
    @IBAction func closeDetailsAction(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
}

extension ItemDetailsViewController: ItemDetailsViewProtocol {
    
    func downloadSuccessful(_ imageData: Data) {
        
        DispatchQueue.main.async { [weak self] in
            
            self?.activityIndicator.stopAnimating()
            self?.activityIndicator.isHidden = true
            self?.itemImage.image = UIImage(data: imageData)
        }
    }
    
    func downloadFailed(_ error: Error) {
        
        DispatchQueue.main.async { [weak self] in
            
            self?.activityIndicator.stopAnimating()
            self?.activityIndicator.isHidden = true
            self?.itemImage.image = UIImage(named: "missedItemPlaceholder")
        }
        
        // something wrong with image url, or currupted image data received from server
        // there's no need to bother user, but developers need to be warned
    }
}
