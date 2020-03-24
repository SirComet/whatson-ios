//
//  CastCell.swift
//  What'sOn
//
//  Created by Maxime Maheo on 05/03/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import UIKit
import RxSwift

final class CastCell: UICollectionViewCell {
    
    // MARK: - Outlets
    private let posterImageView = UIImageView().apply {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 4
        $0.layer.masksToBounds = true
    }
    
    private let nameLabel = UILabel().apply {
        $0.textColor = .white
        $0.font = .p2
    }
    
    private let characterLabel = UILabel().apply {
        $0.textColor = .lightGrey800
        $0.font = .p3
    }
    
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
        nameLabel.text = nil
        characterLabel.text = nil
        
        disposeBag = DisposeBag()
    }
    
    // MARK: - Methods
    func display(name: String, character: String, id: Int) {
        nameLabel.text = name
        characterLabel.text = character
        
        self.id = id
    }
    
    func set(poster: UIImage, id: Int) {
        if self.id == id {
            posterImageView.image = poster
        }
    }
    
    private func setupViews() {
        backgroundColor = .darkGrey900
        clipsToBounds = true
        
        addSubview(posterImageView)
        posterImageView.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(CastCell.size.width * 1.5)
        }
        
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(posterImageView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
        }
        
        addSubview(characterLabel)
        characterLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        characterLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension CastCell {
    
    static var size: CGSize {
        let numberOfCellsDisplayed: CGFloat = 3
        let margins: CGFloat = 20 + numberOfCellsDisplayed * 16 + 20
        let width: CGFloat = (UIScreen.width - margins) / numberOfCellsDisplayed
        let height: CGFloat = width * 1.5 + 8 + 17 + 4 + 17
        
        return CGSize(width: width, height: height)
    }
    
}
