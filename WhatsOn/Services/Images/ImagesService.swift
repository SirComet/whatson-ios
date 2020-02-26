//
//  ImagesService.swift
//  What'sOn
//
//  Created by Maxime Maheo on 26/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import UIKit
import RxSwift

enum ImagesServiceError: LocalizedError {
    case hostNotFound
    
    var localizedDescription: String {
        switch self {
        case .hostNotFound:
            return "Host not found"
        }
    }
}

struct ImagesServiceParameters {
    
    // MARK: - Properties
    public let imageHostUrl: String
    
    // MARK: - Lifecycle
    public init(imageHostUrl: String) {
        self.imageHostUrl = imageHostUrl
    }
}

final class ImagesService: ImagesServiceContract {
    
    // MARK: - Properties
    private let imageHostUrl: String

    private let apiRequester = ApiRequester()
    
    // MARK: - Lifecycle
    init(parameters: Any?) throws {
        guard let parameters = parameters as? ImagesServiceParameters else {
            throw ServiceError.invalidParameters
        }
        imageHostUrl = parameters.imageHostUrl
    }
    
    // MARK: - Methods
    func fetchImage<T>(for object: T) -> Single<UIImage> where T: FetchableImage {
        guard let host = object.imageStringUrl(from: "https://image.tmdb.org/t/p/") else {
            return Single.error(ImagesServiceError.hostNotFound)
        }
        
        return apiRequester.fetch(ImageEndpoint(), with: host)
    }
    
}
