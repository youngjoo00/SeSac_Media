//
//  MediaViewController.swift
//  SeSac_Media
//
//  Created by youngjoo on 1/31/24.
//

import UIKit
import SnapKit
import Then

class MediaViewController: BaseViewController {

    lazy var tableView = UITableView().then {
        $0.delegate = self
        $0.dataSource = self
        $0.register(MediaTableViewCell.self, forCellReuseIdentifier: MediaTableViewCell.identifier)
        $0.rowHeight = 210
        $0.backgroundColor = .clear
        $0.isScrollEnabled = false
    }
    
    var titleList: [String] = []
    
    var dataList: [[Media]] = Array(repeating: [], count: TMDBAPIManager.Home.allCases.count)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let group = DispatchGroup()
        
        for i in 0..<TMDBAPIManager.Home.allCases.count {
            group.enter()
            let url = TMDBAPIManager.Home.allCases[i].url
            TMDBAPIManager.shared.mediaRequest(url: url) { data in
                self.dataList[i] = data
                group.leave()
            }
        }
        
        for i in TMDBAPIManager.Home.allCases {
            titleList.append(i.rawValue)
        }
        
        group.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
    
    override func configureHierarchy() {
        [
            tableView
        ].forEach { view.addSubview($0) }
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
    }
    
}

extension MediaViewController {
    
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalCollectionViewCell.identifier, for: indexPath) as! HorizontalCollectionViewCell
        
        guard let poster = dataList[collectionView.tag][indexPath.row].poster_path else { return cell }
        let url = URL(string: TMDBAPIManager.shared.baseImageURL + poster)
        cell.posterImageView.kf.setImage(with: url)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let vc = DetailViewController()
        vc.id = dataList[collectionView.tag][indexPath.item].id

        navigationController?.pushViewController(vc, animated: true)
    }
}
