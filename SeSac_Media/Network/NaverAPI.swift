//
//  NaverAPI.swift
//  SeSac_Media
//
//  Created by youngjoo on 2/9/24.
//

import Foundation

enum NaverAPI {
    case imageSearch(query: String, start: Int, sort: String)
    
    private var baseURL: String {
        return "https://openapi.naver.com/v1/"
    }
    
    var endpoint: URL {
        switch self {
        case .imageSearch:
            return URL(string: baseURL + "search/image")!
        }
    }
    
    var header: [String: String] {
        switch self {
        case .imageSearch:
            var headers: [String: String] = [:]
            headers["X-Naver-Client-Id"] = APIKey.NaverClientID
            headers["X-Naver-Client-Secret"] = APIKey.NaverClientSecret
            return headers
        }
    }
    
    var parameter: [String: String] {
        switch self {
        case .imageSearch(let query, let start, let sort):
            var params: [String: String] = [:]
            
            guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return params }

            params["query"] = encodedQuery
            params["start"] = "\(start)"
            params["display"] = "30"
            params["sort"] = sort
            return params
        }
    }
}
