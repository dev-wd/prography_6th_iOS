//
//  MovieDetailViewController.swift
//  prography_6th_iOS
//
//  Created by Mainea on 3/2/20.
//  Copyright © 2020 Mainea. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieRate: UILabel!
    
    var data: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTitle.text = data![0]
        movieRate.text = data![1]
    }

}
