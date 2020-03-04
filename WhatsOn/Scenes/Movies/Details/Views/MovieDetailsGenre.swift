//
//  MovieDetailsGenre.swift
//  What'sOn
//
//  Created by Maxime Maheo on 04/03/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import SnapKit
import UIKit

final class MovieDetailsGenre: UIView {
    
    // MARK: - Outlets
    public private(set) lazy var genresLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .h2
        label.textAlignment = .left
        label.text = R.string.localizable.section_genre()
        
        return label
    }()
    
    public private(set) lazy var genresCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .darkGrey900
        collectionView.register(GenreCell.self, forCellWithReuseIdentifier: "\(GenreCell.self)")
        
        return collectionView
    }()
    
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
        
        addSubview(genresLabel)
        genresLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        addSubview(genresCollectionView)
        genresCollectionView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(genresLabel.snp.bottom).offset(8)
            make.height.equalTo(GenreCell.size.height + 8)
            make.bottom.equalToSuperview()
        }
    }
}
