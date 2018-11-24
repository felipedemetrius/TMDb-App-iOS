//
//  MovieDetailViewModel.swift
//  TMDb
//
//  Created by Felipe Silva  on 29/10/18.
//  Copyright © 2018 Felipe Silva . All rights reserved.
//

import Foundation
import Alamofire

struct MovieDetailViewModel : MovieDetailViewDataSource {
    
    var movie: Dynamic<Movie?>
    var isLoading: Dynamic<Bool>
    var service = MovieService()

    init(movie: Movie) {
        self.movie = Dynamic(movie)
        self.isLoading = Dynamic(false)
        if let id = movie.id {
            self.setMovieDetail(id: id)
        }
        
    }
    
}

extension MovieDetailViewModel : MovieDetailViewDelegate {
    
    mutating func setMovieDetail(id: Int) {
        isLoading.value = true
        service.get(id: id, completionHandler: handler)
    }
    
    func handler(result: Result<Movie>){
        
        switch result {
        case .success(let value):
            self.movie.value = value
            
        case .failure(let error):
            print(error)
            
        }
        
        self.isLoading.value = false
    }
}
