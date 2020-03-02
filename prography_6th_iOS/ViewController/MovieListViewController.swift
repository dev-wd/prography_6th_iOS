//
//  MovieListViewController.swift
//  prography_6th_iOS
//
//  Created by Mainea on 3/2/20.
//  Copyright © 2020 Mainea. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol MovieListViewBindable {
    var movies: BehaviorRelay<[Movie]> { get }
    func getMovies()
}

class MovieListViewController: UIViewController {
    @IBOutlet weak var tableRef: UITableView!
    
    var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(viewModel: MovieListViewModel())
    }
    // success 가 먼저 발생해도 이럼
    func bind(viewModel: MovieListViewBindable) {
        viewModel.getMovies()
        
        // 평점 소팅이 안되고 그 다음엔 publish 좀 더 공부하자
        
        viewModel.movies.bind(to: tableRef.rx.items(cellIdentifier: "cell", cellType: MovieCell.self)) {
            index, element, cell in
            cell.movieTitle.text = element.title
            cell.movieRate.text = String(element.rating!)
        }.disposed(by: bag)
    }
}
