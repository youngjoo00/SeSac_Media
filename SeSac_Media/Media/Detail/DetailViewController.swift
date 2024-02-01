//
//  DetailViewController.swift
//  SeSac_Media
//
//  Created by youngjoo on 1/31/24.
//

import UIKit
import Kingfisher

class DetailViewController: BaseViewController {
    
    var id = 0
    
    lazy var tableView = UITableView().then {
        $0.dataSource = self
        $0.delegate = self
        $0.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.identifier)
        $0.register(DetailSubTableViewCell.self, forCellReuseIdentifier: DetailSubTableViewCell.identifier)
        $0.backgroundColor = .clear
    }
    
    var titleList = ["출연진", "유사한 장르 추천"]
    var dataList: DetailModel = DetailModel(adult: false, backdropPath: "", genres: [], id: 0, originalName: "", overview: "", posterPath: "")
    var recommendList: [TV] = []
    var creditList: [Cast] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let group = DispatchGroup()
        
        group.enter()
        TMDBAPIManager.shared.fetchDetail(api: .detail(id: id)) { detail in
            self.dataList = detail
            group.leave()
        }
        
        group.enter()
        TMDBAPIManager.shared.fetchTV(api: .recommend(id: id)) { recommend in
            self.recommendList = recommend
            print(self.recommendList)
            group.leave()
        }
        
        group.enter()
        TMDBAPIManager.shared.fetchCredit(api: .credit(id: id)) { credit in
            self.creditList = credit
            print(self.creditList)
            group.leave()
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

extension DetailViewController {
    func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: 120, height: 160)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        return layout
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleList.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier, for: indexPath) as! DetailTableViewCell
            
            let url = URL(string: TMDBAPI.baseImageURL + dataList.backdropPath)
            cell.posterImage.kf.setImage(with: url, placeholder: UIImage(systemName: "star"))
            cell.titleLabel.text = dataList.originalName
            cell.overviewLabel.text = dataList.overview
            cell.airDateLabel.text = "2000.00.00"
            cell.genresLabel.text = "장르"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailSubTableViewCell.identifier, for: indexPath) as! DetailSubTableViewCell

            cell.titleLabel.text = titleList[indexPath.row - 1]
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            cell.collectionView.tag = indexPath.row - 1
            
            cell.collectionView.reloadData()
            return cell
        }
    }

}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView.tag == 0 {
            return creditList.count
        } else {
            return recommendList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalCollectionViewCell.identifier, for: indexPath) as! HorizontalCollectionViewCell
        
        if collectionView.tag == 0 {
            guard let poster = creditList[indexPath.row].profilePath else { return cell }
            let url = URL(string: TMDBAPI.baseImageURL + poster)
            cell.posterImageView.kf.setImage(with: url)
        } else {
            guard let poster = recommendList[indexPath.row].poster_path else { return cell }
            let url = URL(string: TMDBAPI.baseImageURL + poster)
            cell.posterImageView.kf.setImage(with: url)
        }
        
        return cell
    }
    
    
}
