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
    private let scrollView = UIScrollView()
    
    private let containerView = UIView()
    
    let movieDetailsTopInformation = MovieDetailsTopInformation()
    
    let dismissButton = UIButton().apply {
        $0.backgroundColor = .darkGrey600
        $0.layer.cornerRadius = 12
        $0.tintColor = .white
        $0.setImage(R.image.icons_times()?.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.imageEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
    }
    
    let movieDetailsGenre = MovieDetailsGenre()
    
    let movieDetailsTrailer = MovieDetailsTrailer()
    
    let movieDetailsCast = MovieDetailsCast()
    
    let movieDetailsRecommendations = MovieDetailsRecommendations()
    
    let movieDetailsMoreInformation = MovieDetailsMoreInformation()
    
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
        
        containerView.addSubview(movieDetailsTrailer)
        movieDetailsTrailer.snp.makeConstraints { (make) in
            make.top.equalTo(movieDetailsGenre.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview()
        }
        
        containerView.addSubview(movieDetailsCast)
        movieDetailsCast.snp.makeConstraints { (make) in
            make.top.equalTo(movieDetailsTrailer.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview()
        }
        
        containerView.addSubview(movieDetailsRecommendations)
        movieDetailsRecommendations.snp.makeConstraints { (make) in
            make.top.equalTo(movieDetailsCast.snp.bottom).offset(32)
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
