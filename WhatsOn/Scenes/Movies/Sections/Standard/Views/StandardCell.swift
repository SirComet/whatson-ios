//
//  StandardCell.swift
//  What'sOn
//
//  Created by Maxime Maheo on 27/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import UIKit
import RxSwift

final class StandardCell: UICollectionViewCell {
    
    // MARK: - Outlets
    private let posterImageView = UIImageView()
    
    // MARK: - Properties
    private var id: Int?
    
    var disposeBag = DisposeBag()
    
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
        
        id = nil
        
        posterImageView.image = R.image.poster_placeholder()
        
        disposeBag = DisposeBag()
    }
    
    // MARK: - Methods
    func display(id: Int) {
        self.id = id
    }
    
    func set(poster: UIImage, id: Int) {
        if self.id == id {
            posterImageView.image = poster
        }
    }
    
    private func setupViews() {
        backgroundColor = .darkGrey600
        layer.cornerRadius = 4
        clipsToBounds = true
        
        addSubview(posterImageView)
        posterImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

extension StandardCell {
    
    static var size: CGSize {
        let numberOfCellsDisplayed: CGFloat = 3
        let margins: CGFloat = 20 + numberOfCellsDisplayed * 16 + 20
        let width: CGFloat = (UIScreen.width - margins) / numberOfCellsDisplayed
        let height: CGFloat = width * 1.5
        
        return CGSize(width: width, height: height)
    }
    
}
