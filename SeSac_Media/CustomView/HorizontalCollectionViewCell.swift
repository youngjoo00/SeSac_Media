//
//  HorizontalCollectionViewCell.swift
//  SeSac_Media
//
//  Created by youngjoo on 1/30/24.
//

import UIKit
import SnapKit

class HorizontalCollectionViewCell: UICollectionViewCell {
    
    let posterImageView = PosterImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HorizontalCollectionViewCell {
    
    func configureHierarchy() {
        [
            posterImageView
        ].forEach { contentView.addSubview($0) }
    }
    
    func configureLayout() {
        posterImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
    }
    
    func configureView() {
        posterImageView.image = UIImage(systemName: "xmark")
    }
}
