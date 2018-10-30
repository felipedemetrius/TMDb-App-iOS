//
//  ViewController.swift
//  TMDb
//
//  Created by Felipe Silva  on 28/10/18.
//  Copyright © 2018 Felipe Silva . All rights reserved.
//

import UIKit
import Alamofire

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var labelMessage: UILabel!
    
    @IBOutlet weak var activityIndicatorNext: UIActivityIndicatorView!
    var searchController : UISearchController!
    

    private var isLoadingDataSource = false {
        didSet{
            if isLoadingDataSource {
                activityIndicator.startAnimating()
                labelMessage.isHidden = true
                
            } else {
                activityIndicator.stopAnimating()
                
                if viewModel?.dataSource.value == nil || viewModel?.dataSource.value.count == 0 {
                    
                    labelMessage.isHidden = false
                }
                
            }
            collectionView.reloadData()
        }
    }
    
    fileprivate var isLoadingNext = false {
        didSet {
            if isLoadingNext {
                activityIndicatorNext.startAnimating()
            } else {
                activityIndicatorNext.stopAnimating()
            }
        }
    }
    
    var viewModel : MoviesViewModel? {
        didSet {
            observerViewModel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UPCOMING MOVIES"
        observerViewModel()
        configureViewController()
        configureSearchBarController()
        configureCollectionView()
    }
    
    private func configureViewController(){
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationItem.largeTitleDisplayMode = .automatic
            
            if let topItem = navigationController?.navigationItem {
                topItem.backBarButtonItem  = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            }
            
            if DeviceType.IS_IPHONE_5_OR_LESS {
                navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20)]
                
            } else {
                navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 26)]
            }
        } else {
            // Fallback on earlier versions
        }
        
    }

    
    private func configureSearchBarController(){
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchBar.delegate = self
    }
    
    
    private func configureCollectionView(){
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        
        let screenWidth = UIScreen.main.bounds.width
        
        layout.itemSize = CGSize(width: screenWidth / 2 - 15, height: screenWidth / 2 + screenWidth/5)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 7.5

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = layout
        
        collectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCollectionViewCell")
    }
    
    
    fileprivate func observerViewModel(){
        
        if !isViewLoaded {
            return
        }
        
        guard let viewModel = viewModel else {
            return
        }
        
        viewModel.isLoadingDatasource.bind { [weak self] in
            self?.isLoadingDataSource = $0
        }
        
        viewModel.isLoadingNext.bind { [weak self] in
            self?.isLoadingNext = $0
        }
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "goToDetailMovie" {
            
            let vc = segue.destination as? MovieDetailViewController
            
            if let movie = sender as? Movie {
                let viewModel = MovieDetailViewModel(movie: movie)
                
                vc?.viewModel = viewModel
            }
        }

    }

    
    @IBAction func search(_ sender: UIBarButtonItem) {
        
        searchController.searchBar.placeholder = "Search by name"
        present(searchController, animated: true, completion: nil)
    }
    
}

extension MoviesViewController : UISearchBarDelegate{
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        //performSegue(withIdentifier: "goToSearch", sender: searchController.searchBar.text)
        searchController.searchBar.text = ""
    }
}

extension MoviesViewController : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let maximumOffset = scrollView.contentSize.height - self.collectionView.frame.size.height
        
        if viewModel?.dataSource.value.count == 0 {
            return
        }
        
        if  maximumOffset - scrollView.contentOffset.y <= 0  {
            if !isLoadingNext {
                viewModel?.nextPage()
            }
        }
    }
}

extension MoviesViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToDetailMovie", sender: viewModel?.dataSource.value[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let screenWidth = UIScreen.main.bounds.width
        
        return CGSize(width: screenWidth/2 - 15, height: screenWidth/2 + screenWidth/5);
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel?.dataSource.value.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let movie = viewModel?.dataSource.value[indexPath.row] else {return UICollectionViewCell()}
        
        let cell = getCell(movie: movie, indexPath: indexPath)
        
        return cell
    }
    
}

extension MoviesViewController {
    
    func getCell(movie : Movie, indexPath: IndexPath) -> MovieCollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        
        let viewModelCell = ObjectCellViewModel(title: movie.original_title ?? "", url: movie.urlPosterImage ?? "")
        
        cell.viewModel = viewModelCell
        
        return cell
    }
    
}
