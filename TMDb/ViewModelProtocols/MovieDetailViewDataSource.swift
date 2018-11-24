//
//  MovieDetailDataSource.swift
//  TMDb
//
//  Created by Felipe Silva  on 29/10/18.
//  Copyright © 2018 Felipe Silva . All rights reserved.
//

import UIKit
import Foundation
import Alamofire

protocol MovieDetailViewDataSource : SetImageViewDelegate {
    
    var isLoading: Dynamic<Bool> { get }
    var movie : Dynamic<Movie?> { get }
    var service : MovieService { get }
}

protocol MovieDetailViewDelegate: MovieDetailViewDataSource {
    mutating func setMovieDetail(id: Int)
    func handler(result: Result<Movie>)
}
