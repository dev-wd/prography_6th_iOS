//
//  MovieAPI.swift
//  prography_6th_iOS
//
//  Created by Mainea on 3/1/20.
//  Copyright © 2020 Mainea. All rights reserved.
//

import Foundation
import Alamofire

protocol MovieAPIProtocol {
    func getMovieResponse(limit: Int, minrate: Int, completion: @escaping  (MovieResponse?, Error?)-> Void)
}

class MovieAPI: MovieAPIProtocol {
    let movieUrl = URL(string: "https://yts.lt/api/v2/list_movies.json")
    let headers : HTTPHeaders = ["Content-Type":"application/json"]
    
    func getMovieResponse(limit: Int, minrate: Int, completion: @escaping  (MovieResponse?, Error?)-> Void) {
        let parameters: [String: Int] = ["limit" : limit, "minimum_rating": minrate]
        
        
        Alamofire.request(
            movieUrl!,
            method: .post,
            parameters: parameters,
            encoding: URLEncoding(destination: .queryString),
            headers: headers
        ).validate(statusCode: 200..<600)
            .responseJSON {  response  in
                switch response.result {
                case .success(_):
                    guard let data = response.data else { return }
                    do {
                        let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                        completion( movieResponse, nil )
                    } catch {
                        completion( nil, error )
                    }
                    
                case .failure(let error):
                    completion(nil, error)
                }
        }
    }
}
