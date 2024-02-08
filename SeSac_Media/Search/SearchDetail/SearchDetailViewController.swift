//
//  SearchDetailViewController.swift
//  SeSac_Media
//
//  Created by youngjoo on 2/4/24.
//

import UIKit

final class SearchDetailViewController: BaseViewController {

    let mainView = SearchDetailView()
    
    var searchText = ""
    var dataList: [TV] = []
    override func loadView() {
        self.view = mainView
        
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TMDBAPIManager.shared.callRequest(type: TVModel.self, api: .search(query: searchText)) { search, error in
            
            if let search = search {
                self.dataList = search.results
            } else {
                guard let error = error else { return }
                print(error)
            }
            self.mainView.collectionView.reloadData()
        }
    }
    
    override func configureView() {
        mainView.navTitle.text = searchText
        navigationItem.titleView = mainView.navTitle
    }
}

extension SearchDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as! PosterCollectionViewCell
        
        let item = dataList[indexPath.item]
        
        guard let poster = item.poster_path else { return cell }
        
        let url = URL(string: TMDBAPI.baseImageURL + poster)
        cell.posterImageView.kf.setImage(with: url)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = DetailViewController()
        vc.id = dataList[indexPath.item].id
        
        transition(viewController: vc, style: .push)
    }
}
