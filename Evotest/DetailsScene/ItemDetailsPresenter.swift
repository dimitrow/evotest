//
//  ItemDetailsPresenter.swift
//  Evotest
//
//  Created by Eugene Dimitrow on 12/12/2018.
//  Copyright © 2018 Eugene Dimitrov. All rights reserved.
//

import UIKit

class ItemDetailsPresenter: ItemDetailsPresenterProtocol {

    weak var view: ItemDetailsViewProtocol?
    private var networkService: NetworkProtocol
    
    init(view: ItemDetailsViewProtocol) {
        
        self.view = view
        self.networkService = NetworkImageDataService()
    }
    
    func downloadImageData(for imageUUID: String) {
        
        NetworkImageDataService().imageDataRequest(imageUUID, completion: { [weak self] imageData in
            
            self?.view?.downloadSuccessful(imageData)
        }, failure: { error in
            
            self.view?.downloadFailed(error)
        })
    }
}
