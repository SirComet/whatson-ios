//
//  Request.swift
//  What'sOn
//
//  Created by Maxime Maheo on 26/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import Foundation

public enum RequestError: LocalizedError {
    case failedToRequestWithUrl(String)

    var localizedDescription: String {
        switch self {
        case let .failedToRequestWithUrl(url):
            return "Failed to create the request with url : \(url)"
        }
    }
}

public protocol Request {
    var urlRequest: URLRequest { get }
}

public class BaseRequest: Request {
    
    // MARK: - Properties
    private var request: URLRequest

    public var urlRequest: URLRequest {
        request.addHttpHeadersFields(
            parameters: [
                "Content-Type": "application/json; charset=utf-8",
                "Accept-Encoding": "gzip"
            ]
        )

        return request
    }

    // MARK: - Lifecycle
    public init?(baseStringUrl: String) {
        guard let url = URL(string: baseStringUrl) else { return nil }

        request = URLRequest(url: url)
    }
}

extension URLRequest {
    mutating func addQueryParameters(parameters: [String: String]) {
        guard
            !parameters.isEmpty,
            let stringUrl = url?.absoluteString,
            var components = URLComponents(string: stringUrl)
        else { return }

        components.queryItems = components.queryItems ?? []

        for key in parameters.keys.sorted(by: <) {
            components.queryItems?.append(URLQueryItem(name: key, value: parameters[key]))
        }

        url = components.url
    }

    mutating func addHttpHeadersFields(parameters: [String: String]) {
        for key in parameters.keys.sorted(by: <) {
            setValue(parameters[key], forHTTPHeaderField: key)
        }
    }

    mutating func addBodyParameters(_ parameters: Any) {
        guard let data = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }

        httpBody = data
    }
}