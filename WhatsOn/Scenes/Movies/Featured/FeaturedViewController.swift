//
//  FeaturedViewController.swift
//  What'sOn
//
//  Created by Maxime Maheo on 25/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import UIKit
import RxSwift

final class FeaturedViewController: UIViewController {
    
    // MARK: - Properties
    private var viewModel: FeaturedViewModelContract?
    
    private let disposeBag = DisposeBag()

    private var customView: FeaturedView {
        // swiftlint:disable:next force_cast
        return view as! FeaturedView
    }

    // MARK: - Lifecycle
    override func loadView() {
        view = FeaturedView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        bindViews()
        
        switch viewModel?.sectionContentType {
        case .popularMovies:
            viewModel?.fetchPopularMovies()
        case .discoverMovies:
            viewModel?.fetchDiscoverMovies()
        case .none:
            break
        }
    }

    // MARK: - Methods
    func bind(to viewModel: FeaturedViewModelContract) {
        self.viewModel = viewModel
    }

    // MARK: - Private methods
    private func setupViews() {}

    private func bindViews() {
        bindError()
        bindIsLoading()
        bindCollectionView()
    }
    
    private func bindError() {
        viewModel?.error
            .asDriver(onErrorJustReturn: .generic)
            .drive(onNext: { [weak self] (error) in
                self?.presentAlertView(with: error)
            })
            .disposed(by: disposeBag)
    }
    
    private func bindIsLoading() {
        viewModel?.isLoading
            .bind(to: customView.activityIndicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
    }
    
    private func bindCollectionView() {
        viewModel?.movies
            .asDriver()
            .drive(customView.collectionView.rx.items(cellIdentifier: "\(FeaturedCell.self)", cellType: FeaturedCell.self)) { [weak self] (_, movie, cell) in
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
        
        customView.collectionView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
    
}

extension FeaturedViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let margins = 20 + 16 + 20 + 20
        let width = Int(UIScreen.width) - margins
        
        return CGSize(width: width, height: Int(UIScreen.width(percent: 40)))
    }
    
}
