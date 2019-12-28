//
//  ViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Benjamin Stone on 9/5/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class TvShowViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    var shows = [Shows](){
        didSet{
            DispatchQueue.main.async{
            self.tableView.reloadData()
        }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        loadShows(searchTerm: "girls")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let episodeVC = segue.destination as? EpisodeViewController, let indexPath = tableView.indexPathForSelectedRow else{
            fatalError("cant segue")
        }
        episodeVC.chosenShow = shows[indexPath.row]
    }
   
   private func loadShows(searchTerm: String){
    ShowAPICLient.fetchShows(query: searchTerm) {[weak self] (result) in
        switch result{
        case .failure(let appError):
            DispatchQueue.main.async {
                self?.showAlert(title: "Unable to load Shows", message: "\(appError)")
            }
        case .success(let dataArray):
            self?.shows = dataArray
        }
    }
    }
}



extension TvShowViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? CustomTableViewCell else{
                fatalError("could not access CustomCell")
            }
            let show = shows[indexPath.row]
            cell.configureCell(show: show)
            return cell
        }
        
    
    
    
}

extension TvShowViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 100
      }
}

extension TvShowViewController: UISearchBarDelegate {
   func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            guard let searchQuery = searchBar.text else{
                DispatchQueue.main.async {
                self.showAlert(title: "Error", message: "Please type in a search term")
                
            }
                return
            }
            loadShows(searchTerm: searchQuery)
            
        }
        
        
    }
