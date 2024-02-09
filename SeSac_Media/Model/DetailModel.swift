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
    let seasons: [Season]
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genres, id
        case originalName = "original_name"
        case overview
        case posterPath = "poster_path"
        case seasons
    }
    
}

struct Genre: Decodable {
    let id: Int
    let name: String?
    
    enum CodingKeys: CodingKey {
        case id
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? "장르 오류"
    }
}

struct Season: Decodable {
    let air_date: String?
    let episode_count: Int
    let id: Int
    let name: String
    let overview: String
    let poster_path: String?
    let season_number: Int
    let vote_average: Double
    
    enum CodingKeys: CodingKey {
        case air_date
        case episode_count
        case id
        case name
        case overview
        case poster_path
        case season_number
        case vote_average
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.air_date = try container.decodeIfPresent(String.self, forKey: .air_date) ?? "날짜 오류"
        self.episode_count = try container.decode(Int.self, forKey: .episode_count)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.overview = try container.decode(String.self, forKey: .overview)
        self.poster_path = try container.decodeIfPresent(String.self, forKey: .poster_path) ?? "xmark"
        self.season_number = try container.decode(Int.self, forKey: .season_number)
        self.vote_average = try container.decode(Double.self, forKey: .vote_average)
    }
}
