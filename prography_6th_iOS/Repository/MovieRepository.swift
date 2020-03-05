//
//  MovieRepository.swift
//  prography_6th_iOS
//
//  Created by Mainea on 3/1/20.
//  Copyright © 2020 Mainea. All rights reserved.
//

import Foundation

protocol MovieRepositoryProtocol {
    func fetchRepository(minrate: Int, completion: @escaping (Error?) -> Void)
    func getRepository() -> MovieResponse?
}

class MovieRepository: MovieRepositoryProtocol {
    
    private let api: MovieAPIProtocol = MovieAPI()
    static let shared = MovieRepository()
    private var movieResponse: MovieResponse?
    
    private init() { }
    
    func fetchRepository(minrate: Int, completion: @escaping (Error?) -> Void) {
        api.getMovieResponse(limit: 10, minrate: minrate) { movieResponse , error in
            self.movieResponse = movieResponse
            completion(error)
        }
    }
    
    func getRepository() -> MovieResponse? {
        return movieResponse
    }
}
