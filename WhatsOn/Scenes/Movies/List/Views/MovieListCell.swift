//
//  MovieListCell.swift
//  What'sOn
//
//  Created by Maxime Maheo on 27/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import UIKit
import RxSwift

final class MovieListCell: UITableViewCell {
    
    // MARK: - Outlets
    private let posterImageView = UIImageView().apply {
        $0.layer.cornerRadius = 4
        $0.layer.masksToBounds = true
    }
    
    private let titleLabel = UILabel().apply {
        $0.textColor = .white
        $0.font = .p2
        $0.textAlignment = .left
        $0.numberOfLines = 2
    }
    
    private let overviewLabel = UILabel().apply {
        $0.textColor = .lightGrey800
        $0.font = .p3
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }
    
    // MARK: - Properties
    private var id: Int?
    
    var disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        id = nil
        
        posterImageView.image = R.image.poster_placeholder()
        titleLabel.text = nil
        overviewLabel.text = nil
        
        disposeBag = DisposeBag()
    }

    // MARK: - Methods
    func display(title: String, overview: String, id: Int) {
        titleLabel.text = title
        overviewLabel.text = overview
        
        self.id = id
    }

    func set(poster: UIImage, id: Int) {
        if self.id == id {
            posterImageView.image = poster
        }
    }
    
    // MARK: - Private methods
    private func setupViews() {
        backgroundColor = .darkGrey900
        selectionStyle = .none
        
        addSubview(posterImageView)
        posterImageView.snp.makeConstraints { (make) in
            make.leading.top.bottom.equalToSuperview().inset(8)
            make.width.equalTo(posterImageView.snp.height).multipliedBy(0.66)
        }
        
        addSubview(titleLabel)
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        titleLabel.snp.makeConstraints { (make) in
            make.trailing.top.equalToSuperview().inset(8)
            make.leading.equalTo(posterImageView.snp.trailing).offset(8)
        }
        
        addSubview(overviewLabel)
        overviewLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.trailing.equalTo(titleLabel)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
}

extension MovieListCell {
    
    static var size: CGSize {
        CGSize(width: UIScreen.width, height: UIScreen.height(percent: 20))
    }
    
}
