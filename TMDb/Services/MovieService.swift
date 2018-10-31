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
    private var url: String
    
    init() {
        filters = Parameters()
        url = API.Endpoints.upcomingMovies()
    }
    
    mutating func get(_ completionHandler: @escaping (Result<[Movie]>) -> Void) {
        url = API.Endpoints.upcomingMovies()
        getPage(page: 1, completionHandler: completionHandler)
    }

    mutating func get(nameStartsWith: String? = nil, completionHandler: @escaping (Result<[Movie]>) -> Void) {
        
        url = API.Endpoints.searchMovies()

        var filters = Parameters()
        filters["include_adult"] = true
        filters["query"] = nameStartsWith

        self.filters.merge(dictionary: filters)
        
        getPage(page: 1, completionHandler: completionHandler)
    }

    mutating func get(id: Int, completionHandler: @escaping (Result<Movie>) -> Void) {

        url = API.Endpoints.movie(id: id)
        
        var filters = Parameters()
        filters["api_key"] = API.key
        
        getObject(fromURL: url, parameters: filters, encoding: URLEncoding.queryString, completionHandler: completionHandler)
    }

}

extension MovieService : Pageable {
    
    func getPage(page: Int, completionHandler: @escaping (Result<[Movie]>) -> Void) {
        
        var params = filters

        params["page"] = page
        params["api_key"] = API.key

        getArray(fromURL: url, parameters: params, encoding: URLEncoding.queryString, keyPath: "results", completionHandler: completionHandler)
    }
    
}
