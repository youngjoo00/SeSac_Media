//
//  TMDBAPI.swift
//  SeSac_Media
//
//  Created by youngjoo on 2/1/24.
//

import Alamofire
import Foundation

enum TMDBAPI {
    case tvTrend
    case topRate
    case popular
    case detail(id: Int)
    case recommend(id: Int)
    case credit(id: Int)
    case search(query: String)
    case seasonDetail(seriseID: Int, seasonNumber: Int)
    
    var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    
    var languageParameter: [String: String] {
        return ["language": "ko-KR"]
    }
    
    static let baseImageURL: String = "https://image.tmdb.org/t/p/w500"
    
    var endpoint: URL {
        switch self {
        case .tvTrend:
            return URL(string: baseURL + "trending/tv/week")!
        case .topRate:
            return URL(string: baseURL + "tv/top_rated")!
        case .popular:
            return URL(string: baseURL + "tv/popular")!
        case .detail(let id):
            return URL(string: baseURL + "tv/\(id)")!
        case .recommend(let id):
            return URL(string: baseURL + "tv/\(id)/recommendations")!
        case .credit(let id):
            return URL(string: baseURL + "tv/\(id)/aggregate_credits")!
        case .search:
            return URL(string: baseURL + "search/tv")!
        case .seasonDetail(let seriseID, let seasonNumber):
            return URL(string: baseURL + "tv/\(seriseID)/season/\(seasonNumber)")!
        }
    }
    
    var header: HTTPHeaders {
        return ["Authorization" : APIKey.TMDBKey]
    }
    
    var parameter: Parameters {
        switch self {
        case .tvTrend:
            return languageParameter
        case .topRate:
            return languageParameter
        case .popular:
            return languageParameter
        case .detail:
            return languageParameter
        case .recommend:
            return languageParameter
        case .credit:
            return languageParameter
        case .search(let query):
            var param = languageParameter
            param["query"] = query
            return param
        case .seasonDetail:
            return languageParameter
        }
    }
}
