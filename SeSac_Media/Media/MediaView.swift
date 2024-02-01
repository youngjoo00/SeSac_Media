//
//  MediaView.swift
//  SeSac_Media
//
//  Created by youngjoo on 2/1/24.
//

import UIKit

class MediaView: BaseView {
    
    let tableView = UITableView().then {
        $0.register(MediaTableViewCell.self, forCellReuseIdentifier: MediaTableViewCell.identifier)
        $0.rowHeight = 210
        $0.backgroundColor = .clear
        $0.isScrollEnabled = false
    }
    
    override func configureHierarchy() {
        [
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
