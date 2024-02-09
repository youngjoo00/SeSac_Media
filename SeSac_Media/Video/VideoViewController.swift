//
//  VideoViewController.swift
//  SeSac_Media
//
//  Created by youngjoo on 2/9/24.
//

import UIKit

final class VideoViewController: BaseViewController {
    
    let mainView = VideoView()

    var id = 0
    
    var videoList: VideoModel = VideoModel(results: []) {
        didSet {
            if let key = videoList.results.first?.key,
               let url = URL(string: "https://www.youtube.com/watch?v=\(key)") {
                let request = URLRequest(url: url)
                mainView.webView.load(request)
            }
        }
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = mainView.navTitle
        
        fetchVideo()

    }
}

extension VideoViewController {
    
    func fetchVideo() {
        TMDBSessionManager.shared.callRequest(type: VideoModel.self, api: .video(id: id)) { video, error in
            if let video = video {
                self.videoList = video
            } else {
                guard let error = error else { return }
                self.showToast(message: error.rawValue)
            }
        }
    }
}
