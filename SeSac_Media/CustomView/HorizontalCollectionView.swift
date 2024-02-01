//
//  HorizontalCollectionView.swift
//  SeSac_Media
//
//  Created by youngjoo on 1/30/24.
//

import UIKit
import SnapKit
import Kingfisher

class HorizontalCollectionView: UICollectionView {
    
    var list: [TV] = []
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: HorizontalCollectionView.configureCollectionViewLayout())
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension HorizontalCollectionView {
    
    func updateData(data: [TV]) {
        self.list = data
        self.reloadData()
    }
    
    func configureView() {
        delegate = self
        dataSource = self
        register(HorizontalCollectionViewCell.self, forCellWithReuseIdentifier: "HorizontalCollectionViewCell")
        backgroundColor = .clear
    }
    
    static func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width/3.5, height: 150)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        return layout
    }
    
    
}

extension HorizontalCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HorizontalCollectionViewCell", for: indexPath) as! HorizontalCollectionViewCell
        
        let row = list[indexPath.item]
        
        guard let poster = row.poster_path else { return cell }
        let url = URL(string: TMDBAPI.baseImageURL + poster)
        cell.posterImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "square.and.arrow.down"))
        
        return cell
    }
    
    
}
