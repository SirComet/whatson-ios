//
//  MoviesListViewController.swift
//  What'sOn
//
//  Created by Maxime Maheo on 27/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

final class MoviesListViewController: UIViewController {
    
    // MARK: - Properties
    private var viewModel: MoviesListViewModelContract?

    private let disposeBag = DisposeBag()

    private var customView: MoviesListView {
        // swiftlint:disable:next force_cast
        return view as! MoviesListView
    }

    // MARK: - Lifecycle
    override func loadView() {
        view = MoviesListView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        bindViews()
    }

    // MARK: - Methods
    func bind(to viewModel: MoviesListViewModelContract) {
        self.viewModel = viewModel
    }

    // MARK: - Private methods
    private func setupViews() {
        
    }

    private func bindViews() {
        bindTitle()
        bindTableView()
    }

    private func bindTitle() {
        viewModel?.title
            .asDriver()
            .drive(onNext: { [weak self] (title) in
                self?.title = title
            })
            .disposed(by: disposeBag)
    }
    
    private func bindTableView() {
        viewModel?.movies
            .asDriver()
            .drive(customView.tableView.rx.items(cellIdentifier: "\(MovieListCell.self)", cellType: MovieListCell.self)) { [weak self] (_, movie, cell) in
                guard
                    let self = self,
                    let posterPlaceholder = R.image.poster_placeholder()
                else { return }
                
                cell.display(title: movie.title, overview: movie.overview, id: movie.id)
                
                self.viewModel?
                    .fetchPoster(for: movie)
                    .asDriver(onErrorJustReturn: posterPlaceholder)
                    .drive(onNext: { (poster) in
                        cell.set(poster: poster, id: movie.id)
                    })
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)

        customView.tableView.rx
            .itemSelected
            .bind { [weak self] (indexPath) in
                self?.viewModel?.handle(action: MoviesListViewModelAction.selectMovie(row: indexPath.row))
            }
            .disposed(by: disposeBag)
        
        customView.tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
}

extension MoviesListViewController: UITableViewDelegate {
    
    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        MovieListCell.size.height
    }

}
