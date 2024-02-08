//
//  DramaViewController.swift
//  SeSac_Media
//
//  Created by youngjoo on 1/31/24.
//

import UIKit

final class SearchViewController: BaseViewController {

    let mainView = SearchView()
    
    override func loadView() {
        self.view = mainView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.searchBar.delegate = self
        navigationItem.titleView = mainView.navTitle
        
    }

}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let vc = SearchDetailViewController()
        vc.searchText = searchBar.text!
        transition(viewController: vc, style: .push)
    }
}
