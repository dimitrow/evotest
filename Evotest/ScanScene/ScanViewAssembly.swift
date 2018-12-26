//
//  ScanViewAssembly.swift
//  Evotest
//
//  Created by Eugene Dimitrow on 26/12/2018.
//  Copyright © 2018 Eugene Dimitrov. All rights reserved.
//

import UIKit

class ScanViewAssembly: SceneSetupProtocol {
    
    static func setUpScene<T>() -> T where T : ReusableView {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController() as ScanViewController
        return viewController as! T
    }
}
