//
//  DetailViewController.swift
//  SeSac_Media
//
//  Created by youngjoo on 1/31/24.
//

import UIKit
import Kingfisher

final class DetailViewController: BaseViewController {
    
    let mainView = DetailView()
    
    override func loadView() {
        self.view = mainView
    }
    
    var id = 0
    
    var titleList = ["", "출연진", "유사한 장르 추천"]
    var dataList: DetailModel = DetailModel(adult: false, backdropPath: "", genres: [], id: 0, originalName: "", overview: "", posterPath: "", seasons: [])
    var recommendList: [TV] = []
    var creditList: [Cast] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        navigationItem.titleView = mainView.navTitle
        
        let group = DispatchGroup()
        
        group.enter()
        TMDBAPIManager.shared.callRequest(type: DetailModel.self, api: .detail(id: id)) { detail, error in
            
            if let detail = detail {
                self.dataList = detail
            } else {
                guard let error = error else { return }
                self.showToast(message: error.rawValue)
            }
            group.leave()
        }
        
        group.enter()
        TMDBAPIManager.shared.callRequest(type: TVModel.self, api: .recommend(id: id)) { recommend, error in
            
            if let recommend = recommend {
                self.recommendList = recommend.results
            } else {
                guard let error = error else { return }
                self.showToast(message: error.rawValue)
            }
            group.leave()
        }
        
        group.enter()
        TMDBAPIManager.shared.callRequest(type: CreditModel.self, api: .credit(id: id)) { credit, error in
            
            if let credit = credit {
                self.creditList = credit.cast
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

extension DetailViewController {

    @objc func didPlayBtnTapped() {
        let vc = VideoViewController()
        vc.id = id
        transition(viewController: vc, style: .push)
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.seasons.count + titleList.count
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
            cell.playBtn.addTarget(self, action: #selector(didPlayBtnTapped), for: .touchUpInside)
            return cell
        } else if indexPath.row == 1 + dataList.seasons.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailSubTableViewCell.identifier, for: indexPath) as! DetailSubTableViewCell

            cell.titleLabel.text = titleList[indexPath.row - dataList.seasons.count]
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            cell.collectionView.tag = indexPath.row - dataList.seasons.count - 1
            
            cell.collectionView.reloadData()
            return cell
        } else if indexPath.row == 2 + dataList.seasons.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailSubTableViewCell.identifier, for: indexPath) as! DetailSubTableViewCell

            cell.titleLabel.text = titleList[indexPath.row - dataList.seasons.count]
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            cell.collectionView.tag = indexPath.row - dataList.seasons.count
            
            cell.collectionView.reloadData()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailSeasonTableViewCell.identifier, for: indexPath) as! DetailSeasonTableViewCell
            
            let row = dataList.seasons[indexPath.row - 1]

            cell.titleLabel.text = row.name
            
            if row.poster_path! != "xmark" {
                let url = URL(string: TMDBAPI.baseImageURL + row.poster_path!)
                cell.posterImageView.kf.setImage(with: url)
            } else {
                cell.posterImageView.image = UIImage(systemName: row.poster_path!)
            }
            
            
            cell.episodeCount.text = "Episode \(row.episode_count)"
            
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row - 1
        print(row)
        if row >= 0 && row < dataList.seasons.count {
            let vc = EpisodeViewController()
            vc.data = (dataList.id, dataList.seasons[row].season_number)
            transition(viewController: vc, style: .push)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as! PosterCollectionViewCell
        
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
