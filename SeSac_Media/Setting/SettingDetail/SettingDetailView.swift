//
//  SettingDetailView.swift
//  SeSac_Media
//
//  Created by youngjoo on 2/9/24.
//

import UIKit
import SnapKit
import Then

final class SettingDetailView: BaseView {
    
    let navTitle = WhiteTitleLabel()
    
    let titleLabel = WhiteTitleLabel()
    
    let inputTextField = UserInputTextField()
    
    let confirmBtn = UIButton().then {
        $0.setTitle("저장", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .lightGray
    }
    
    override func configureHierarchy() {
        [
            titleLabel,
            inputTextField,
            confirmBtn
        ].forEach { addSubview($0) }
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
            make.leading.equalTo(16)
            make.height.equalTo(20)
        }
        
        inputTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(44)
        }
        
        confirmBtn.snp.makeConstraints { make in
            make.center.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(44)
        }
    }
    
    override func configureView() {
        
    }
    
}
