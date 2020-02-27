//
//  GenreViewController.swift
//  What'sOn
//
//  Created by Maxime Maheo on 27/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import UIKit
import RxSwift

final class GenreViewController: UIViewController {
    
    // MARK: - Properties
    private var viewModel: GenreViewModelContract?
    
    private let disposeBag = DisposeBag()

    private var customView: GenreView {
        // swiftlint:disable:next force_cast
        return view as! GenreView
    }

    // MARK: - Lifecycle
    override func loadView() {
        view = GenreView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        bindViews()
        
        switch viewModel?.sectionContentType {
        case .genre:
            viewModel?.fetchMoviesGenres()
        default:
            break
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    // MARK: - Methods
    func bind(to viewModel: GenreViewModelContract) {
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
        viewModel?.genres
            .asDriver()
            .drive(customView.collectionView.rx.items(cellIdentifier: "\(GenreCell.self)", cellType: GenreCell.self)) { (_, genre, cell) in
                cell.display(title: "\(genre.smiley) \(genre.name)")
            }
            .disposed(by: disposeBag)
        
        customView.collectionView.rx
            .itemSelected
            .bind { [weak self] (indexPath) in
                self?.viewModel?.handle(action: GenreViewModelAction.selectGenre(row: indexPath.row))
            }
            .disposed(by: disposeBag)
        
        customView.collectionView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
    
}

extension GenreViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        GenreCell.size
    }
    
}
