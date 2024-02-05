//
//  ViewController.swift
//  SeSac_Media
//
//  Created by youngjoo on 1/30/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        TMDBSessionManager.shared.fetchTVTrend(api: .tvTrend) { trend, error in
//            
//            if error == nil {
//                guard let trend = trend else { return }
//                print(trend)
//            } else {
//                print(error)
//            }
//        }
        
        TMDBSessionManager.shared.callRequest(type: TVModel.self, api: .search(query: "스파이더")) { search, error in
            
            if error == nil {
                guard let search = search else { return }
                print(search)
            } else {
                print(error)
            }
            
        }
    }


}

