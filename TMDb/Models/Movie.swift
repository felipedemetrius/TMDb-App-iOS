//
//  Movie.swift
//  TMDb
//
//  Created by Felipe Silva  on 28/10/18.
//  Copyright © 2018 Felipe Silva . All rights reserved.
//

import Foundation
import ObjectMapper

class Movie: Mappable {
    
    var id: Int?
    var vote_count: Int?
    var video: Bool?
    var vote_average: Int?
    var title: String?
    var popularity: Double?
    var poster_path: String?
    var original_language: String?
    var original_title: String?
    var genre_ids: [Int]?
    var backdrop_path: String?
    var adult: Bool?
    var overview: String?
    var release_date: String?
    
    var belongs_to_collection: String?
    var budget: Int?
    var genres: [Genre]?
    var homepage: String?
    var imdb_id: String?
    var revenue: Int?
    var runtime: Int?
    var status: String?
    var tagline: String?
    var production_countries: [ProductionCountry]?
    var spoken_languages: [SpokenLanguage]?
    
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        vote_count <- map["vote_count"]
        video <- map["video"]
        vote_average <- map["vote_average"]
        popularity <- map["popularity"]
        poster_path <- map["poster_path"]
        original_language <- map["original_language"]
        original_title <- map["original_title"]
        genre_ids <- map["genre_ids"]
        backdrop_path <- map["backdrop_path"]
        adult <- map["adult"]
        overview <- map["overview"]
        release_date <- map["release_date"]
        
        belongs_to_collection <- map["belongs_to_collection"]
        budget <- map["budget"]
        genres <- map["genres"]
        homepage <- map["homepage"]
        imdb_id <- map["imdb_id"]
        revenue <- map["revenue"]
        runtime <- map["runtime"]
        status <- map["status"]
        tagline <- map["tagline"]
        production_countries <- map["production_countries"]
        spoken_languages <- map["spoken_languages"]
    }
    
}
