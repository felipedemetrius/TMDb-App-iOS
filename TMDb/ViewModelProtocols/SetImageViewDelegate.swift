//
//  SetImageViewDelegate.swift
//  TMDb
//
//  Created by Felipe Silva  on 29/10/18.
//  Copyright © 2018 Felipe Silva . All rights reserved.
//
import UIKit
import Kingfisher

protocol SetImageViewDelegate {
    
    func setImage(imageView: UIImageView, activityIndicator: UIActivityIndicatorView, url: String, placeholder: String?)
}

extension SetImageViewDelegate {
    
    func setImage(imageView: UIImageView, activityIndicator: UIActivityIndicatorView, url: String, placeholder: String? = "") {
        
        guard let url = URL(string: url) else {
            imageView.image = UIImage(named: placeholder ?? "")
            activityIndicator.stopAnimating()
            return
        }
        
        imageView.kf.setImage(with: url, placeholder: UIImage(named: placeholder ?? ""), options: nil, progressBlock: nil) {  (image, error, cache, progress) in
            
            activityIndicator.stopAnimating()
        }
    }
    
}
