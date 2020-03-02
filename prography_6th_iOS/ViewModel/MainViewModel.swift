//
//  GradeInputViewModel.swift
//  prography_6th_iOS
//
//  Created by Mainea on 3/2/20.
//  Copyright © 2020 Mainea. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum ResponseStatus {
    case success
    case failed
}
class MainViewModel : MainViewBindable {
    private let movieRepository: MovieRepository = MovieRepository.shared
    
    var minrateText: BehaviorRelay<String>
    var isLoading: PublishSubject<Bool>
    var responseStatus: PublishSubject<ResponseStatus>
    
    init() {
        minrateText = BehaviorRelay(value: "")
        isLoading = PublishSubject.init()
        responseStatus = PublishSubject.init()
    }
    
    func fetch() {
        isLoading.onNext(true)
        let minrate = Int(minrateText.value)
        
        movieRepository.fetchRepository(minrate: minrate!) { error in
            if error == nil {
                self.responseStatus.onNext(.success)
                self.isLoading.onNext(false)
                print("success")
            } else {
                self.responseStatus.onNext(.failed)
                self.isLoading.onNext(false)
                print("error")
            }
        }
    }
}
