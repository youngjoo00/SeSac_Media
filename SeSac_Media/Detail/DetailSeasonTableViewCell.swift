//
//  DetailSeasonTableViewCell.swift
//  SeSac_Media
//
//  Created by youngjoo on 2/4/24.
//

import UIKit
import SnapKit
import Then

class DetailSeasonTableViewCell: BaseTableViewCell {

    let titleLabel = WhiteTitleLabel().then {
        $0.font = .boldSystemFont(ofSize: 17)
    }
    
    let posterImageView = PosterImageView(frame: .zero)
    let episodeCount = WhiteTitleLabel().then {
        $0.font = .systemFont(ofSize: 15)
    }
    
    override func configureHierarchy() {
        [
            episodeCount,
            titleLabel,
            posterImageView,
        ].forEach { contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        posterImageView.snp.makeConstraints { make in
            make.top.leading.bottom.equalTo(contentView)
            make.width.equalTo(100)
            make.height.equalTo(posterImageView.snp.width).multipliedBy(1.4)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(20)
            make.leading.equalTo(posterImageView.snp.trailing).offset(20)
            make.height.equalTo(20)
        }
     
        episodeCount.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalTo(titleLabel.snp.leading)
            make.height.equalTo(17)
        }
    }
    
    override func configureView() {
        selectionStyle = .none
    }

}
