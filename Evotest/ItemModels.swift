//
//  ItemModels.swift
//  Evotest
//
//  Created by Eugene Dimitrow on 07/12/2018.
//  Copyright © 2018 Eugene Dimitrov. All rights reserved.
//

import UIKit

struct SearchResponseModel: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case data
        case result
    }
    
    var data: [ItemModel]?
    var result: Int?
}

struct ItemModel: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case itemName = "name"
        case itemImageUUIDs = "images"
    }
    
    var itemName: String?
    var itemImageUUIDs: [String]?
    
    var mainPictureUUID: String? {
        return itemImageUUIDs?.first
    }
}


