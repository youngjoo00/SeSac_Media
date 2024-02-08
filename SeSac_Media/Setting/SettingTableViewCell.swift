//
//  SettingTableViewCell.swift
//  SeSac_Media
//
//  Created by youngjoo on 2/8/24.
//

import UIKit
import SnapKit
import Then

class SettingTableViewCell: BaseTableViewCell {
    
    let titleLabel = WhiteTitleLabel()
    let contentLabel = WhiteTitleLabel()
    let accessoryImageView = UIImageView().then {
        $0.image = UIImage(systemName: "greaterthan")
        $0.tintColor = .white
        // 아래에서 스냅킷으로 위치를 지정하면 액세서리 뷰 위치로 안가짐
        // 그래서 액세서리 뷰는 위치는 정해주지만, 크기를 지정해주기 않아서 -> 액세서리 뷰는 frame 기반 레이아웃이기 때문에 frame 에 CGRect 로 크기만 지정해주었다.
        $0.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
    }

    override func configureHierarchy() {
        [
            titleLabel,
            contentLabel,
        ].forEach { contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(16)
            make.height.equalTo(20)
        }
        
        // UILayoutPriority(750) 이렇게도 가능
//        titleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        contentLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(titleLabel.snp.trailing).offset(16)
            make.trailing.equalTo(contentView).inset(16)
            make.height.equalTo(20)
        }
        
        // compression: 더 이상 작아지지 않으려는 저항
        // 저항 우선순위를 낮춰서 콘텐츠가 줄어들게끔 함
        contentLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    
    }
    
    override func configureView() {
        accessoryView = accessoryImageView
        selectionStyle = .none
    }
}
