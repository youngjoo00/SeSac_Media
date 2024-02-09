//
//  TMDBSessionManager.swift
//  SeSac_Media
//
//  Created by youngjoo on 2/5/24.
//

import Foundation

class TMDBSessionManager {
    
    static let shared = TMDBSessionManager()
    
    private init() {}
    
    func fetchTVTrend(api: TMDBAPI, completionHandler: @escaping (TVModel?, ErrorStatus?) -> Void) {

        var url = URLRequest(url: api.endpoint)
        url.addValue(APIKey.TMDBKey, forHTTPHeaderField: "Authorization")

        // URLComponents 의 queryItems 에 URLQueryItem 을 배열로 넣어주면 쿼리로 쓸 수 있음
        // resolvingAgainstBaseURL: 상대경로인지 절대경로인지 확인 -> 상대경로일 때 true, 절대경로일 때 false
        var components = URLComponents(url: api.endpoint, resolvingAgainstBaseURL: false)
        components?.queryItems = api.parameter.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        url.url = components?.url
        
        /*
         URLResponse: 웹 요청의 응답 정보를 나타내는 기본 클래스
         HTTPURLResponse: URLResponse를 상속받아 HTTP 프로토콜에 특화된 정보를 추가로 제공하는 서브 클래스
         따라서, HTTPURLResponse는 HTTP에 특화된 응답 정보를 가지면서도 URLResponse의 기본적인 응답 정보를 모두 가질 수 있다.
         */
        URLSession.shared.dataTask(with: url) { data, response, error in

            DispatchQueue.main.async {
                guard error == nil else {
                    print("통신 실패요")
                    completionHandler(nil, .failedRequest)
                    return
                }
                
                guard let data = data else {
                    print("데이터 안들어와요")
                    completionHandler(nil, .noData)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    print("상태코드가 안들어와요")
                    completionHandler(nil, .invalidResponse)
                    return
                }
                
                guard httpResponse.statusCode == 200 else {
                    print("TMDB는 200 일때 값을 줌")
                    completionHandler(nil, .failedRequest)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(TVModel.self, from: data)
                    completionHandler(result, nil)
                } catch(let error) {
                    print(error)
                    completionHandler(nil, .invalidData)
                }
            }
        }.resume()
    }
    
    func callRequest<T: Decodable>(type: T.Type, api: TMDBAPI, completionHandler: @escaping (T?, ErrorStatus?) -> Void) {
        
        var url = URLRequest(url: api.endpoint)
        url.addValue(APIKey.TMDBKey, forHTTPHeaderField: "Authorization")
        
        var components = URLComponents(url: api.endpoint, resolvingAgainstBaseURL: false)
        components?.queryItems = api.parameter.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        url.url = components?.url
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                guard error == nil else {
                    completionHandler(nil, .failedRequest)
                    return
                }
                
                guard let data = data else {
                    completionHandler(nil, .noData)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completionHandler(nil, .invalidResponse)
                    return
                }
                
                guard httpResponse.statusCode == 200 else {
                    completionHandler(nil, .failedRequest)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(type, from: data)
                    completionHandler(result, nil)
                } catch {
                    completionHandler(nil, .invalidData)
                }
                
            }
            
            
        }.resume()
    }
}
