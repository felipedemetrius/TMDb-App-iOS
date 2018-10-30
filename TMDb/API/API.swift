//
//  API.swift
//  TMDb
//
//  Created by Felipe Silva  on 28/10/18.
//  Copyright © 2018 Felipe Silva . All rights reserved.
//

import Foundation

struct API {
    
    static let key = "c5850ed73901b8d268d0898a8a9d8bff"
    
    static let host = "https://api.themoviedb.org/3/"
    
    struct Endpoints {
        
        public static func upcomingMovies() -> String {
            return host + "movie/upcoming"
        }
        
        public static func searchMovies() -> String {
            return host + "search/movie"
        }

    }
    
}
