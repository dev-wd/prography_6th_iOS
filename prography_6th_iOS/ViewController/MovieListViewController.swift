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
    var sendingData: [String]?
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(viewModel: MovieListViewModel())
        layout()
    }
    // success 가 먼저 발생해도 이럼
    func bind(viewModel: MovieListViewBindable) {
        viewModel.getMovies()
        
        // 평점 소팅이 안되고 그 다음엔 publish 좀 더 공부하자
        
        viewModel.movies.bind(to: tableRef.rx.items(cellIdentifier: "cell", cellType: MovieCell.self)) {
            index, element, cell in
            cell.movieTitle.text = element.title
            cell.movieRate.text = String(element.rating!)
            cell.selectionStyle = .none
        }.disposed(by: bag)
    }
    
    func layout() {
        tableRef.rx
            .itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                let cell = self?.tableRef.cellForRow(at: indexPath) as? MovieCell
                self!.sendingData = [(cell?.movieTitle.text)!, (cell?.movieRate.text)!]
                self!.performSegue(withIdentifier: "detail", sender: self)
                
            }).disposed(by: bag)
        tableRef.tableFooterView = UIView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? MovieDetailViewController else {return}
        vc.data = self.sendingData
    }
}
