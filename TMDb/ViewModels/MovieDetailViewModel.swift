//
//  MovieDetailViewModel.swift
//  TMDb
//
//  Created by Felipe Silva  on 29/10/18.
//  Copyright © 2018 Felipe Silva . All rights reserved.
//

import Foundation

struct MovieDetailViewModel : MovieDetailViewDataSource {
    
    var movie: Dynamic<Movie?>
    var isLoading: Dynamic<Bool>
    
    init(movie: Movie) {
        self.movie = Dynamic(movie)
        self.isLoading = Dynamic(false)
    }
    
}
