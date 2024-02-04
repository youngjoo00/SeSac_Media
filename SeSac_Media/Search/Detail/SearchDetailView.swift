//
//  SearchDetailView.swift
//  SeSac_Media
//
//  Created by youngjoo on 2/4/24.
//

import UIKit
import SnapKit
import Then

class SearchDetailView: BaseView {
    
    let navTitle = WhiteTitleLabel()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout()).then {
        $0.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
        $0.backgroundColor = .clear
    }
    
    override func configureHierarchy() {
        [
            collectionView
        ].forEach { addSubview($0) }
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        
    }
    
    
}

extension SearchDetailView {
    static func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        let spacing: CGFloat = 10
        let cellWidth = (UIScreen.main.bounds.width - (spacing * 4)) / 3
        let cellhieght = ((UIScreen.main.bounds.width - (spacing * 4)) * 1.4) / 3
        
        layout.itemSize = CGSize(width: cellWidth, height: cellhieght)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        return layout
    }
}
