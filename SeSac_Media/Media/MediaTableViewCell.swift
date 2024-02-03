//
//  MediaTableViewCell.swift
//  SeSac_Media
//
//  Created by youngjoo on 1/31/24.
//

import UIKit
import SnapKit
import Then
class MediaTableViewCell: BaseTableViewCell {
    
    let titleLabel = WhiteTitleLabel().then {
        $0.text = "테스트"
    }
    
    lazy var collectionView = PosterCollectionView().then {
        $0.backgroundColor = .clear
        $0.register(HorizontalCollectionViewCell.self, forCellWithReuseIdentifier: HorizontalCollectionViewCell.identifier)
    }
    
    override func configureHierarchy() {
        [
            titleLabel,
            collectionView,
        ].forEach { contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.horizontalEdges.equalTo(contentView).inset(8)
            make.height.equalTo(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(-10)
            make.horizontalEdges.bottom.equalTo(contentView)
        }
        
    }
    
    override func configureView() {
        backgroundColor = .clear
        selectionStyle = .none
    }
}

extension MediaTableViewCell {

}
