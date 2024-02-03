//
//  DetailView.swift
//  SeSac_Media
//
//  Created by youngjoo on 2/3/24.
//

import UIKit

class DetailView: BaseView {
    
    let tableView = UITableView().then {
        $0.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.identifier)
        $0.register(DetailSubTableViewCell.self, forCellReuseIdentifier: DetailSubTableViewCell.identifier)
        $0.backgroundColor = .clear
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

