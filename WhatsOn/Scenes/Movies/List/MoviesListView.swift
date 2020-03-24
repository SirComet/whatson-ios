//
//  MoviesListView.swift
//  What'sOn
//
//  Created by Maxime Maheo on 27/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import SnapKit
import UIKit

final class MoviesListView: UIView {
    
    // MARK: - Outlets
    let tableView = UITableView().apply {
        $0.backgroundColor = .darkGrey900
        $0.separatorStyle = .none
        $0.tableFooterView = UIView()
        $0.register(MovieListCell.self, forCellReuseIdentifier: "\(MovieListCell.self)")
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
    private func build() {
        backgroundColor = .darkGrey900

        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
