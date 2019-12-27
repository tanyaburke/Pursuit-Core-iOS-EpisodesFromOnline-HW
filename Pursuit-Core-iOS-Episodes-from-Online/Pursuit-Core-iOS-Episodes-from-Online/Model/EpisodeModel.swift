//
//  EpisodeModel.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Tanya Burke on 12/27/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation
//https://www.tvmaze.com/shows/139/girls/episodes
//URL: /shows/:id/episodes
//(optional) specials: do include specials in the list
//Example: http://api.tvmaze.com/shows/1/episodes
//Example: http://api.tvmaze.com/shows/1/episodes?specials=1

//http://api.tvmaze.com/shows/139/episodes?specials=1 139 is the show id

struct Episode: Codable {
    let id: Int
    let name: String
    let season: Int
    let number: Int
    let image: EpisodeImage?
    let summary: String
}
    struct EpisodeImage: Codable {
        let medium: String
        let original: String
}

