//
//  SignInViewController.swift
//  Evotest
//
//  Created by Eugene Dimitrow on 25/12/2018.
//  Copyright © 2018 Eugene Dimitrov. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

class SignInAssembly {
    
    static func setupScene() -> SignInViewController {
        
        let viewController = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController() as SignInViewController
        
//        let interactor = DetailsInteractor()
//        let presenter = DetailsPresenter(interactor)
//        viewController.presenter = presenter
//        
//        presenter.attachView(viewController)
//        interactor.attachOutput(presenter)
        
        return viewController
    }
}
