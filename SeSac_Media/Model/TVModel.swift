//
//  MediaModel.swift
//  SeSac_Media
//
//  Created by youngjoo on 1/31/24.
//

import Foundation

struct TVModel: Decodable {
    let results: [TV]
}

struct TV: Decodable {
    let backdrop_path: String?
    let id: Int
    let original_name: String
    let overview: String
    let poster_path: String?
}
