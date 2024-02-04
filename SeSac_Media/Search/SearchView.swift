//
//  SearchView.swift
//  SeSac_Media
//
//  Created by youngjoo on 2/4/24.
//

import UIKit
import SnapKit
import Then

class SearchView: BaseView {
    
    let navTitle = WhiteTitleLabel().then {
        $0.text = "검색"
    }
    
    let searchBar = UISearchBar().then {
        $0.searchBarStyle = .minimal
        $0.placeholder = "원하시는 TV 프로그램을 검색해보세요"
        $0.searchTextField.backgroundColor = .systemGray4
    }
    
    override func configureHierarchy() {
        [
            searchBar,
        ].forEach { addSubview($0) }
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
        }
    }
    
    override func configureView() {
        
    }
    
    
}
