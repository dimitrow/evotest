//
//  AssembleContract.swift
//  Evotest
//
//  Created by Eugene Dimitrow on 24/12/2018.
//  Copyright © 2018 Eugene Dimitrov. All rights reserved.
//

import UIKit

protocol ReusableView: class {}

extension ReusableView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UIViewController: ReusableView { }

extension UIStoryboard {
    
    func instantiateViewController<T>() -> T where T: ReusableView {
        return instantiateViewController(withIdentifier: T.reuseIdentifier) as! T
    }
}


