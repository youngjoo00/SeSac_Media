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
    
    func callRequest<T: Decodable>(type: T.Type ,api: TMDBAPI, completionHandler: @escaping (T) -> Void) {
        
        AF.request(api.endpoint,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completionHandler(data)
            case .failure(let fail):
                print(fail)
            }
        }
    }

}
