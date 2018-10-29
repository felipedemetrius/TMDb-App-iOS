//
//  ViewController.swift
//  TMDb
//
//  Created by Felipe Silva  on 28/10/18.
//  Copyright © 2018 Felipe Silva . All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    var service = MovieService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        service.get(handler)
        service.getNext(handler)
    }

    func handler(result: Result<[Movie]>){
        
        switch result {
        case .success(let value):
            print(value.toJSON())
            
        case .failure(let error):
            print(error)
            
        }
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

