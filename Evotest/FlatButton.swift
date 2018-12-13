//
//  FlatButton.swift
//  Evotest
//
//  Created by Eugene Dimitrow on 12/11/18.
//  Copyright © 2018 Eugene Dimitrov. All rights reserved.
//

import UIKit

class FlatButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 4.0
    }
}
