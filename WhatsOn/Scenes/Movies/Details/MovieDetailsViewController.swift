//
//  MovieDetailsViewController.swift
//  What'sOn
//
//  Created by Maxime Maheo on 27/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

final class MovieDetailsViewController: UIViewController {
    
    // MARK: - Properties
    private var viewModel: MovieDetailsViewModelContract?

    private let disposeBag = DisposeBag()

    private var customView: MovieDetailsView {
        // swiftlint:disable:next force_cast
        return view as! MovieDetailsView
    }

    // MARK: - Lifecycle
    override func loadView() {
        view = MovieDetailsView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        bindViews()
        
        viewModel?.fetchMovieDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    // MARK: - Methods
    func bind(to viewModel: MovieDetailsViewModelContract) {
        self.viewModel = viewModel
    }

    // MARK: - Private methods
    private func setupViews() {
        
    }

    private func bindViews() {
        bindError()
        bindMovie()
        bindMovieDetails()
        bindDismissButton()
        bindPosterImage()
        bindGenresCollectionView()
    }
    
    private func bindError() {
        viewModel?.error
            .asDriver(onErrorJustReturn: .generic)
            .drive(onNext: { [weak self] (error) in
                self?.presentAlertView(with: error)
            })
            .disposed(by: disposeBag)
    }
    
    private func bindMovie() {
        viewModel?.movie
            .asDriver()
            .drive(onNext: { [weak self] (movie) in
                self?.customView.movieDetailsTopInformation.display(title: movie.title,
                                                                    mark: "\(movie.voteAverage) / 10",
                                                                    releaseDate: movie.releaseDate?.format() ?? "",
                                                                    overview: movie.overview)
            })
            .disposed(by: disposeBag)
    }

    private func bindMovieDetails() {
        viewModel?.movieDetails
            .asDriver()
            .filter { $0 != nil }
            .map { $0! }
            .drive(onNext: { [weak self] (movieDetails) in
                self?.customView.movieDetailsTopInformation.display(duration: movieDetails.duration.format())
            })
            .disposed(by: disposeBag)
    }

    private func bindDismissButton() {
        customView.dismissButton.rx
            .tap
            .bind { [weak self] () in
                self?.viewModel?.handle(action: MovieDetailsViewModelAction.dismiss)
            }
            .disposed(by: disposeBag)
    }

    private func bindPosterImage() {
        guard let placeholderImage = R.image.poster_placeholder() else { return }

        viewModel?.fetchPosterImage()
            .asDriver(onErrorJustReturn: placeholderImage)
            .drive(onNext: { [weak self] (image) in
                self?.customView.movieDetailsTopInformation.display(posterImage: image)
            })
            .disposed(by: disposeBag)
    }

    private func bindGenresCollectionView() {
        viewModel?.genres
            .asDriver()
            .filter { !$0.isEmpty }
            .drive(onNext: { [weak self] (_) in
                self?.customView.genresCollectionView.reloadData()
            })
            .disposed(by: disposeBag)

        customView.genresCollectionView.rx
            .setDataSource(self)
            .disposed(by: disposeBag)

        customView.genresCollectionView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
    
}

extension MovieDetailsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.genres.value.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(GenreCell.self)", for: indexPath) as? GenreCell,
            let genre = viewModel?.genres.value[indexPath.row]
        else { return UICollectionViewCell() }
        
        cell.display(title: "\(genre.smiley) \(genre.name)")
        
        return cell
    }
    
}

extension MovieDetailsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        GenreCell.size
    }
    
}
