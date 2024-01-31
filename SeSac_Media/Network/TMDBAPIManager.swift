//
//  TMDBAPIManager.swift
//  SeSac_Media
//
//  Created by youngjoo on 1/30/24.
//

import UIKit
import Alamofire

class TMDBAPIManager {
    
    static let shared = TMDBAPIManager()
    private init() {}
    
    let baseImageURL = "https://image.tmdb.org/t/p/w500"
    let baseURL = "https://api.themoviedb.org/3/"
    let isoURL = "?language=ko-KR"
    let headers: HTTPHeaders = ["Authorization": APIKey.TMDBKey]
    
    enum Home: String, CaseIterable {
        case TVTrend
        case TopRate
        case Popular
        
        var url: String {
            switch self {
            case .TVTrend:
                return "https://api.themoviedb.org/3/trending/tv/week?language=ko-KR"
            case .TopRate:
                return "https://api.themoviedb.org/3/tv/top_rated?language=ko-KR"
            case .Popular:
                return "https://api.themoviedb.org/3/tv/popular?language=ko-KR"
            }
        }
    }
    
    func mediaRequest(url: String, completionHandler: @escaping ([Media]) -> Void) {
        
        AF.request(url, headers: headers).responseDecodable(of: MediaModel.self) { response in
            switch response.result {
            case .success(let data):
                completionHandler(data.results)
            case .failure(let fail):
                print(fail)
            }
        }
    }
    
    func detailRequest(id: Int, completionHandler: @escaping (DetailModel) -> Void) {
        
        let url = baseURL + "tv/\(id)" + isoURL
        AF.request(url, headers: headers).responseDecodable(of: DetailModel.self) { response in
            switch response.result {
            case .success(let data):
                completionHandler(data)
            case .failure(let fail):
                print(fail)
            }
        }
    }

    func recommendRequest(id: Int, completionHandler: @escaping ([Media]) -> Void) {
        
        let url = baseURL + "tv/\(id)/recommendations" + isoURL
        AF.request(url, headers: headers).responseDecodable(of: MediaModel.self) { response in
            switch response.result {
            case .success(let data):
                completionHandler(data.results)
            case .failure(let fail):
                print(fail)
            }
        }
    }
}
