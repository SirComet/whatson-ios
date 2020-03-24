//
//  GenreView.swift
//  What'sOn
//
//  Created by Maxime Maheo on 27/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import SnapKit
import UIKit

final class GenreView: UIView {

    // MARK: - Outlets
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().apply {
        $0.minimumLineSpacing = 16
        $0.minimumInteritemSpacing = 16
        $0.scrollDirection = .horizontal
        $0.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }).apply {
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .darkGrey900
        $0.register(GenreCell.self, forCellWithReuseIdentifier: "\(GenreCell.self)")
    }
    
    let activityIndicatorView = UIActivityIndicatorView().apply {
        $0.color = .white
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
    private func build() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
}
