//
//  MovieViewProtocols.swift
//  TMDb
//
//  Created by Felipe Silva  on 29/10/18.
//  Copyright © 2018 Felipe Silva . All rights reserved.
//
import Alamofire

protocol MoviesViewDataSource : MoviesViewDelegate {
    
    var service : MovieService { get }
    var isLoadingDatasource: Dynamic<Bool> { get }
    var isLoadingNext: Dynamic<Bool> { get }
    var dataSource : Dynamic<[Movie]> { get }
}

protocol MoviesViewDelegate {
    
    func setDatasource()
    func nextPage()
    func handler(result: Result<[Movie]>)
}
