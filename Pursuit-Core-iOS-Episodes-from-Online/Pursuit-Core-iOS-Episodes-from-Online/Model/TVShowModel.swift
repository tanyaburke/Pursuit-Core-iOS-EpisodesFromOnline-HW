//
//  TVShowModel.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Tanya Burke on 12/27/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct Shows:Codable{
    let id: Int?
    let name: String?
    let rating: Rating?
    let image: ShowImage?
    
}
struct Rating: Codable {
    let average: Double?
}
struct ShowImage: Codable {
    let medium: String
    let original: String
}

//URL: /search/shows?q=:query
//Example: http://api.tvmaze.com/search/shows?q=girls
