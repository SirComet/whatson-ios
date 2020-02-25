//
//  MoviesViewController.swift
//  Netflix
//
//  Created by Maxime Maheo on 22/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

final class MoviesViewController: UIViewController {

    // MARK: - Properties
    private var viewModel: MoviesViewModelContract?

    private let disposeBag = DisposeBag()

    private var customView: MoviesView {
        // swiftlint:disable:next force_cast
        return view as! MoviesView
    }

    // MARK: - Lifecycle
    override func loadView() {
        self.view = MoviesView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        bindViews()

        viewModel?.loadSections()
    }

    // MARK: - Methods
    func bind(to viewModel: MoviesViewModelContract) {
        self.viewModel = viewModel
    }

    private func setupViews() {
        title = R.string.localizable.tab_bar_movies()
    }

    private func bindViews() {
        bindTableView()
    }

    private func bindTableView() {
        viewModel?.sections
            .asDriver()
            .drive(
                customView.tableView.rx.items(
                    cellIdentifier: "\(SectionCell.self)",
                    cellType: SectionCell.self
                )
            )
        { (_, section, cell) in
            cell.display(title: section.title)
        }
            .disposed(by: disposeBag)

        customView.tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
}

extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}
