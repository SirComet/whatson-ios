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
    private let blurImageView = UIImageView().apply {
        $0.contentMode = .scaleAspectFill
        $0.layer.masksToBounds = true
        $0.alpha = 0
    }

    private let gradientImageView = UIImageView()
    
    private let posterImageView = UIImageView().apply {
        $0.layer.cornerRadius = 4
        $0.layer.masksToBounds = true
        $0.alpha = 0
    }
    
    private let titleLabel = UILabel().apply {
        $0.textColor = .white
        $0.font = .h2
        $0.textAlignment = .center
        $0.numberOfLines = 2
        $0.alpha = 0
    }
    
    private let informationStackView = UIStackView().apply {
        $0.axis = .horizontal
        $0.spacing = 16
        $0.distribution = .fill
    }
    
    private let markLabel = UILabel().apply {
        $0.textColor = .white
        $0.font = .p2
        $0.textAlignment = .left
        $0.alpha = 0
    }
    
    private let releaseDateLabel = UILabel().apply {
        $0.textColor = .lightGrey800
        $0.font = .p3
        $0.textAlignment = .left
        $0.alpha = 0
    }
    
    private let durationLabel = UILabel().apply {
        $0.textColor = .lightGrey800
        $0.font = .p3
        $0.textAlignment = .left
        $0.text = "--"
        $0.alpha = 0
    }
    
    private let overviewLabel = UILabel().apply {
        $0.textColor = .white
        $0.font = .p3
        $0.textAlignment = .left
        $0.numberOfLines = 0
        $0.alpha = 0
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
