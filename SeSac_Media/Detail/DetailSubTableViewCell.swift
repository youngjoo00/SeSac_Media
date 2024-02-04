//
//  DetailSubTableViewCell.swift
//  SeSac_Media
//
//  Created by youngjoo on 2/1/24.
//

import UIKit
import SnapKit
import Then

class DetailSubTableViewCell: BaseTableViewCell {
    
    let titleLabel = WhiteTitleLabel()
    
    lazy var collectionView = PosterCollectionView().then {
        $0.backgroundColor = .clear
        $0.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
    }
    
    override func configureHierarchy() {
        [
            titleLabel,
            collectionView,
        ].forEach { contentView.addSubview($0)}
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(20)
            make.horizontalEdges.equalTo(contentView).inset(8)
            make.height.equalTo(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalTo(contentView)
            make.height.equalTo(160)
        }
    }
    
    override func configureView() {
        selectionStyle = .none
    }
}

extension DetailSubTableViewCell {
}
