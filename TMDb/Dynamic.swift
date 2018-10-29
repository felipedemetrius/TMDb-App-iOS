//
//  Dynamic.swift
//  TMDb
//
//  Created by Felipe Silva  on 29/10/18.
//  Copyright © 2018 Felipe Silva . All rights reserved.
//

class Dynamic<T> {
    typealias Listener = (T) -> ()
    var listener: Listener?
    
    func bind(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ v: T) {
        value = v
    }
}
