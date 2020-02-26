//
//  ImagesServiceContract.swift
//  What'sOn
//
//  Created by Maxime Maheo on 26/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import UIKit
import RxSwift

protocol FetchableImage {
    
    func imageStringUrl(from host: String) -> String?

}

protocol ImagesServiceContract: Service {
    
    func fetchImage<T>(for object: T) -> Single<UIImage> where T: FetchableImage
    
}
