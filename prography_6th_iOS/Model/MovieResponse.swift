//
//  MovieResponse.swift
//  prography_6th_iOS
//
//  Created by Mainea on 3/1/20.
//  Copyright © 2020 Mainea. All rights reserved.
//

import Foundation

struct MovieResponse: Codable {
    let status: String?
    let statusMessage: String?
    let data: DataClass?
}

struct DataClass: Codable {
    let moviewCount: Int?
    let limit: Int?
    let movies: [Movie]?
}

struct Movie: Codable {
    let title: String?
    let rating: Double?
}
