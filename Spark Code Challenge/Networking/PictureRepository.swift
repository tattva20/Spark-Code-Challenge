//
//  PictureRepository.swift
//  Spark Technical Challenge
//
//  Created by Octavio Rojas on 04/07/21.
//

import UIKit

protocol PictureRepository {

    /// Saves `[PictureData]` to cache.
    func save(pictureData: [PictureData])
    
    /// Loads `[PictureData]` verifies if there is data in cache to load otherwise calls the API.
    func load(then handler: @escaping ([PictureData]) -> Void)
    
    /// Retrieves thumbnail image for collection view, verifies if there is data in cache to load otherwise calls the API.l
    /// - Parameters:
    ///   - url: endpoint where the data will be retrieved from.
    ///   - indexPath: indexPath of the URL to return.
    ///   - handler: returns API response of type `UIImage`.
    func loadImage(url: String, indexPath: IndexPath, then handler: @escaping (UIImage) -> Void)
     
    /// Retrieves image for details view, verifies if there is data in cache to load otherwise calls the API.l
    /// - Parameters:
    ///   - url: endpoint where the data will be retrieved from.
    ///   - handler: returns API response of type `UIImage`.
    func loadImage(url: String, then handler: @escaping (UIImage) -> Void)

}

