//
//  StandardViewController.swift
//  What'sOn
//
//  Created by Maxime Maheo on 27/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import UIKit
import RxSwift

final class StandardViewController: UIViewController {
    
    // MARK: - Properties
    private var viewModel: StandardViewModelContract?
    
    private let disposeBag = DisposeBag()

    private var customView: StandardView {
        // swiftlint:disable:next force_cast
        return view as! StandardView
    }

    // MARK: - Lifecycle
    override func loadView() {
        view = StandardView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        bindViews()
        
        switch viewModel?.sectionContentType {
        case .popular:
            viewModel?.fetchPopularMovies()
        case .discover:
            viewModel?.fetchDiscoverMovies()
        case .topRated:
            viewModel?.fetchTopRatedMovies()
        case .nowPlaying:
            viewModel?.fetchNowPlayingMovies()
        case .upcoming:
            viewModel?.fetchUpcomingMovies()
        default:
            break
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    // MARK: - Methods
    func bind(to viewModel: StandardViewModelContract) {
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
            .drive(customView.collectionView.rx.items(cellIdentifier: "\(StandardCell.self)", cellType: StandardCell.self)) { [weak self] (_, movie, cell) in
                guard
                    let self = self,
                    let posterPlaceholder = R.image.poster_placeholder()
                else { return }
                
                cell.display(id: movie.id)
                
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
            .itemSelected
            .bind { [weak self] (indexPath) in
                self?.viewModel?.handle(action: StandardViewModelAction.selectMovie(row: indexPath.row))
            }
            .disposed(by: disposeBag)
        
        customView.collectionView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
    
}

extension StandardViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        StandardCell.size
    }
    
}
