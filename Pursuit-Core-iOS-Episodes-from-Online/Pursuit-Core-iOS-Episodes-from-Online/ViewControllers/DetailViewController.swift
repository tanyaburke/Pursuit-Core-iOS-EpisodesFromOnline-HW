//
//  DetailViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Tanya Burke on 12/27/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var episodeImage: UIImageView!
   var episode: Episode?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadDetails()
             
         }

         
         func loadDetails(){
             guard let episode = episode else{
                 fatalError("unable to access passed information")
             }
            navigationItem.title = "\(episode.name)"
            detailLabel.text = "Season:\(episode.season)  Episode\n\n Description: \(episode.summary)"
             
            episodeImage.getFullImage(with: episode.image?.original ?? "") {[weak self] (result) in
                
                        switch result{
                        case .failure:
                            DispatchQueue.main.sync{
                                self?.episodeImage.image = UIImage(systemName: "exclamationmark.triangle")
                                
                            }
                        case .success(let image):
                            DispatchQueue.main.async {
                                self?.episodeImage.image = image
                                
                            }
                        }
                        
                    }
                }
            }
            
            
            
            
            
