//
//  CreditModel.swift
//  SeSac_Media
//
//  Created by youngjoo on 2/1/24.
//

import Foundation

struct CreditModel: Decodable {
    let cast: [Cast]
    let id: Int
}

struct Cast: Decodable {
    let id: Int
    let knownForDepartment: Department
    let name: String
    let profilePath: String?
    let roles: [Roles]
    
    enum CodingKeys: String, CodingKey {
        case id
        case knownForDepartment = "known_for_department"
        case name
        case profilePath = "profile_path"
        case roles
    }
}

enum Department: String, Codable {
    case acting = "Acting"
    case art = "Art"
    case camera = "Camera"
    case costumeMakeUp = "Costume & Make-Up"
    case crew = "Crew"
    case directing = "Directing"
    case editing = "Editing"
    case production = "Production"
    case sound = "Sound"
    case visualEffects = "Visual Effects"
    case writing = "Writing"
}

struct Roles: Codable {
    let character: String
    
    enum CodingKeys: String, CodingKey {
        case character
    }
}


