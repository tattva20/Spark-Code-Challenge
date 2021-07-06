//
//  PictureDataStore.swift
//  Spark Technical Challenge
//
//  Created by Octavio Rojas on 04/07/21.
//

import Foundation

protocol PictureDataStore {

    /// Saves picture data to cache
    /// - Parameters:
    ///   - pictureData: Data to be saved.
    func save(pictureData: [PictureData])

    /// Retrieves picture data from cache
    func load() -> [PictureData]

}

