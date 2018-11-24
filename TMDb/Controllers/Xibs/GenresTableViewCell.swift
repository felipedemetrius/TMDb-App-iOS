//
//  GenresTableViewCell.swift
//  TMDb
//
//  Created by Felipe Silva  on 29/10/18.
//  Copyright © 2018 Felipe Silva . All rights reserved.
//

import UIKit

class GenresTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource: [String]?
    @IBOutlet weak var constraintHeightCollection: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        setCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCollectionView(){
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        self.backgroundColor = .clear
        collectionView.backgroundColor = .clear
        collectionView.register(UINib(nibName: "ItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ItemCollectionViewCell")
    }

    func setCell(dataSource: [String]){
        self.dataSource = dataSource
        collectionView.reloadData()
        constraintHeightCollection.constant = collectionView.collectionViewLayout.collectionViewContentSize.height
    }
}

extension GenresTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let items = dataSource?.count, items > 0 else {return 0}
        return items
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let hour = dataSource?[indexPath.row] else {return UICollectionViewCell()}
        
        let cell = getCell(hour: hour, indexPath: indexPath)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let dataSource = dataSource, dataSource.count > 0 else {return CGSize(width: 0, height: 0)}

        let genre = dataSource[indexPath.row]
        
        let font = UIFont.systemFont(ofSize: 14)
        let fontAttributes = [NSAttributedStringKey.font: font]
        let size = (genre as NSString).size(withAttributes: fontAttributes)

        return  CGSize(width: size.width + 12, height: 30)
    }
    
}

extension GenresTableViewCell {
    
    func getCell(hour : String, indexPath: IndexPath) -> ItemCollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as! ItemCollectionViewCell
        
        cell.label.text = hour
        
        return cell
    }
    
}


