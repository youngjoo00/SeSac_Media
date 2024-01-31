//
//  DetailTableViewCell.swift
//  SeSac_Media
//
//  Created by youngjoo on 1/31/24.
//

import UIKit

class DetailTableViewCell: BaseTableViewCell {

    let posterImage = UIImageView()
    let titleLabel = WhiteTitleLabel()
    let genresLabel = WhiteTitleLabel()
    let overviewLabel = WhiteTitleLabel()
    let airDateLabel = WhiteTitleLabel()
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout()).then {
        $0.backgroundColor = .clear
        $0.register(HorizontalCollectionViewCell.self, forCellWithReuseIdentifier: HorizontalCollectionViewCell.identifier)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        [
            posterImage,
            titleLabel,
            genresLabel,
            overviewLabel,
            airDateLabel,
            collectionView
        ].forEach { contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        posterImage.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView)
            make.height.equalTo(200)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImage.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(contentView).inset(8)
            make.height.equalTo(20)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(titleLabel)
        }
        
        airDateLabel.snp.makeConstraints { make in
            make.top.equalTo(overviewLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(titleLabel)
            make.height.equalTo(20)
        }
        
        genresLabel.snp.makeConstraints { make in
            make.top.equalTo(airDateLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(titleLabel)
            make.height.equalTo(20)
            make.bottom.equalTo(contentView).offset(-10)
        }
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
    override func configureView() {
        posterImage.contentMode = .scaleToFill
        
        titleLabel.font = .boldSystemFont(ofSize: 20)
        
        overviewLabel.font = .systemFont(ofSize: 15)
        overviewLabel.numberOfLines = 0
    }
}

extension DetailTableViewCell {
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
