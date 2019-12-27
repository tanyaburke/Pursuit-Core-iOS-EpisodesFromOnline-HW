//
//  API.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Tanya Burke on 12/27/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct ElementAPICLient {
    
    static func fetchElement(completion: @escaping (Result <[Element],AppError>)->()){
        
        let elementEndPointURLString = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements"
        guard let url = URL(string: elementEndPointURLString) else {
            completion(.failure(.badURL(elementEndPointURLString)))
            return
        }
        let request = URLRequest(url: url) //creating a url request
        
        NetworkHelper.shared.performDataTask(with: request){
            (result) in
            switch result{
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do{//decoding raw data from the shared url session, according to our model=Results.self
                    let elements = try
                        JSONDecoder().decode([Element].self, from: data)
                    completion(.success(elements))
                }catch{
                    completion(.failure(.decodingError(error)))
                    
                }
                
            }
        }
    }


static func postFavorite(favorite: Element, completion: @escaping (Result<Bool, AppError>)->()){
    
    let endpointURLString = "http://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/favorites"
    guard let url = URL(string: endpointURLString) else{
        completion(.failure(.badURL(endpointURLString)))
        return
    }
    do {
        let data = try JSONEncoder().encode(favorite)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = data
         
        NetworkHelper.shared.performDataTask(with: request){(result) in
            switch result{
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success:
                completion(.success(true))
            }
        }
        
    } catch {
        completion(.failure(.encodingError(error)))
    }
}
    
    
    
    static func thumbImageUrl(elementNumber: Int)-> String {
        var thumbNailUrl = ""
        switch elementNumber {
        case 1...9:
            thumbNailUrl = "http://www.theodoregray.com/periodictable/Tiles/00\(elementNumber)/s7.JPG"
        case 10...99:
           thumbNailUrl = "http://www.theodoregray.com/periodictable/Tiles/0\(elementNumber)/s7.JPG"
        default:
            thumbNailUrl = "http://www.theodoregray.com/periodictable/Tiles/\(elementNumber)/s7.JPG"
        }
        return thumbNailUrl
}
    
}
