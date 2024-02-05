//
//  MediaViewController.swift
//  SeSac_Media
//
//  Created by youngjoo on 1/31/24.
//

import UIKit
import SnapKit
import Then
import Toast

class MediaViewController: BaseViewController {

    let mainView = MediaView()
    
    override func loadView() {
        self.view = mainView
    }
    
    var titleList: [String] = ["TV Trend", "Top Rate", "Popular"]
    lazy var dataList: [[TV]] = Array(repeating: [], count: titleList.count)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.titleView = mainView.navTitle
        
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self

        let group = DispatchGroup()
        
        group.enter()
        TMDBSessionManager.shared.callRequest(type: TVModel.self, api: .tvTrend) { tv, error in
            
            if let tv = tv {
                self.dataList[0] = tv.results
            } else {
                guard let error = error else { return }
                self.showToast(message: error.rawValue)
            }
            group.leave()
            
            
        }
        
        group.enter()
        TMDBSessionManager.shared.callRequest(type: TVModel.self, api: .topRate) { tv, error in
            
            if let tv = tv {
                self.dataList[1] = tv.results
            } else {
                guard let error = error else { return }
                self.showToast(message: error.rawValue)
            }
            group.leave()
        }
        
        group.enter()
        TMDBSessionManager.shared.callRequest(type: TVModel.self, api: .popular) { tv, error in
            
            if let tv = tv {
                self.dataList[2] = tv.results
            } else {
                guard let error = error else { return }
                self.showToast(message: error.rawValue)
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.mainView.tableView.reloadData()
        }
        
    }
    
}

extension MediaViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MediaTableViewCell.identifier, for: indexPath) as! MediaTableViewCell
        
        // 테이블뷰 셀 안에 있는 콜렉션 뷰에게 프로토콜 채택
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        
        cell.titleLabel.text = titleList[indexPath.row]
        cell.collectionView.tag = indexPath.row

        cell.collectionView.reloadData()

        return cell
    }

}

extension MediaViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as! PosterCollectionViewCell
        
        guard let poster = dataList[collectionView.tag][indexPath.row].poster_path else { return cell }
        let url = URL(string: TMDBAPI.baseImageURL + poster)
        cell.posterImageView.kf.setImage(with: url)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let vc = DetailViewController()
        vc.id = dataList[collectionView.tag][indexPath.item].id

        navigationController?.pushViewController(vc, animated: true)
    }
}
