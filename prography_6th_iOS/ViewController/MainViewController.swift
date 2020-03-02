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
    var isLoading: PublishSubject<Bool> { get }
    var responseStatus: PublishSubject<ResponseStatus> { get }
    func fetch()
}

class MainViewController: UIViewController {
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var ratePicker: UIPickerView!
    
    let bag = DisposeBag()
    var pickerData:[Int] = Array(0...10)

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
                viewModel.fetch()
                let seconds = 4.0
                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                    self.performSegue(withIdentifier: "next", sender: (Any).self)
                }
                
                
                // 여기서 completion handling 하고 난 다음에 segue 넘겨줘야 한다.
                
        }.disposed(by: bag)
    }
    
    func layout() {
        Observable.just(pickerData).bind(to: ratePicker.rx.itemTitles) { _, item in
            return "\(item)"
        }
        
    }
}

