//
//  ProfileSearchViewController.swift
//  SeSac_Media
//
//  Created by youngjoo on 2/9/24.
//

import UIKit
import Kingfisher

final class ProfileSearchViewController: BaseViewController {
    
    let mainView = ProfileSearchView()
    
    var start = 1
    var sort = "sim"
    
    var searchList: ProfileSearchModel = ProfileSearchModel(total: 0, items: []) {
        didSet {
            mainView.collectionView.reloadData()
        }
    }
    
    var imageSpace: ((String) -> Void)?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = mainView.navTitle
        mainView.searchBar.delegate = self
        
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
}

extension ProfileSearchViewController {
    
    private func fetchSearchImage(text query: String) {
        NaverAPIManager.shared.callRequest(type: ProfileSearchModel.self,
                                           api: .imageSearch(query: query, start: start, sort: sort)) { search, error in
            if let search = search {
                self.searchList = search
            } else {
                guard let error = error else { return }
                self.showToast(message: error.rawValue)
            }
            print(self.searchList)
        }
    }
}

extension ProfileSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        fetchSearchImage(text: text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
    }
}

extension ProfileSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchList.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as! PosterCollectionViewCell
        
        let row = indexPath.row
        let url = URL(string: searchList.items[row].link)
        cell.posterImageView.kf.setImage(with: url)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        showAlert(title: "알림", message: "프로필 사진으로 설정하시겠습니까?", btnTitle: "확인") {
            self.imageSpace?(self.searchList.items[indexPath.item].link)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
}
