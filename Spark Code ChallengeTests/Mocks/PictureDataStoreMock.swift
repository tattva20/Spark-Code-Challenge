//
//  PictureDataStoreMock.swift
//  Spark Code ChallengeTests
//
//  Created by Octavio Rojas on 05/07/21.
//

import UIKit
@testable import Spark_Code_Challenge

class PictureDataStoreMock: PictureDataStore {
    
    var docsURL: URL? {
        return FileManager
            .default.urls(for: FileManager.SearchPathDirectory.documentDirectory,
                          in: FileManager.SearchPathDomainMask.allDomainsMask).first
    }
    
    func save(pictureData: [PictureData]) {
        let encoder = JSONEncoder()
        let jsonData = try! encoder.encode(pictureData)
        
        guard let docsURL = docsURL else {
            return
        }
        try? jsonData.write(to: docsURL.appendingPathComponent("photos_data_model.json"))
        return
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
