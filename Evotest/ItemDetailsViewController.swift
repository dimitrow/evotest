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
    
    var item: ItemModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpItemView()
        itemDescription.text = item?.itemName ?? ""

    }

    private func setUpItemView() {
        
        itemView.layer.cornerRadius = 10.0
        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = view.bounds
        view.addSubview(blurredEffectView)
        blurredEffectView.contentView.addSubview(itemView)
    }
    
    @IBAction func closeDetailsAction(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
