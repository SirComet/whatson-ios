//
//  MoviesViewModel.swift
//  Netflix
//
//  Created by Maxime Maheo on 22/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import RxCocoa
import RxSwift
import XCoordinator

protocol MoviesViewModelContract {

    // MARK: - Properties
    var sections: BehaviorRelay<[Section]> { get }

    // MARK: - Methods
    func loadSections()
}

final class MoviesViewModel: MoviesViewModelContract {

    // MARK: - Properties
    private let router: UnownedRouter<MoviesRoute>

    var sections: BehaviorRelay<[Section]> = .init(value: [])

    // MARK: - Lifecycle
    init(router: UnownedRouter<MoviesRoute>) {
        self.router = router
    }

    // MARK: - Methods
    func loadSections() {
        sections.accept(
            [
                Section(title: R.string.localizable.section_popular()),
            ]
        )
    }

}
