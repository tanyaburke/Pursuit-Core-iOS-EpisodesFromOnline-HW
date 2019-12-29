//
//  EpisodeViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Tanya Burke on 12/27/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class EpisodeViewController: UIViewController {
    
    
    var chosenShow: Shows?
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var episodes = [Episode](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    private var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        loadEpisodes()
        configureRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadEpisodes), for: .valueChanged)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController, let indexPath = tableView.indexPathForSelectedRow else{
            fatalError("can't segue")
        }
        
        detailVC.episode = episodes[indexPath.row]
    }
    
    func configureRefreshControl(){
        
        refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
    }
    
    
    @objc
    func loadEpisodes(){
        ShowAPICLient.fetchEpisodes(episodeID:  chosenShow?.id ?? 00) {[weak self] (result) in
            DispatchQueue.main.async{
                self?.refreshControl.endRefreshing()
            }
            switch result{
            case .failure:
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error", message: "Error loading Data")
                }
            case .success(let data):
                self?.episodes = data
            }
        }
        
        
    }
}
    extension EpisodeViewController: UITableViewDataSource{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            episodes.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath) 
            let episode = episodes[indexPath.row]
            
            cell.imageView?.getImage(with: episode.image?.original ?? "" , completion: { (result) in
                switch result {
                case .failure:
                    DispatchQueue.main.async{
                        self.showAlert(title: "Error", message: "NO Image")
                    }
                case .success(let image):
                    DispatchQueue.main.async{
                        cell.imageView?.image = image
                    }
                }
            })
            cell.textLabel?.text = episode.name
            cell.detailTextLabel?.text = "Season:\(episode.season)\n Number:\(episode.number)"
            
            
            return cell
        }
        
        
}
