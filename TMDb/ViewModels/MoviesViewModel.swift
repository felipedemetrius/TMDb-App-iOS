//
//  MoviesViewModel.swift
//  TMDb
//
//  Created by Felipe Silva  on 29/10/18.
//  Copyright © 2018 Felipe Silva . All rights reserved.
//

import Alamofire

class MoviesViewModel : MoviesViewDataSource {
    
    var dataSource: Dynamic<[Movie]>
    var isLoadingDatasource: Dynamic<Bool>
    var isLoadingNext: Dynamic<Bool>
    var service = MovieService()
    
    init() {
        
        self.dataSource = Dynamic([])
        self.isLoadingDatasource = Dynamic(false)
        self.isLoadingNext = Dynamic(false)
        self.setDatasource()
    }
    
}

extension MoviesViewModel : MoviesViewDelegate {
    
    @objc func setDatasource() {
        
        isLoadingDatasource.value = true
        service.get(handler)
    }
    
    func nextPage(){
        
        isLoadingNext.value = true
        service.getNext(handler)
    }
    
    func handler(result: Result<[Movie]>){
        
        switch result {
        case .success(let value):
            self.dataSource.value += value
            
        case .failure(let error):
            print(error)
            
        }
        
        self.isLoadingNext.value = false
        self.isLoadingDatasource.value = false
    }
    
}
