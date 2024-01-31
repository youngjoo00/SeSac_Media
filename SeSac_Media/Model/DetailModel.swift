//
//  DetailModel.swift
//  SeSac_Media
//
//  Created by youngjoo on 1/31/24.
//

import Foundation

struct DetailModel: Decodable {
    let adult: Bool
    let backdropPath: String
    let genres: [Genre]
    let id: Int
    let originalName: String
    let overview: String
    let posterPath: String

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genres, id
        case originalName = "original_name"
        case overview
        case posterPath = "poster_path"
    }
}

struct Genre: Decodable {
    let id: Int
    let name: String?
}
