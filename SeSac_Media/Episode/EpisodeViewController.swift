//
//  EpisodeViewController.swift
//  SeSac_Media
//
//  Created by youngjoo on 2/5/24.
//

import UIKit

final class EpisodeViewController: BaseViewController {
    
    let mainView = EpisodeView()
    
    var data: (id: Int, seasonNumber: Int) = (0, 0)
    var dataList: SeasonDetailModel = SeasonDetailModel(episodes: [])
    
    override func loadView() {
        self.view = mainView
        
        navigationItem.titleView = mainView.navTitle
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        TMDBAPIManager.shared.callRequest(type: SeasonDetailModel.self,
                                          api: .seasonDetail(seriseID: data.id,seasonNumber: data.seasonNumber)) { episode, error in
            
            if let episode = episode {
                self.dataList = episode
                self.mainView.tableView.reloadData()
            } else {
                guard let error = error else { return }
                print(error)
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
}

extension EpisodeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeTableViewCell.identifier, for: indexPath) as! EpisodeTableViewCell
        
        let row = dataList.episodes[indexPath.row]

        if row.still_path! != "xmark" {
            let url = URL(string: TMDBAPI.baseImageURL + row.still_path!)
            cell.posterImage.kf.setImage(with: url)
        } else {
            cell.posterImage.image = UIImage(systemName: row.still_path!)
        }
        
        cell.titleLabel.text = "\(row.episode_number). " + row.name
        cell.overviewLabel.text = row.overview
        
        if row.runtime! != 0 {
            cell.runTimeLabel.text = "\(row.runtime!)분"
        } else {
            cell.runTimeLabel.text = "정보 없음"
        }
        
        return cell
    }
    
    
}

