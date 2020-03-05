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
        viewModel?.fetchMoviesRecommendations()
        viewModel?.fetchMovieVideos()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        customView.moviesDetailsTrailer.trailerWebView.stopLoading()
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
        bindRecommendationsCollectionView()
        bindVideos()
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
                self?.customView.movieDetailsMoreInformation.display(popularity: movieDetails.popularity,
                                                                     status: movieDetails.status,
                                                                     revenue: movieDetails.revenue.format(style: .currency),
                                                                     budget: movieDetails.budget.format(style: .currency))
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
        guard
            let placeholderImage = R.image.poster_placeholder(),
            let movie = viewModel?.movie.value
        else { return }

        viewModel?
            .fetchPoster(for: movie)
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
            .drive(customView.movieDetailsGenre.collectionView.rx.items(cellIdentifier: "\(GenreCell.self)", cellType: GenreCell.self)) { (_, genre, cell) in
                cell.display(title: "\(genre.smiley) \(genre.name)")
            }
            .disposed(by: disposeBag)
        
        customView.movieDetailsGenre.collectionView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    private func bindRecommendationsCollectionView() {
        viewModel?.recommendedMovies
            .asDriver()
            .filter { !$0.isEmpty }
            // swiftlint:disable:next line_length
            .drive(customView.movieDetailsRecommendations.collectionView.rx.items(cellIdentifier: "\(StandardCell.self)", cellType: StandardCell.self)) { [weak self] (_, recommendedMovie, cell) in
                guard
                    let self = self,
                    let posterPlaceholder = R.image.poster_placeholder()
                else { return }
                
                cell.display(id: recommendedMovie.id)
                
                self.viewModel?
                    .fetchPoster(for: recommendedMovie)
                    .asDriver(onErrorJustReturn: posterPlaceholder)
                    .drive(onNext: { (poster) in
                        cell.set(poster: poster, id: recommendedMovie.id)
                    })
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
        
        customView.movieDetailsRecommendations.collectionView.rx
            .itemSelected
            .bind { [weak self] (indexPath) in
                self?.viewModel?.handle(action: MovieDetailsViewModelAction.selectRecommendedMovie(row: indexPath.row))
            }
            .disposed(by: disposeBag)
        
        customView.movieDetailsRecommendations.collectionView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    private func bindVideos() {
        viewModel?.videos
            .asDriver()
            .filter { !$0.isEmpty }
            .drive(onNext: { [weak self] (videos) in
                guard
                    let trailerKey = videos.first(where: { $0.isTrailerFromYouTube })?.key,
                    let trailerUrl = URL(string: "https://www.youtube.com/embed/\(trailerKey)")
                else { return }
                
                self?.customView.moviesDetailsTrailer.load(trailerUrl: trailerUrl)
            })
            .disposed(by: disposeBag)
    }
    
}

extension MovieDetailsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionView == customView.movieDetailsGenre.collectionView ? GenreCell.size : StandardCell.size
    }
    
}
