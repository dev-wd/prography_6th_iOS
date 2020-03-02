//
//  MovieCell.swift
//  prography_6th_iOS
//
//  Created by Mainea on 3/2/20.
//  Copyright © 2020 Mainea. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MovieCell: UITableViewCell {

    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieRate: UILabel!
    
    var bag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        //movieTitle.text = nil
        // movieRate.text = nil
        bag = DisposeBag()
    }

}
