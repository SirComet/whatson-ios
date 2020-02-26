//
//  FeaturedViewModel.swift
//  What'sOn
//
//  Created by Maxime Maheo on 25/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import XCoordinator

protocol FeaturedViewModelContract {}

final class FeaturedViewModel: FeaturedViewModelContract {
    
    // MARK: - Properties
    private let router: UnownedRouter<MoviesRoute>

    // MARK: - Lifecycle
    init(router: UnownedRouter<MoviesRoute>) {
        self.router = router
    }

}
