//
//  MovieListViewModel.swift
//  prography_6th_iOS
//
//  Created by Mainea on 3/2/20.
//  Copyright © 2020 Mainea. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


class MovieListViewModel: MovieListViewBindable {
    let repository: MovieRepository = MovieRepository.shared
    var movies: BehaviorRelay<[Movie]>
    
    init() {
        movies = BehaviorRelay.init(value: [])
    }
    
    func getMovies() {
        movies.accept((repository.getRepository()?.data?.movies!)!)
    }
}
