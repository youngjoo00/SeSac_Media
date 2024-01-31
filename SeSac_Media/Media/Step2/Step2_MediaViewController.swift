//
//  Step2_MediaViewController.swift
//  SeSac_Media
//
//  Created by youngjoo on 1/31/24.
//

import UIKit
import SnapKit
import Then

class Step2_MediaViewController: BaseViewController {

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: HorizontalCollectionView.configureCollectionViewLayout())
    var list: [[Media]] = Array(repeating: [], count: TMDBAPIManager.List.allCases.count)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        
        for i in 0..<TMDBAPIManager.List.allCases.count {
            let url = TMDBAPIManager.List.allCases[i].url
            TMDBAPIManager.shared.callRequest(url: url) { data in
                self.list[i] = data
                self.collectionView.reloadData()
            }
        }
    }
  
    override func configureHierarchy() {
        [
            collectionView
        ].forEach { view.addSubview($0) }
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HorizontalCollectionViewCell.self, forCellWithReuseIdentifier: HorizontalCollectionViewCell.identifier)
        collectionView.backgroundColor = .black
    }
    
}

extension Step2_MediaViewController {

}

extension Step2_MediaViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalCollectionViewCell.identifier, for: indexPath) as! HorizontalCollectionViewCell
        
        print(indexPath.section, indexPath.item, list[indexPath.section][indexPath.item])
        let row = list[indexPath.section][indexPath.item]
        guard let poster = row.poster_path else { return cell }
        
        let url = URL(string: TMDBAPIManager.shared.baseImageURL + poster)
        cell.posterImageView.kf.setImage(with: url)
        return cell
    }
    
    
}
