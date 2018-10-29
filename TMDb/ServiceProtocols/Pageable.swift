//
//  Pageable.swift
//  TMDb
//
//  Created by Felipe Silva  on 28/10/18.
//  Copyright © 2018 Felipe Silva . All rights reserved.
//

import Foundation
import Alamofire

protocol Pageable: Gettable {
    var page: Int {get set}
    mutating func getNext(_ completionHandler: @escaping (Result<[Self.Data]>) -> Void)
    func getPage(page: Int, completionHandler: @escaping (Result<[Self.Data]>) -> Void)
}

extension Pageable {
    
    mutating func getNext(_ completionHandler: @escaping (Result<[Self.Data]>) -> Void) {
        page += 1
        getPage(page: page, completionHandler: completionHandler)
    }
}
