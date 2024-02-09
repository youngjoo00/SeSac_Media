//
//  SettingView.swift
//  SeSac_Media
//
//  Created by youngjoo on 2/8/24.
//

import UIKit
import SnapKit
import Then

final class SettingView: BaseView {
    
    let navTitle = WhiteTitleLabel().then {
        $0.text = "프로필 설정"
    }
    
    let profileImageView = UIImageView().then {
        $0.clipsToBounds = true
        $0.image = UIImage(systemName: "person")
        $0.tintColor = .white
        $0.layer.borderWidth = 5
        $0.layer.borderColor = UIColor.white.cgColor
        $0.contentMode = .scaleAspectFill
    }
    
    let profileEditBtn = UIButton().then {
        var configuration = UIButton.Configuration.gray()
        configuration.title = "프로필 이미지 설정"
        configuration.image = UIImage(systemName: "pencil")
        configuration.baseForegroundColor = .white
        configuration.baseBackgroundColor = .lightGray
        configuration.imagePadding = 10
        $0.configuration = configuration
    }
    
    let tableView = UITableView().then {
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.backgroundColor = .lightGray
        $0.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
    }

    
    override func configureHierarchy() {
        [
            tableView,
            profileImageView,
            profileEditBtn,
        ].forEach { addSubview($0) }
        
    }
    
    override func configureLayout() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.size.equalTo(100)
        }
        
        profileEditBtn.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
            make.height.equalTo(44)
            make.centerX.equalTo(safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(100)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(88)
        }
    }
    
    override func configureView() {
        
    }
    
}

extension SettingView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
    }
}
