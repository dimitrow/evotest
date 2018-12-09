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
    
    var item: ItemModel?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }

    @IBAction func closeDetailsAction(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
