//
//  PictureRepositoryMock.swift
//  Spark Code ChallengeTests
//
//  Created by Octavio Rojas on 05/07/21.
//

import UIKit
@testable import Spark_Code_Challenge

class PictureRepositoryMock: PictureRepository {
    
    var error: RemoteAPIError?
    let dataStore: PictureDataStore
    let remoteAPI: RemoteAPI
    let url = URL(string: "https://jsonplaceholder.typicode.com/photos")
    
    public init(dataStore: PictureDataStore, remoteAPI: RemoteAPI) {
        self.dataStore = dataStore
        self.remoteAPI = remoteAPI
    }
    
    func save(pictureData: [PictureData]) {
        dataStore.save(pictureData: pictureData)
    }
    
    func load(then handler: @escaping ([PictureData]) -> Void) {
        let pictureData = dataStore.load()
        handler(pictureData)
    }
    
    func loadImage(url: String, indexPath: IndexPath, then handler: @escaping (UIImage) -> Void) {
        remoteAPI.loadImage(url: url) { (result: Result<UIImage, RemoteAPIError>) in
            switch result {
            case .success(let image):
                handler(image)
            case .failure:
                break
            }
        }
    }
    
    func loadImage(url: String, then handler: @escaping (UIImage) -> Void) {
        remoteAPI.loadImage(url: url) { (result: Result<UIImage, RemoteAPIError>) in
            switch result {
            case .success(let image):
                handler(image)
            case .failure:
                break
            }
        }
    }
}
