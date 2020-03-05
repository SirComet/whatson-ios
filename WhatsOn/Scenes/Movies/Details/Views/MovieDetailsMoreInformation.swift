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
    
    public private(set) lazy var statusStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    public private(set) lazy var statusTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .p2
        label.text = R.string.localizable.title_status()
        
        return label
    }()
    
    public private(set) lazy var statusValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGrey800
        label.font = .p3
        
        return label
    }()
    
    public private(set) lazy var revenueStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    public private(set) lazy var revenueTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .p2
        label.text = R.string.localizable.title_revenue()
        
        return label
    }()
    
    public private(set) lazy var revenueValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGrey800
        label.font = .p3
        
        return label
    }()
    
    public private(set) lazy var budgetStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    public private(set) lazy var budgetTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .p2
        label.text = R.string.localizable.title_budget()
        
        return label
    }()
    
    public private(set) lazy var budgetValueLabel: UILabel = {
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
