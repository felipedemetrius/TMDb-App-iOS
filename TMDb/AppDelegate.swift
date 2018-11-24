//
//  AppDelegate.swift
//  TMDb
//
//  Created by Felipe Silva  on 28/10/18.
//  Copyright © 2018 Felipe Silva . All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        setInitialViewController()
        
        return true
    }
    
    func setInitialViewController(){
        
        let viewModel = MoviesViewModel()
        
        let navController = window?.rootViewController as? UINavigationController
        
        let rootViewController = navController?.viewControllers.first as? MoviesViewController
        
        rootViewController?.viewModel = viewModel
    }


}

