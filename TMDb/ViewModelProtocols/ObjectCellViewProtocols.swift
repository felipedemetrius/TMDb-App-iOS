//
//  ObjectCellViewModel.swift
//  TMDb
//
//  Created by Felipe Silva  on 29/10/18.
//  Copyright © 2018 Felipe Silva . All rights reserved.
//

import UIKit

protocol ObjectCellViewDataSource: SetImageViewDelegate {
    
    var title : String? { get }
    var urlImage: String? { get }
}
