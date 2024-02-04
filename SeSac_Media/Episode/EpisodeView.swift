//
//  EpisodeView.swift
//  SeSac_Media
//
//  Created by youngjoo on 2/5/24.
//

import UIKit
import SnapKit
import Then

class EpisodeView: BaseView {
    
    let navTitle = WhiteTitleLabel()
    let tableView = UITableView().then {
        $0.register(EpisodeTableViewCell.self, forCellReuseIdentifier: EpisodeTableViewCell.identifier)
        $0.backgroundColor = .clear
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 300
    }
    
    override func configureHierarchy() {
        [
            navTitle,
            tableView
        ].forEach { addSubview($0) }
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        
    }
}
