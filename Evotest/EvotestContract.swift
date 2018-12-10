//
//  EvotestContract.swift
//  Evotest
//
//  Created by Eugene Dimitrow on 12/7/18.
//  Copyright © 2018 Eugene Dimitrov. All rights reserved.
//

import UIKit

// MARK: - constants

let requestURLString = "https://catalog.napolke.ru/search/catalog"
let regionUUID = "0c5b2444-70a0-4932-980c-b4dc0d3f02b5"



// MARK: - protocols:

protocol ScanViewProtocol: class {
    
    var scannerView: UIView { get }
    
    func scanSuccessful(_ item: ItemModel?)
    func scanAttemptFailed(_ error: Error)
}

protocol ScanPresenterProtocol: class {
    
    func startScan()
    func stopScan()
}

protocol ScanServiceOutput: class {
    
    func scanSuccessful(_ code: String)
    func scanFailed()
}

// MARK: - errors defenition:

enum ScanError: Error {
    
    case itemNotFound
    case deviceNotCompatible
    case internetConnectionMissed
}

extension ScanError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .itemNotFound:
            return "Товар не найден"
        case .deviceNotCompatible:
            return "Устройство не совместимо"
        case .internetConnectionMissed:
            return "Отсутствует подключение к интернету"
        }
    }
}
