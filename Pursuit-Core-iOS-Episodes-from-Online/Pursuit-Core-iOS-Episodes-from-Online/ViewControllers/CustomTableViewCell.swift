//
//  CustomTableViewCell.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Tanya Burke on 12/27/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit


class CustomTableViewCell: UITableViewCell {

    
    @IBOutlet weak var showImage: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    

  
    func configureCell(show: Shows){
        label.text = """
        \(show.name)\n\(show.rating)
        
        """
        guard let imageURL = show.image?.medium else {
            showImage.image = UIImage(systemName: "mic.fill")
            
            return
        }
            showImage.getImage (with: imageURL) {[weak self] (result) in
                switch result{
                case .failure:
                    DispatchQueue.main.async{
                        self?.showImage.image = UIImage(systemName: "exclamationmark.triangle.fill")
                        
                    }
                case .success(let image):
                    DispatchQueue.main.async {
                        self?.showImage.image = image
                        
                    }
                }
                
            }
    }
         override func prepareForReuse() {
                super.prepareForReuse()
               showImage.image = UIImage(systemName: "mic.fill")
            }
        
        
        }
