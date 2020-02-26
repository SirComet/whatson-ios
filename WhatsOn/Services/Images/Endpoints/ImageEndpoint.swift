//
//  ImageEndpoint.swift
//  What'sOn
//
//  Created by Maxime Maheo on 26/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import UIKit

enum ImageEndpointError: LocalizedError {
    case failToConvertDataToImage
    
    var localizedDescription: String {
        switch self {
        case .failToConvertDataToImage:
            return "Fail to convert data to image"
        }
    }
}

final class ImageEndpoint: ApiEndpoint {
    
    typealias RequestDataType = String
    typealias ResponseDataType = (UIImage)
    
    // MARK: - Methods
    func buildRequest(parameters: ImageEndpoint.RequestDataType) throws -> Request {
        guard
            let request = ImageRequest(baseStringUrl: parameters)
        else {
            throw RequestError.failedToRequestWithUrl(parameters)
        }
        
        return request
    }
    
    func parseResponse(data: Data) throws -> ImageEndpoint.ResponseDataType {
        guard let image = UIImage(data: data) else {
            throw ImageEndpointError.failToConvertDataToImage
        }
        
        return image
    }
}
