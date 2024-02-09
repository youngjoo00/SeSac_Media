//
//  NaverAPIManager.swift
//  SeSac_Media
//
//  Created by youngjoo on 2/9/24.
//

import Foundation

final class NaverAPIManager {
    
    static let shared = NaverAPIManager()
    
    private init() {}
    
    func callRequest<T: Decodable>(type: T.Type, api: NaverAPI, completionHandler: @escaping (T?, ErrorStatus?) -> Void) {
        
        guard var component = URLComponents(url: api.endpoint, resolvingAgainstBaseURL: false) else {
            print("컴포넌트 생성 실패")
            return
        }
        
        component.queryItems = api.parameter.map { URLQueryItem(name: $0.key, value: $0.value) }

        guard let componentURL = component.url else {
            print("컴포넌트 URL 생성 실패")
            return
        }
        
        var url = URLRequest(url: componentURL)
        url.allHTTPHeaderFields = api.header
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                guard error == nil else {
                    print("통신 에러")
                    completionHandler(nil, .failedRequest)
                    return
                }
                
                guard let data = data else {
                    print("데이터 에러")
                    completionHandler(nil, .noData)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    print("응답코드 에러")
                    completionHandler(nil, .invalidResponse)
                    return
                }
                
                guard httpResponse.statusCode == 200 else {
                    print("200 아님")
                    completionHandler(nil, .failedRequest)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(type, from: data)
                    completionHandler(result, nil)
                } catch {
                    print("디코딩 실패")
                    completionHandler(nil, .invalidData)
                }
            }
            
        }.resume() // 하... 제발.. 잊지말자..
    }
}
