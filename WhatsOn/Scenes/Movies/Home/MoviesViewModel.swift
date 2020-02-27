//
//  MoviesViewModel.swift
//  Netflix
//
//  Created by Maxime Maheo on 22/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit
import XCoordinator

protocol MoviesViewModelContract {
    // MARK: - Properties

    var sections: BehaviorRelay<[Section]> { get }

    // MARK: - Methods

    func loadSections()

    func showSection(at row: Int, in container: UIView)
    func hideSection(at row: Int)
}

final class MoviesViewModel: MoviesViewModelContract {
    
    // MARK: - Properties
    private let router: UnownedRouter<MoviesRoute>
    private let servicesContainer: DependenciesContainer
    
    private let disposeBag = DisposeBag()

    var sections: BehaviorRelay<[Section]> = .init(value: [])

    // MARK: - Lifecycle
    init(router: UnownedRouter<MoviesRoute>, servicesContainer: DependenciesContainer) {
        self.router = router
        self.servicesContainer = servicesContainer

        bindSections()
    }

    // MARK: - Methods
    func loadSections() {
        sections.accept(
            [
                Section(title: R.string.localizable.section_discover(), displayType: .featured, content: .discover),
                Section(title: R.string.localizable.section_popular(), displayType: .standard, content: .popular),
                Section(title: R.string.localizable.section_top_rated(), displayType: .featured, content: .topRated),
                Section(title: R.string.localizable.section_now_playing(), displayType: .featured, content: .nowPlaying),
                Section(title: R.string.localizable.section_upcoming(), displayType: .standard, content: .upcoming)
            ]
        )
    }

    func showSection(at row: Int, in container: UIView) {
        router.trigger(.showSection(childId: getChildId(at: row), container: container))
    }

    func hideSection(at row: Int) {
        router.trigger(.hideSection(childId: getChildId(at: row)))
    }

    // MARK: - Private Methods
    private func bindSections() {
        sections
            .subscribe(onNext: { [weak self] sections in
                guard let self = self else { return }

                self.router.trigger(.removeSections)

                sections
                    .enumerated()
                    .forEach { [weak self] args in
                        guard let self = self else { return }

                        let (index, section) = args
                        let childId = self.getChildId(at: index)

                        switch section.displayType {
                        case .featured:
                            self.router.trigger(.createFeaturedSection(childId: childId, content: section.content))
                        case .standard:
                            self.router.trigger(.createStandardSection(childId: childId, content: section.content))
                        }
                    }
            })
            .disposed(by: disposeBag)
    }

    private func getChildId(at row: Int) -> String {
        "\(row)"
    }
}
