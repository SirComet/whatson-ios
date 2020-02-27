//
//  ViewModel.swift
//  What'sOn
//
//  Created by Maxime Maheo on 27/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

protocol ViewModelAction {}

protocol ViewModel {
    func handle(action: ViewModelAction)
}
