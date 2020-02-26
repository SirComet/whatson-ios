//
//  UIViewController+PresentAlertView.swift
//  What'sOn
//
//  Created by Maxime Maheo on 26/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//
import UIKit

extension UIViewController {
    func presentAlertView<Error>(with error: Error, completion: ((UIAlertAction) -> Void)? = nil) where Error: LocalizedError {
        let message = [
            error.failureReason,
            error.recoverySuggestion
        ]
            .compactMap { $0 }
            .joined(separator: "\n")
        
        let alert = UIAlertController(title: error.errorDescription, message: message, preferredStyle: .alert)
        let actionTitle = (error as? AppError)?.actionTitle ?? R.string.localizable.error_action()
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: completion))
        
        present(alert, animated: true, completion: nil)
    }
}
