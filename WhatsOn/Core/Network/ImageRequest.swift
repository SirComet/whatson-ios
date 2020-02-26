//
//  ImageRequest.swift
//  What'sOn
//
//  Created by Maxime Maheo on 26/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import Foundation

final class ImageRequest: Request {
    
    // MARK: - Properties
    private var request: URLRequest
    
    public var urlRequest: URLRequest {
        request.addHttpHeadersFields(parameters: [
            "Content-Type": "application/json; charset=utf-8",
            "Accept-Encoding": "gzip"
        ])
        
        return request
    }
    
    // MARK: - Lifecycle
    public init?(baseStringUrl: String) {
        guard let url = URL(string: baseStringUrl) else { return nil }
        
        self.request = URLRequest(url: url)
    }
    
}
