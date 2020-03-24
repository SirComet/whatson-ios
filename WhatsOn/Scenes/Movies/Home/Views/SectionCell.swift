//
//  SectionCell.swift
//  What'sOn
//
//  Created by Maxime Maheo on 25/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import UIKit

final class SectionCell: UITableViewCell {
    
    // MARK: - Outlets
    private let titleLabel = UILabel().apply {
        $0.textColor = .white
        $0.font = .h2
        $0.textAlignment = .left
        $0.numberOfLines = 2
    }

    let containerView = UIView()

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

        titleLabel.text = nil
    }

    // MARK: - Methods
    func display(title: String) {
        titleLabel.text = title
    }

    private func setupViews() {
        backgroundColor = .darkGrey900
        selectionStyle = .none

        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
