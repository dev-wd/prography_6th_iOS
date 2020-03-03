//
//  ViewController.swift
//  prography_6th_iOS
//
//  Created by Mainea on 3/1/20.
//  Copyright © 2020 Mainea. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol MainViewBindable {
    var minrateText: BehaviorRelay<String> { get }
    var isLoading: BehaviorRelay<Bool> { get }
    var responseStatus: PublishSubject<ResponseStatus> { get }
    func fetch()
}

class MainViewController: UIViewController {
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var ratePicker: UIPickerView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    let bag = DisposeBag()
    var pickerData:[Int] = Array(0...9)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        bind(viewModel: MainViewModel())
    }
    
    func bind(viewModel: MainViewBindable) {
        
        nextButton.rx
            .tap
            .subscribe{ _ in
                viewModel.minrateText
                    .accept(String(self.ratePicker.selectedRow(inComponent: 0)))
                
                if viewModel.isLoading.value == true {
                    viewModel.fetch()
                }
        }.disposed(by: bag)
        
        viewModel.responseStatus
            .subscribe(onNext: { val in
                self.performSegue(withIdentifier: "next", sender: (Any).self)
            }).disposed(by: bag)
        
        viewModel.isLoading
            .bind(to: indicator.rx.isHidden)
            .disposed(by: bag)
    }
    
    func layout() {
        Observable.just(pickerData).bind(to: ratePicker.rx.itemTitles) { _, item in
            return "\(item)"
        }.disposed(by: bag)
        
        nextButton.layer.cornerRadius = 7
        nextButton.setTitleColor(UIColor.white, for: .normal)
        nextButton.layer.shadowColor = UIColor.black.cgColor
        nextButton.layer.shadowRadius = 3
        nextButton.layer.shadowOpacity = 0.4
        nextButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        
    }
}
