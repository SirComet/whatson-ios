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
        bindTitle()
    }
    
    private func bindTitle() {
        viewModel?.movie
            .asDriver()
            .map { $0.title }
            .drive(onNext: { [weak self] (title) in
                self?.title = title
            })
            .disposed(by: disposeBag)
    }
}
