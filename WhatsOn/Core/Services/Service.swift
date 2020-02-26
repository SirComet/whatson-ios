//
//  Service.swift
//  What'sOn
//
//  Created by Maxime Maheo on 26/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

enum ServiceError: Error {
    case invalidParameters
}

protocol Service {
    
    // MARK: - Lifecycle
    init(parameters: Any?) throws
    
}
