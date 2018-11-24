//
//  Dictionary.swift
//  TMDb
//
//  Created by Felipe Silva  on 29/10/18.
//  Copyright © 2018 Felipe Silva . All rights reserved.
//

import Foundation

extension Dictionary{
        
    mutating func merge(dictionary: Dictionary<Key,Value>){
        
        for (key, value) in dictionary {
            self[key] = value
        }
    }
}
