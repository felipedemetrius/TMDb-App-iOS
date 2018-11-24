//
//  Company.swift
//  TMDb
//
//  Created by Felipe Silva  on 28/10/18.
//  Copyright © 2018 Felipe Silva . All rights reserved.
//

import Foundation
import ObjectMapper

class Company: Mappable {
    
    var id: Int?
    var logo_path: String?
    var name: String?
    var origin_country: String?

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        logo_path <- map["logo_path"]
        name <- map["name"]
        origin_country <- map["origin_country"]
    }
    
}
