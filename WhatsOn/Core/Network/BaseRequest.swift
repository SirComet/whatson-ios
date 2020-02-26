//
//  BaseRequest.swift
//  What'sOn
//
//  Created by Maxime Maheo on 26/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import Foundation

final class BaseRequest: Request {
    
    // MARK: - Properties
    private var request: URLRequest
    
    var urlRequest: URLRequest {
        request.addHttpHeadersFields(parameters: [
            "Content-Type": "application/json; charset=utf-8",
            "Accept-Encoding": "gzip"
        ])
        
        request.addQueryParameters(parameters: [
            "api_key": ApiKey.value,
            "language": Locale.preferredLanguages.first ?? "en-US"
        ])
        
        return request
    }
    
    // MARK: - Lifecycle
    init?(baseStringUrl: String) {
        guard let url = URL(string: baseStringUrl) else { return nil }
        
        self.request = URLRequest(url: url)
    }
    
    // MARK: - Methods
    func addQueryParameters(parameters: [String: String]) {
        request.addQueryParameters(parameters: parameters)
    }
    
}
