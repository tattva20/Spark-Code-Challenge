//
//  RemoteAPIMock.swift
//  Spark Code ChallengeTests
//
//  Created by Octavio Rojas on 05/07/21.
//

import UIKit
@testable import Spark_Code_Challenge

public struct RemoteAPIMock: RemoteAPI {
    
    var error: RemoteAPIError?
    var dataModel: PictureData?

    public func fetchPictureGalleryDataModel<T>(url: URL?, then handler: @escaping (Result<T, RemoteAPIError>) -> Void) where T : Decodable {
        if let error = error {
            handler(.failure(error))
            return
        }
   
        handler(.success([dataModel] as! T))
        
    }
    
    public func loadImage(url: String, then handler: @escaping (Result<UIImage, RemoteAPIError>) -> Void) {
        if let _ = error {
            handler(.failure(.apiError))
            return
        }
        
        handler(.success(UIImage()))
    }
    
}
