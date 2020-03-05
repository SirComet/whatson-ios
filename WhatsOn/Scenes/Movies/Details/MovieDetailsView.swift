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
    public private(set) lazy var scrollView: UIScrollView = {
        UIScrollView()
    }()
    
    public private(set) lazy var containerView: UIView = {
        UIView()
    }()
    
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
    
    public private(set) lazy var movieDetailsGenre: MovieDetailsGenre = {
        MovieDetailsGenre()
    }()
    
    public private(set) lazy var movieDetailsRecommendations: MovieDetailsRecommendations = {
        MovieDetailsRecommendations()
    }()
    
    public private(set) lazy var movieDetailsMoreInformation: MovieDetailsMoreInformation = {
        MovieDetailsMoreInformation()
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
        
        addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().priority(250)
        }
        
        containerView.addSubview(movieDetailsTopInformation)
        movieDetailsTopInformation.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
        }
        
        containerView.addSubview(dismissButton)
        dismissButton.snp.makeConstraints { (make) in
            make.trailing.top.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.width.equalTo(24)
        }
        
        containerView.addSubview(movieDetailsGenre)
        movieDetailsGenre.snp.makeConstraints { (make) in
            make.top.equalTo(movieDetailsTopInformation.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview()
        }
        
        containerView.addSubview(movieDetailsRecommendations)
        movieDetailsRecommendations.snp.makeConstraints { (make) in
            make.top.equalTo(movieDetailsGenre.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview()
        }
        
        containerView.addSubview(movieDetailsMoreInformation)
        movieDetailsMoreInformation.snp.makeConstraints { (make) in
            make.top.equalTo(movieDetailsRecommendations.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(32)
        }
    }
}
