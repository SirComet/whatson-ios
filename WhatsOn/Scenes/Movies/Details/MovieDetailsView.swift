//
//  MovieDetailsView.swift
//  What'sOn
//
//  Created by Maxime Maheo on 27/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import SnapKit
import UIKit

final class MovieDetailsView: UIView {
    
    // MARK: - Outlets
    public private(set) lazy var movieDetailsTopInformation: MovieDetailsTopInformation = {
        MovieDetailsTopInformation()
    }()
    
    public private(set) lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkGrey600
        button.layer.cornerRadius = 12
        button.tintColor = .white
        button.setImage(R.image.icons_times()?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        
        return button
    }()
    
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
        super.init(frame: frame.size == .zero ? UIScreen.main.bounds : frame)

        build()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func build() {
        backgroundColor = .darkGrey900
        
        addSubview(movieDetailsTopInformation)
        movieDetailsTopInformation.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
        }
        
        addSubview(dismissButton)
        dismissButton.snp.makeConstraints { (make) in
            make.trailing.top.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.width.equalTo(24)
        }
        
        addSubview(genresLabel)
        genresLabel.snp.makeConstraints { (make) in
            make.top.equalTo(movieDetailsTopInformation.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        addSubview(genresCollectionView)
        genresCollectionView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(genresLabel.snp.bottom).offset(8)
            make.height.equalTo(GenreCell.size.height + 8)
        }
    }
}
