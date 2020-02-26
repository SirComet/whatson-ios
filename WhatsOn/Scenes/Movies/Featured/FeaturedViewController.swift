//
//  FeaturedViewController.swift
//  What'sOn
//
//  Created by Maxime Maheo on 25/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import UIKit

final class FeaturedViewController: UIViewController {

    // MARK: - Properties
    private var viewModel: FeaturedViewModelContract?

    private var customView: FeaturedView {
        // swiftlint:disable:next force_cast
        return view as! FeaturedView
    }

    // MARK: - Lifecycle
    override func loadView() {
        self.view = FeaturedView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        bindViews()
    }

    // MARK: - Methods
    func bind(to viewModel: FeaturedViewModelContract) {
        self.viewModel = viewModel
    }

    private func setupViews() {

    }

    private func bindViews() {

    }

}
