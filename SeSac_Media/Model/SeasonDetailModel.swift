//
//  SeasonDetailModel.swift
//  SeSac_Media
//
//  Created by youngjoo on 2/5/24.
//

import Foundation

struct SeasonDetailModel: Decodable {
    let episodes: [Episode]
}

struct Episode: Decodable {
    let air_date: String
    let episode_number: Int
    let id: Int
    let name: String
    let overview: String
    let production_code: String
    let runtime: Int
    let season_number: Int
    let show_id: Int
    let still_path: String?
    let crew: [Crew]
    let guest_stars: [GuestStar]
    
    enum CodingKeys: CodingKey {
        case air_date
        case episode_number
        case id
        case name
        case overview
        case production_code
        case runtime
        case season_number
        case show_id
        case still_path
        case crew
        case guest_stars
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.air_date = try container.decode(String.self, forKey: .air_date)
        self.episode_number = try container.decode(Int.self, forKey: .episode_number)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.overview = try container.decode(String.self, forKey: .overview)
        self.production_code = try container.decode(String.self, forKey: .production_code)
        self.runtime = try container.decode(Int.self, forKey: .runtime)
        self.season_number = try container.decode(Int.self, forKey: .season_number)
        self.show_id = try container.decode(Int.self, forKey: .show_id)
        self.still_path = try container.decodeIfPresent(String.self, forKey: .still_path) ?? "xmark"
        self.crew = try container.decode([Crew].self, forKey: .crew)
        self.guest_stars = try container.decode([GuestStar].self, forKey: .guest_stars)
    }
}

struct Crew: Decodable {
    let job: String
    let department: String
    let id: Int
    let name: String
    let profile_path: String?
}

struct GuestStar: Decodable {
    let character: String
    let credit_id: String
    let order: Int
    let id: Int
    let known_for_department: String
    let name: String
    let profile_path: String?
}
