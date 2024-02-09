//
//  DetailTableViewCell.swift
//  SeSac_Media
//
//  Created by youngjoo on 1/31/24.
//

import UIKit
import SnapKit
import Then

final class DetailTableViewCell: BaseTableViewCell {

    let posterImage = UIImageView()
    let titleLabel = WhiteTitleLabel()
    let genresLabel = WhiteTitleLabel().then {
        $0.font = .boldSystemFont(ofSize: 17)
    }
    let overviewLabel = WhiteTitleLabel()
    let airDateLabel = WhiteTitleLabel().then {
        $0.font = .boldSystemFont(ofSize: 17)
    }
    let playBtn = UIButton()
    
    override func configureHierarchy() {
        [
            posterImage,
            titleLabel,
            genresLabel,
            overviewLabel,
            airDateLabel,
            playBtn,
        ].forEach { contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        posterImage.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView)
            make.height.equalTo(200)
        }
        
        playBtn.snp.makeConstraints { make in
            make.center.equalTo(posterImage)
            make.size.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImage.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(contentView).inset(8)
            make.height.equalTo(20)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(titleLabel)
        }
        
        airDateLabel.snp.makeConstraints { make in
            make.top.equalTo(overviewLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(titleLabel)
            make.height.equalTo(20)
        }
        
        genresLabel.snp.makeConstraints { make in
            make.top.equalTo(airDateLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(titleLabel)
            make.height.equalTo(20)
            make.bottom.equalTo(contentView).offset(-10)
        }
    }
    
    override func configureView() {
        posterImage.contentMode = .scaleToFill
        
        titleLabel.font = .boldSystemFont(ofSize: 20)
        
        overviewLabel.font = .systemFont(ofSize: 15)
        overviewLabel.numberOfLines = 0
        selectionStyle = .none
        
        playBtn.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        playBtn.tintColor = .black
        playBtn.contentVerticalAlignment = .fill
        playBtn.contentHorizontalAlignment = .fill
 
    }
}

extension DetailTableViewCell {
    
}
