//
//  RemoteAPI.swift
//  Spark Code Challenge
//
//  Created by Octavio Rojas on 04/07/21.
//

import UIKit

public enum RemoteAPIError: Error {

    case invalidEndpoint
    case invalidResponse
    case decodeError
    case apiError

}

public protocol RemoteAPI {
    
    /// Retrieves all picture data models from the API.
    /// - Parameters:
    ///   - url: endpoint where the data will be retrieved from.
    ///   - handler: returns API response of type `[PictureData]`. or `RemoteAPIError`.
    func fetchPictureGalleryDataModel<T>(url: URL?, then handler: @escaping (Result<T, RemoteAPIError>) -> Void) where T : Decodable
    
    /// Retrieves thumbnail image from the API for cell.
    /// - Parameters:
    ///   - url: endpoint where the data will be retrieved from.
    ///   - handler: returns API response of type `UIImage`. or `RemoteAPIError`.
    func loadImage(url: String, then handler: @escaping (Result<UIImage, RemoteAPIError>) -> Void)

}
