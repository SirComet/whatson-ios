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
                self?.customView.titleLabel.text = movie.title
                self?.customView.overviewLabel.text = movie.overview
                self?.customView.markLabel.text = "\(movie.voteAverage) / 10"
                self?.customView.releaseDateLabel.text = movie.releaseDate?.format()
            })
            .disposed(by: disposeBag)
    }
    
    private func bindMovieDetails() {
        viewModel?.movieDetails
            .asDriver()
            .filter { $0 != nil }
            .map { $0! }
            .drive(onNext: { [weak self] (movieDetails) in
                self?.customView.display(duration: movieDetails.duration.format())
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
                self?.customView.displayBlurImage(with: image.blur(radius: 40))
                self?.customView.displayPosterImage(with: image)
                
                self?.customView.displayMovieInformation()
            })
            .disposed(by: disposeBag)
    }
    
}
