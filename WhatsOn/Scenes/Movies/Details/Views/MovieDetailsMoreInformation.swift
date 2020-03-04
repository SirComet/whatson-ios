//
//  MovieDetailsMoreInformation.swift
//  What'sOn
//
//  Created by Maxime Maheo on 04/03/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import SnapKit
import UIKit

final class MovieDetailsMoreInformation: UIView {
    
    // MARK: - Outlets
    public private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .h2
        label.text = R.string.localizable.title_more_information()
        
        return label
    }()
    
    public private(set) lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    public private(set) lazy var popularityStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    public private(set) lazy var popularityTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .p2
        label.text = R.string.localizable.title_popularity()
        
        return label
    }()
    
    public private(set) lazy var popularityValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGrey800
        label.font = .p3
        
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
    func display(popularity: Double) {
        popularityValueLabel.text = "\(Int(popularity)) \(R.string.localizable.title_points())"
        
        UIView.animate(withDuration: Constants.defaultDuration) {
            self.popularityValueLabel.alpha = 1
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
        
        addSubview(contentStackView)
        contentStackView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
        
        [ popularityStackView ].forEach { contentStackView.addArrangedSubview($0) }
        
        [ popularityTitleLabel,
          popularityValueLabel ].forEach { popularityStackView.addArrangedSubview($0) }
    }
}
