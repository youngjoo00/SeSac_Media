//
//  ImageSearchModel.swift
//  SeSac_Media
//
//  Created by youngjoo on 2/9/24.
//

import Foundation

struct ProfileSearchModel: Decodable {
    let total: Int
    var items: [Item]
}

struct Item: Decodable {
    let link: String
}
