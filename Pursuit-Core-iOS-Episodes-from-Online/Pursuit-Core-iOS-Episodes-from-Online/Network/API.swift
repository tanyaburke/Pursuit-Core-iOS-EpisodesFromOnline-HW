//
//  API.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Tanya Burke on 12/27/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct ShowAPICLient {
    
     static func fetchShows(query: String, completion: @escaping (Result <[Shows],AppError>)->()){
           let searchTerm = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "" //wiil replace space with %20
        let showEndPointURLString = "https://api.tvmaze.com/search/shows?q=\(searchTerm)"
        guard let url = URL(string: showEndPointURLString) else {
            completion(.failure(.badURL(showEndPointURLString)))
            return
        }
        let request = URLRequest(url: url) //creating a url request
        
        NetworkHelper.shared.performDataTask(with: request){
            (result) in
            switch result{
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do{
                    let shows = try
                        JSONDecoder().decode([Shows].self, from: data)
                    completion(.success(shows))
                }catch{
                    completion(.failure(.decodingError(error)))
                    
                }
                
            }
        }
    }


    static func fetchEpisodes(episodeID: Int, completion: @escaping (Result <[Episode],AppError>)->()){
      
    let episodeEndPointURLString = "https://api.tvmaze.com/shows/\(episodeID)/episodes?specials=1"
    guard let url = URL(string: episodeEndPointURLString) else {
        completion(.failure(.badURL(episodeEndPointURLString)))
        return
    }
    let request = URLRequest(url: url) //creating a url request
    
    NetworkHelper.shared.performDataTask(with: request){
        (result) in
        switch result{
        case .failure(let appError):
            completion(.failure(.networkClientError(appError)))
        case .success(let data):
            do{
                let episodes = try
                    JSONDecoder().decode([Episode].self, from: data)
                completion(.success(episodes))
            }catch{
                completion(.failure(.decodingError(error)))
                
            }
            
        }
    }
}

    
    
}
    
