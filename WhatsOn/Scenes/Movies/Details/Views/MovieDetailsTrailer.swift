//
//  MovieDetailsTrailer.swift
//  What'sOn
//
//  Created by Maxime Maheo on 05/03/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import SnapKit
import UIKit
import WebKit

final class MovieDetailsTrailer: UIView {
    
    // MARK: - Outlets
    private let titleLabel = UILabel().apply {
        $0.textColor = .white
        $0.font = .h2
        $0.textAlignment = .left
        $0.text = R.string.localizable.title_trailer()
    }
    
    let trailerWebView = WKWebView().apply {
        $0.backgroundColor = .darkGrey900
        $0.scrollView.isScrollEnabled = false
        $0.scrollView.bounces = false
        $0.isOpaque = false
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
    func load(trailerUrl: URL) {
        trailerWebView.load(URLRequest(url: trailerUrl))
        
        UIView.animate(withDuration: Constants.defaultAnimationDuration) {
            self.trailerWebView.snp.updateConstraints { (make) in
                make.height.equalTo(UIScreen.height(percent: 30))
            }
        }
    }
    
    // MARK: - Private methods
    private func build() {
        backgroundColor = .darkGrey900
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        addSubview(trailerWebView)
        trailerWebView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.height.equalTo(0)
            make.bottom.equalToSuperview()
        }
    }
}
