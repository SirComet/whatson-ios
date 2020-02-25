//
//  MoviesViewController.swift
//  Netflix
//
//  Created by Maxime Maheo on 22/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import UIKit

final class MoviesViewController: UIViewController {

    // MARK: - Properties
    private var viewModel: MoviesViewModelContract?

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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        //        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    // MARK: - Methods
    func bind(to viewModel: MoviesViewModelContract) {
        self.viewModel = viewModel
    }

    private func setupViews() {
        title = R.string.localizable.tab_bar_movies()
    }

    private func bindViews() {

    }
}
