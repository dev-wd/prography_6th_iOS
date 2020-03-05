//
//  MovieError.swift
//  prography_6th_iOS
//
//  Created by Mainea on 3/1/20.
//  Copyright © 2020 Mainea. All rights reserved.
//

import Foundation

enum MovieError: Error {
    case networkError
    case decodeError
    case getRepositoryError
}
