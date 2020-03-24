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
    private let titleLabel = UILabel().apply {
        $0.textColor = .white
        $0.font = .h2
        $0.text = R.string.localizable.title_more_information()
    }
    
    private let contentStackView = UIStackView().apply {
        $0.axis = .vertical
        $0.spacing = 8
        $0.distribution = .fillEqually
    }
    
    private let popularityStackView = UIStackView().apply {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.distribution = .fillEqually
    }
    
    private let popularityTitleLabel = UILabel().apply {
        $0.textColor = .white
        $0.font = .p2
        $0.text = R.string.localizable.title_popularity()
    }
    
    private let popularityValueLabel = UILabel().apply {
        $0.textColor = .lightGrey800
        $0.font = .p3
    }
    
    private let statusStackView = UIStackView().apply {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.distribution = .fillEqually
    }
    
    private let statusTitleLabel = UILabel().apply {
        $0.textColor = .white
        $0.font = .p2
        $0.text = R.string.localizable.title_status()
    }
    
    private let statusValueLabel = UILabel().apply {
        $0.textColor = .lightGrey800
        $0.font = .p3
    }
    
    private let revenueStackView = UIStackView().apply {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.distribution = .fillEqually
    }
    
    private let revenueTitleLabel = UILabel().apply {
        $0.textColor = .white
        $0.font = .p2
        $0.text = R.string.localizable.title_revenue()
    }
    
    private let revenueValueLabel = UILabel().apply {
        $0.textColor = .lightGrey800
        $0.font = .p3
    }
    
    private let budgetStackView = UIStackView().apply {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.distribution = .fillEqually
    }
    
    private let budgetTitleLabel = UILabel().apply {
        $0.textColor = .white
        $0.font = .p2
        $0.text = R.string.localizable.title_budget()
    }
    
    private let budgetValueLabel = UILabel().apply {
        $0.textColor = .lightGrey800
        $0.font = .p3
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
    func display(popularity: Double, status: String, revenue: String?, budget: String?) {
        popularityValueLabel.text = "\(Int(popularity)) \(R.string.localizable.title_points())"
        statusValueLabel.text = status
        revenueValueLabel.text = revenue ?? "--"
        budgetValueLabel.text = budget ?? "--"
        
        UIView.animate(withDuration: Constants.defaultAnimationDuration) {
            self.popularityValueLabel.alpha = 1
            self.statusValueLabel.alpha = 1
            self.revenueValueLabel.alpha = 1
            self.budgetValueLabel.alpha = 1
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
        
        [ popularityStackView,
          statusStackView,
          revenueStackView,
          budgetStackView ].forEach { contentStackView.addArrangedSubview($0) }
        
        [ popularityTitleLabel,
          popularityValueLabel ].forEach { popularityStackView.addArrangedSubview($0) }
        
        [ statusTitleLabel,
          statusValueLabel ].forEach { statusStackView.addArrangedSubview($0) }
        
        [ revenueTitleLabel,
          revenueValueLabel ].forEach { revenueStackView.addArrangedSubview($0) }
        
        [ budgetTitleLabel,
          budgetValueLabel ].forEach { budgetStackView.addArrangedSubview($0) }
    }
}
