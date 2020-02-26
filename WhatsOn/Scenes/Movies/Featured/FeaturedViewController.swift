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
    }
    
    private func bindError() {
        viewModel?.error
            .asDriver(onErrorJustReturn: .generic)
            .drive(onNext: { [weak self] (error) in
                self?.presentAlertView(with: error)
            })
            .disposed(by: disposeBag)
    }
    
}
