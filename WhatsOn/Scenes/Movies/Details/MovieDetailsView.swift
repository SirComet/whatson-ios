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
}
