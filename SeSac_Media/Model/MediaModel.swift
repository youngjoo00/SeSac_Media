//
//  MediaModel.swift
//  SeSac_Media
//
//  Created by youngjoo on 1/31/24.
//

import Foundation

struct MediaModel: Decodable {
    let results: [Media]
}

struct Media: Decodable {
    let backdrop_path: String?
    let id: Int
    let original_name: String
    let overview: String
    let poster_path: String?
}
