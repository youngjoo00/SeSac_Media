//
//  VideoView.swift
//  SeSac_Media
//
//  Created by youngjoo on 2/9/24.
//

import UIKit
import SnapKit
import Then
import WebKit

final class VideoView: BaseView {
    
    let navTitle = WhiteTitleLabel().then {
        $0.text = "티저 영상"
    }
    
    let webView = WKWebView()
    
    override func configureHierarchy() {
        [
            webView
        ].forEach { addSubview($0) }
    }
    
    override func configureLayout() {
        webView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.centerY)
        }
    }
    
    override func configureView() {
        
    }
}
