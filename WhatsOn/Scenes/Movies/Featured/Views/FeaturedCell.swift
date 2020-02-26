//
//  FeaturedCell.swift
//  What'sOn
//
//  Created by Maxime Maheo on 26/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import UIKit

open class FeaturedCell: UICollectionViewCell {
    
    // MARK: - Outlets
    public private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .p2
        label.textAlignment = .left
        label.numberOfLines = 2

        return label
    }()
    
    public private(set) lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .p3
        label.textAlignment = .left
        label.numberOfLines = 5
        
        return label
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        overviewLabel.text = nil
    }
    
    // MARK: - Methods
    func display(title: String, overview: String) {
        titleLabel.text = title
        overviewLabel.text = overview
    }
    
    private func setupViews() {
        backgroundColor = .darkGrey600
        layer.cornerRadius = 4
        clipsToBounds = true
        
        addSubview(titleLabel)
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        titleLabel.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview().inset(8)
        }
        
        addSubview(overviewLabel)
//        titleLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
//        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        overviewLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.trailing.equalTo(titleLabel)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
}
