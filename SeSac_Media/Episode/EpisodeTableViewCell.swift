//
//  EpisodeTableViewCell.swift
//  SeSac_Media
//
//  Created by youngjoo on 2/5/24.
//

import UIKit
import SnapKit
import Then

class EpisodeTableViewCell: BaseTableViewCell {
    
    let posterImage = PosterImageView(frame: .zero)
    let titleLabel = WhiteTitleLabel()
    let runTimeLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15)
        $0.textColor = .systemGray5
    }
    
    let overviewLabel = WhiteTitleLabel().then {
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 17)
    }
    
    override func configureHierarchy() {
        [
            posterImage,
            titleLabel,
            runTimeLabel,
            overviewLabel,
        ].forEach { contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        posterImage.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView)
            make.height.equalTo(200)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImage.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(contentView).inset(16)
            make.height.equalTo(20)
        }
        
        runTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(titleLabel)
            make.height.equalTo(20)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(runTimeLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(titleLabel)
            make.bottom.equalTo(contentView).offset(-10)
        }
    }
    
    override func configureView() {
        selectionStyle = .none
    }
}
