//
//  ProfileSearchView.swift
//  SeSac_Media
//
//  Created by youngjoo on 2/9/24.
//

import UIKit
import SnapKit
import Then

final class ProfileSearchView: BaseView {
    
    let navTitle = WhiteTitleLabel().then {
        $0.text = "프로필 이미지 검색"
    }
    
    let searchBar = UserSearchBar().then {
        $0.placeholder = "원하는 이미지 키워드를 검색해보세요."
    }
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionView()).then {
        $0.backgroundColor = .clear
        $0.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
    }
    
    override func configureHierarchy() {
        [
            searchBar,
            collectionView,
        ].forEach { addSubview($0) }
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        
    }
}

extension ProfileSearchView {
    static func configureCollectionView() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 5
        
        let cellWidth = (UIScreen.main.bounds.width - (spacing * 4)) / 3
        
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        return layout
    }
   
}
