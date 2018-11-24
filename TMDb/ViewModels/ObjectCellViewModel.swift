//
//  ObjectCellViewModel.swift
//  TMDb
//
//  Created by Felipe Silva  on 29/10/18.
//  Copyright © 2018 Felipe Silva . All rights reserved.
//

import Foundation

struct ObjectCellViewModel: ObjectCellViewDataSource {
    
    
    var title: String?
    var urlImage: String?
    
    init(title: String, url: String) {
        self.title = title
        self.urlImage = url
    }
}
