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
            print(self.id)
            if let video = video {
                print(video.results)
            } else {
                guard let error = error else { return }
                self.showToast(message: error.rawValue)
            }
        }
    }
}
