//
//  Errors.swift
//  Evotest
//
//  Created by Eugene Dimitrow on 12/12/2018.
//  Copyright © 2018 Eugene Dimitrov. All rights reserved.
//

import Foundation

enum ScanError: Error {
    
    case itemNotFound
    case deviceNotCompatible
    case internetConnectionMissed
    case unableToLoadImageData
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
        case .unableToLoadImageData:
            return "Не удалось загрузить изображение"
        }
    }
}
