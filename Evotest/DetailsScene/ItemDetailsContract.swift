//
//  ItemDetailsContract.swift
//  Evotest
//
//  Created by Eugene Dimitrow on 12/12/2018.
//  Copyright © 2018 Eugene Dimitrov. All rights reserved.
//

import Foundation

protocol ItemDetailsViewProtocol: class {
    
    func downloadSuccessful(_ imageData: Data)
    func downloadFailed(_ error: Error)
}

protocol ItemDetailsPresenterProtocol: class {
    
    func downloadImageData(for imageUUID: String)
}
