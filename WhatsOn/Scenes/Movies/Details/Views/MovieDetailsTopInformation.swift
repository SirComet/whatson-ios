//
//  MovieDetailsTopInformation.swift
//  What'sOn
//
//  Created by Maxime Maheo on 04/03/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import SnapKit
import UIKit

final class MovieDetailsTopInformation: UIView {
    
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
        label.text = "--"
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
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)

        build()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    func display(posterImage: UIImage?) {
        blurImageView.image = posterImage?.blur(radius: 40)
        posterImageView.image = posterImage
        
        UIView.animate(withDuration: Constants.defaultAnimationDuration) {
            self.blurImageView.alpha = 1
            self.posterImageView.alpha = 1

            self.layoutIfNeeded()
        }
    }
    
    func display(title: String, mark: String, releaseDate: String, overview: String) {
        titleLabel.text = title
        markLabel.text = mark
        releaseDateLabel.text = releaseDate
        overviewLabel.text = overview
        
        UIView.animate(withDuration: Constants.defaultAnimationDuration) {
            self.titleLabel.alpha = 1
            self.markLabel.alpha = 1
            self.releaseDateLabel.alpha = 1
            self.overviewLabel.alpha = 1
            self.durationLabel.alpha = 1
        }
    }
    
    func display(duration: String) {
        durationLabel.text = duration
    }
    
    // MARK: - Private methods
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
            make.centerY.equalTo(blurImageView)
            make.centerX.equalToSuperview()
            make.height.equalTo(200)
            make.width.equalTo(posterImageView.snp.height).multipliedBy(0.66)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(16)
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
            make.bottom.equalToSuperview()
        }
    }
}
