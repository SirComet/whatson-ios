//
//  MovieDetailsRecommendations.swift
//  What'sOn
//
//  Created by Maxime Maheo on 05/03/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import SnapKit
import UIKit

final class MovieDetailsRecommendations: UIView {
    
    // MARK: - Outlets
    private let titleLabel = UILabel().apply {
        $0.textColor = .white
        $0.font = .h2
        $0.textAlignment = .left
        $0.text = R.string.localizable.title_recommendations()
    }
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().apply {
        $0.minimumLineSpacing = 16
        $0.minimumInteritemSpacing = 16
        $0.scrollDirection = .horizontal
        $0.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }).apply {
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .darkGrey900
        $0.register(StandardCell.self, forCellWithReuseIdentifier: "\(StandardCell.self)")
    }
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)

        build()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    
    // MARK: - Private methods
    private func build() {
        backgroundColor = .darkGrey900
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.height.equalTo(StandardCell.size.height + 8)
            make.bottom.equalToSuperview()
        }
    }
}
