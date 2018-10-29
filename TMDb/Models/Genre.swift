//
//  Genre.swift
//  TMDb
//
//  Created by Felipe Silva  on 28/10/18.
//  Copyright © 2018 Felipe Silva . All rights reserved.
//

import Foundation
import ObjectMapper

class Genre: Mappable {
    
    var iso_639_1: Int?
    var name: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        iso_639_1 <- map["iso_639_1"]
        name <- map["name"]
    }
    
}
