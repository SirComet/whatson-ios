//
//  AppError.swift
//  What'sOn
//
//  Created by Maxime Maheo on 26/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import Foundation

enum AppError: LocalizedError {
    case generic, networkUnavailable
    
    var errorDescription: String? {
        switch self {
        case .generic:
            return R.string.localizable.error_description_generic()
        case .networkUnavailable:
            return R.string.localizable.error_description_network_unavailable()
        }
    }
    
    var failureReason: String? {
        switch self {
        case .generic:
            return R.string.localizable.error_failure_reason_generic()
        case .networkUnavailable:
            return R.string.localizable.error_failure_reason_network_unavailable()
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        case .generic:
            return R.string.localizable.error_recovery_suggestion_generic()
        case .networkUnavailable:
            return R.string.localizable.error_recovery_suggestion_network_unavailable()
        }
    }
    
    public var actionTitle: String {
        switch self {
        default:
            return R.string.localizable.error_action()
        }
    }
    
    init(error: Error) {
        if let requestError = error as? RequestError {
            switch requestError {
            case .failedToRequestWithUrl:
                self = .generic
            }
        } else if let apiRequestError = error as? ApiRequesterError {
            switch apiRequestError {
            case .failedToBuildRequest, .failedToDecodeResponse, .invalidStatusCode, .invalidUrl, .requestFailed, .selfIsNil, .unknown:
                self = .generic
            case .noInternetConnection:
                self = .networkUnavailable
            }
        } else {
            self = .generic
        }
    }
}
