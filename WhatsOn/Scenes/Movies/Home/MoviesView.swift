//
//  MoviesView.swift
//  What'sOn
//
//  Created by Maxime Maheo on 25/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import SnapKit
import UIKit

final class MoviesView: UIView {

    // MARK: - Outlets
    public private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .darkGrey900
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.register(SectionCell.self, forCellReuseIdentifier: "\(SectionCell.self)")

        return tableView
    }()

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)

        build()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    private func build() {
        backgroundColor = .darkGrey900

        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

}
