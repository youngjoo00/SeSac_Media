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
    
    let headers: HTTPHeaders = ["Authorization": ""]
    func fetchTrendingTV() {
        
        let url = "https://api.themoviedb.org/3/trending/tv/week?language=ko-KR"
        
        AF.request(url, headers: <#T##HTTPHeaders?#>).responseDecodable(of: <#T##Decodable.Protocol#>, completionHandler: <#T##(DataResponse<Decodable, AFError>) -> Void#>)
    }
}
