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
    var isLoading: BehaviorRelay<Bool>
    var responseStatus: PublishSubject<ResponseStatus>
    
    init() {
        minrateText = BehaviorRelay(value: "")
        isLoading = BehaviorRelay(value: true)
        responseStatus = PublishSubject.init()
    }
    
    func fetch() {
        isLoading.accept(false)
        let minrate = Int(minrateText.value)
        
        movieRepository.fetchRepository(minrate: minrate!) { error in
            if error == nil {
                
                self.isLoading.accept(true)
                self.responseStatus.onNext(.success)
                print("success")
            } else {
                self.isLoading.accept(true)
                self.responseStatus.onNext(.failed)
                print("error")
            }
        }
    }
}
