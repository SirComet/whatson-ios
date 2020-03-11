//
//  SearchViewModel.swift
//  What'sOn
//
//  Created by Maxime Maheo on 11/03/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import XCoordinator
import Combine

enum SearchViewModelAction: ViewModelAction {
    
}

protocol SearchViewModelContract: ViewModel, ObservableObject {
    
}

final class SearchViewModel: SearchViewModelContract {

    // MARK: - Properties
    private let router: UnownedRouter<SearchRoute>
    private let servicesContainer: DependenciesContainer

    // MARK: - Lifecycle
    init(router: UnownedRouter<SearchRoute>, servicesContainer: DependenciesContainer) {
        self.router = router
        self.servicesContainer = servicesContainer
    }

    // MARK: - Methods
    func handle(action: ViewModelAction) {
        
    }
}

final class SearchViewModelPreview: SearchViewModelContract {
    
    // MARK: - Lifecycle
    
    // MARK: - Methods
    func handle(action: ViewModelAction) {}
    
}
