//
//  DetailViewController.swift
//  SeSac_Media
//
//  Created by youngjoo on 1/31/24.
//

import UIKit
import Kingfisher

class DetailViewController: BaseViewController {
    
    let mainView = DetailView()
    
    override func loadView() {
        self.view = mainView
    }
    
    var id = 0
    
    var titleList = ["출연진", "유사한 장르 추천"]
    var dataList: DetailModel = DetailModel(adult: false, backdropPath: "", genres: [], id: 0, originalName: "", overview: "", posterPath: "")
    var recommendList: [TV] = []
    var creditList: [Cast] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        
        let group = DispatchGroup()
        
        group.enter()
        TMDBAPIManager.shared.callRequest(type: DetailModel.self, api: .detail(id: id)) { detail in
            self.dataList = detail
            group.leave()
        }
        
        group.enter()
        TMDBAPIManager.shared.callRequest(type: TVModel.self, api: .recommend(id: id)) { recommend in
            self.recommendList = recommend.results
            group.leave()
        }
        
        group.enter()
        TMDBAPIManager.shared.callRequest(type: CreditModel.self, api: .credit(id: id)) { credit in
            self.creditList = credit.cast
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.mainView.tableView.reloadData()
        }
    }
    
}

extension DetailViewController {

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
