//
//  GenreCell.swift
//  What'sOn
//
//  Created by Maxime Maheo on 27/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import UIKit
import RxSwift

final class GenreCell: UICollectionViewCell {
    
    // MARK: - Outlets
    public private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .p2
        label.textAlignment = .center
        label.numberOfLines = 2

        return label
    }()
        
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
                
        titleLabel.text = nil
    }
    
    // MARK: - Methods
    func display(title: String) {
        titleLabel.text = title
    }
    
    private func setupViews() {
        backgroundColor = .darkGrey600
        layer.cornerRadius = 4
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(8)
        }
    }
}

extension GenreCell {
    
    static var size: CGSize {
        let numberOfCellsDisplayed: CGFloat = 3
        let margins: CGFloat = 20 + numberOfCellsDisplayed * 16 + 20
        let width: CGFloat = (UIScreen.width - margins) / numberOfCellsDisplayed
        let height: CGFloat = width * 0.7
        
        return CGSize(width: width, height: height)
    }
    
}
