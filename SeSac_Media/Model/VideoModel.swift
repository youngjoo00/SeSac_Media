//
//  VideoModel.swift
//  SeSac_Media
//
//  Created by youngjoo on 2/9/24.
//

import Foundation

struct VideoModel: Decodable {
    let results: [Video]
}

struct Video: Decodable {
    let name: String
    let key: String
}
