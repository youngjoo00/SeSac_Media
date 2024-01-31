//
//  Step1_MediaViewController.swift
//  SeSac_Media
//
//  Created by youngjoo on 1/30/24.
//

import UIKit
import SnapKit
import Kingfisher

// 뷰 극한으로 재사용해보기
// 이런식으로 사용하기도 하나요..?
class Step1_MediaViewController: UIViewController {
    
    let collectionViews: [HorizontalCollectionView] = [HorizontalCollectionView(), HorizontalCollectionView(), HorizontalCollectionView()]
    let titleLabels: [WhiteTitleLabel] = [WhiteTitleLabel(), WhiteTitleLabel(), WhiteTitleLabel()]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureView()
        
        for i in 0..<collectionViews.count {
            let url = TMDBAPIManager.Home.allCases[i].url
            
            TMDBAPIManager.shared.mediaRequest(url: url) { data in
                self.collectionViews[i].updateData(data: data)
            }
        }
    }
    
    
}

extension Step1_MediaViewController {
    
    func configureHierarchy() {
        
        titleLabels.forEach { view.addSubview($0) }
        collectionViews.forEach { view.addSubview($0) }
    }
    
    func configureLayout() {
        let viewHeight = view.frame.height / 3.5
        for i in 0..<collectionViews.count {
            titleLabels[i].snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide).offset(viewHeight * CGFloat(i))
                make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            }
            
            collectionViews[i].snp.makeConstraints { make in
                make.top.equalTo(titleLabels[i].snp.bottom).offset(10)
                make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
                make.height.equalTo(150)
            }
        }
    }
    
    func configureView() {
        view.backgroundColor = .black
        
        for i in 0..<titleLabels.count {
            titleLabels[i].text = TMDBAPIManager.Home.allCases[i].rawValue
        }
    }
}

#Preview {
    Step1_MediaViewController()
}
