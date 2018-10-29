//
//  MovieCollectionViewCell.swift
//  TMDb
//
//  Created by Felipe Silva  on 29/10/18.
//  Copyright © 2018 Felipe Silva . All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel : ObjectCellViewDataSource?{
        didSet {
            observerViewModel()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.masksToBounds = false
        layer.cornerRadius = 8
        
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8
        
        setupShadow()
    }
    
    func observerViewModel(){
        label.text = viewModel?.title
        viewModel?.setImage(imageView: imageView, activityIndicator: activityIndicator, url: viewModel?.urlImage ?? "", placeholder: "placeholder")
    }
    
    override func layoutSubviews() {
        let screenWidth = UIScreen.main.bounds.width
        let width =  screenWidth / 2 - 15
        let height = screenWidth / 2 + screenWidth/5
        
        self.bounds = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: width, height: height)
        super.layoutSubviews()
    }
    
    func setupShadow() {
        
        let screenWidth = UIScreen.main.bounds.width
        let width =  screenWidth / 2 - 15
        let height = screenWidth / 2 + screenWidth/5
        
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.3
        self.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: width, height: height), byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 8, height: 8)).cgPath
    }

}
