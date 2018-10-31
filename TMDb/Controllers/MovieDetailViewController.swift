//
//  MovieDetailViewController.swift
//  TMDb
//
//  Created by Felipe Silva  on 29/10/18.
//  Copyright © 2018 Felipe Silva . All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var labelMessageResults: UILabel!
    
    private var imageHeaderView  : UIImageView!
    
    var viewModel: MovieDetailViewDataSource? {
        didSet {
            observerViewModel()
        }
    }
    
    private var isLoading = false {
        didSet{
            if isLoading {
                activityIndicator.startAnimating()
                labelMessageResults.isHidden = true
            } else {
                activityIndicator.stopAnimating()
                
                if viewModel?.movie.value == nil {
                    labelMessageResults.isHidden = false
                }
            }
            tableView.reloadData()
        }
    }
    
    enum Sections : Int {
        case Description = 0
        case Release
        case Genres
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        setTableView()
        addHeaderTableView()
        observerViewModel()
    }
    
    
    
    private func configureViewController(){
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationItem.largeTitleDisplayMode = .automatic
            
            if let topItem = navigationController?.navigationItem {
                topItem.backBarButtonItem  = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            }
            
            if DeviceType.IS_IPHONE_5_OR_LESS {
                navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16)]
                
            } else {
                navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20)]
            }
        } else {
            // Fallback on earlier versions
        }
        
    }

    fileprivate func observerViewModel(){
        
        if !isViewLoaded {
            return
        }
        
        guard let viewModel = viewModel else {
            return
        }
        
        viewModel.isLoading.bind { [weak self] in
            self?.isLoading = $0
        }
        
        title = viewModel.movie.value?.original_title 
        
        viewModel.setImage(imageView: imageHeaderView, activityIndicator: activityIndicator, url: viewModel.movie.value?.urlPosterImage ?? "")
        
    }
    
    private func setTableView(){
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none

        tableView.register(UINib(nibName: "DescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "DescriptionTableViewCell")
        tableView.register(UINib(nibName: "GenresTableViewCell", bundle: nil), forCellReuseIdentifier: "GenresTableViewCell")

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 600
    }
    
    func addHeaderTableView(){
        
        tableView.setContentOffset(CGPoint.zero, animated:false)
        
        let headerHeight = view.frame.size.height / 3
        
        imageHeaderView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: headerHeight))
        imageHeaderView.contentMode = UIViewContentMode.scaleToFill
        imageHeaderView.clipsToBounds = true
        
        let tableHeaderView = UIView(frame:CGRect(x: 12, y: 120, width: view.frame.size.width, height: headerHeight))
        tableHeaderView.backgroundColor = UIColor.white
        tableHeaderView.addSubview(imageHeaderView)
        
        tableView.tableHeaderView = tableHeaderView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

}

extension MovieDetailViewController : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let yPos = -scrollView.contentOffset.y
        if yPos > 0 {
            
            var imgRect = imageHeaderView.frame
            imgRect.origin.y = scrollView.contentOffset.y
            imgRect.size.height = (view.frame.size.height / 3) + yPos
            imageHeaderView.frame = imgRect
        }
    }
}

extension MovieDetailViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let movie = viewModel?.movie.value else {return UITableViewCell()}
        
        if indexPath.section == Sections.Description.rawValue {
            
            if let descrition = movie.overview, descrition != "" {
                return getDescriptionTableViewCell(description: descrition, indexPath: indexPath)
            } else {
                return getDescriptionTableViewCell(description: "No description available", indexPath: indexPath)
            }
            
            
        } else if indexPath.section == Sections.Genres.rawValue {
            if let genresNames = movie.genres?.names {
                return getGenresTableViewCell(genres: genresNames, indexPath: indexPath)

            } else {
                return getDescriptionTableViewCell(description: "No genre identified", indexPath: indexPath)

            }

        } else if indexPath.section == Sections.Release.rawValue {
            
            if let descrition = movie.release_date, descrition != "" {
                
                return getDescriptionTableViewCell(description: descrition, indexPath: indexPath)
            } else {
                return getDescriptionTableViewCell(description: "No date release available", indexPath: indexPath)
            }

            
        }
        
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case Sections.Genres.rawValue:
            return 1
        case Sections.Description.rawValue:
            return 1
        case Sections.Release.rawValue:
            return 1
        default:
            return 0
            
        }
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 44
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case Sections.Genres.rawValue:
            return "Genres"
        case Sections.Description.rawValue:
            return "Overview"
        case Sections.Release.rawValue:
            return "Date of Release"
        default:
            return nil
        }
        
    }
    
    
}

extension MovieDetailViewController {
    
    
    internal func getDescriptionTableViewCell(description: String, indexPath: IndexPath)-> DescriptionTableViewCell{
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell", for: indexPath) as! DescriptionTableViewCell

        cell.label.text = description
        
        return  cell
    }
    
    internal func getGenresTableViewCell(genres: [String], indexPath: IndexPath)-> GenresTableViewCell{
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "GenresTableViewCell", for: indexPath) as! GenresTableViewCell
        
        cell.setCell(dataSource: genres)
        
        return  cell
    }

}

