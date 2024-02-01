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
    
    func fetchTV(api: TMDBAPI, completionHandler: @escaping ([TV]) -> Void) {
        
        AF.request(api.endpoint,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header).responseDecodable(of: TVModel.self) { response in
            switch response.result {
            case .success(let data):
                completionHandler(data.results)
            case .failure(let fail):
                print(fail)
            }
        }
    }
    
    func fetchDetail(api: TMDBAPI, completionHandler: @escaping (DetailModel) -> Void) {
        
        AF.request(api.endpoint,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header).responseDecodable(of: DetailModel.self) { response in
            switch response.result {
            case .success(let data):
                completionHandler(data)
            case .failure(let fail):
                print(fail)
            }
        }
    }
    
    func fetchCredit(api: TMDBAPI, completionHandler: @escaping ([Cast]) -> Void) {
        
        AF.request(api.endpoint,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header).responseDecodable(of: CreditModel.self) { response in
            switch response.result {
            case .success(let data):
                completionHandler(data.cast)
            case .failure(let fail):
                print(fail)
            }
        }
    }
}
