//
//  MovieService.swift
//  TMDb
//
//  Created by Felipe Silva  on 28/10/18.
//  Copyright © 2018 Felipe Silva . All rights reserved.
//

import Foundation
import Alamofire

struct MovieService: Gettable {
    
    var page: Int = 1
    typealias Data = Movie
    private var filters: Parameters
    
    init() {
        filters = Parameters()
    }
    
    func get(_ completionHandler: @escaping (Result<[Movie]>) -> Void) {
        getPage(page: 1, completionHandler: completionHandler)
    }
    
}

extension MovieService : Pageable {
    
    func getPage(page: Int, completionHandler: @escaping (Result<[Movie]>) -> Void) {
        
        let url = API.Endpoints.upcomingMovies()
        
        var params = filters

        params["page"] = page
        params["api_key"] = API.key

        
        get(fromURL: url, parameters: params, encoding: URLEncoding.queryString, keyPath: "results", completionHandler: completionHandler)
    }
    
}
