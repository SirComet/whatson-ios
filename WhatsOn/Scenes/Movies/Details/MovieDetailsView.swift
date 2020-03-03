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
    public private(set) lazy var blurImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.alpha = 0
        
        return imageView
    }()

    public private(set) lazy var gradientImageView: UIImageView = {
        UIImageView()
    }()
    
    public private(set) lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 4
        imageView.layer.masksToBounds = true
        imageView.alpha = 0
        
        return imageView
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
    
    public private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .h2
        label.textAlignment = .center
        label.numberOfLines = 2
        label.alpha = 0
        
        return label
    }()

    public private(set) lazy var informationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fill
        
        return stackView
    }()
    
    public private(set) lazy var markLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .p2
        label.textAlignment = .left
        label.alpha = 0
        
        return label
    }()
    
    public private(set) lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGrey800
        label.font = .p3
        label.textAlignment = .left
        label.alpha = 0
        
        return label
    }()
    
    public private(set) lazy var durationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGrey800
        label.font = .p3
        label.textAlignment = .left
        label.alpha = 0
        
        return label
    }()
    
    public private(set) lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .p3
        label.textAlignment = .left
        label.numberOfLines = 0
        label.alpha = 0
        
        return label
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
        super.init(frame: frame)

        build()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    private func build() {
        backgroundColor = .darkGrey900
        
        addSubview(blurImageView)
        blurImageView.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(UIScreen.height(percent: 50))
        }
        
        addSubview(gradientImageView)
        gradientImageView.image = UIImage.withGradient(colors: [UIColor.darkGrey900.withAlphaComponent(0.5), .darkGrey900],
                                                       size: CGSize(width: UIScreen.width,
                                                                    height: UIScreen.height(percent: 50)))
        gradientImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(blurImageView)
        }
        
        addSubview(posterImageView)
        posterImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(gradientImageView)
            make.height.equalTo(200)
            make.width.equalTo(posterImageView.snp.height).multipliedBy(0.66)
        }
        
        addSubview(dismissButton)
        dismissButton.snp.makeConstraints { (make) in
            make.trailing.top.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.width.equalTo(24)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            make.top.equalTo(posterImageView.snp.bottom).offset(16)
        }
        
        addSubview(informationStackView)
        informationStackView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
        }
        
        [ markLabel,
          releaseDateLabel,
          durationLabel ].forEach { informationStackView.addArrangedSubview($0) }
        
        addSubview(overviewLabel)
        overviewLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(titleLabel)
            make.top.equalTo(informationStackView.snp.bottom).offset(16)
        }
        
        addSubview(genresLabel)
        genresLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(overviewLabel)
            make.top.equalTo(overviewLabel.snp.bottom).offset(32)
        }
        
        addSubview(genresCollectionView)
        genresCollectionView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(genresLabel.snp.bottom).offset(16)
            make.height.equalTo(GenreCell.size.height)
        }
    }
    
    func displayBlurImage(with image: UIImage?) {
        blurImageView.image = image
        
        UIView.animate(withDuration: Constants.defaultDuration) {
            self.blurImageView.alpha = 1
            
            self.layoutIfNeeded()
        }
    }
    
    func displayPosterImage(with image: UIImage?) {
        posterImageView.image = image
        
        UIView.animate(withDuration: Constants.defaultDuration) {
            self.posterImageView.alpha = 1

            self.layoutIfNeeded()
        }
    }
    
    func displayMovieInformation() {
        UIView.animate(withDuration: Constants.defaultDuration) {
            self.titleLabel.alpha = 1
            self.overviewLabel.alpha = 1
            self.markLabel.alpha = 1
            self.releaseDateLabel.alpha = 1

            self.layoutIfNeeded()
        }
    }
    
    func display(duration: String) {
        durationLabel.text = duration
        
        UIView.animate(withDuration: Constants.defaultDuration) {
            self.durationLabel.alpha = 1
            
            self.layoutIfNeeded()
        }
    }
}
