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
    public private(set) lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkGrey600
        button.layer.cornerRadius = 12
        button.tintColor = .white
        button.setImage(R.image.icons_times()?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        
        return button
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
    private func build() {
        backgroundColor = .darkGrey900
        
        addSubview(dismissButton)
        dismissButton.snp.makeConstraints { (make) in
            make.trailing.top.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.width.equalTo(24)
        }
    }
}
