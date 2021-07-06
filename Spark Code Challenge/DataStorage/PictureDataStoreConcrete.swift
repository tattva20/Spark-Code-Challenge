//
//  PictureDataStoreConcrete.swift
//  Spark Code Challenge
//
//  Created by Octavio Rojas on 04/07/21.
//

import Foundation

class PictureDataStoreConcrete: PictureDataStore {
    
    // MARK: - Properties

    var docsURL: URL? {
        return FileManager
            .default.urls(for: FileManager.SearchPathDirectory.documentDirectory,
                          in: FileManager.SearchPathDomainMask.allDomainsMask).first
    }

    // MARK: - Methods

    func save(pictureData: [PictureData]) {
        let encoder = JSONEncoder()
        let jsonData = try! encoder.encode(pictureData)
        
        guard let docsURL = docsURL else {
            return
        }
        try? jsonData.write(to: docsURL.appendingPathComponent("photos_data_model.json"))
    }

    func load() -> [PictureData] {
        guard let docsURL = docsURL else {
            return []
        }
        
        guard let jsonData = try? Data(contentsOf: docsURL.appendingPathComponent("photos_data_model.json")) else {
            return []
        }
        
        let decoder = JSONDecoder()
        let photosDataModel = try? decoder.decode([PictureData].self, from: jsonData)
        return photosDataModel ?? []
        
    }

}
