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

    func load(then handler: @escaping (Result<[PictureData], RemoteAPIError>) -> Void) {
        let pictureData = dataStore.load()
        if let error = error {
            handler(.failure(error))
        }
        handler(.success(pictureData))
    }
    
    func loadImage(url: String, indexPath: IndexPath, then handler: @escaping (Result<UIImage, RemoteAPIError>) -> Void) {
        remoteAPI.loadImage(url: url) { (result: Result<UIImage, RemoteAPIError>) in
            switch result {
            case .success(let result):
                handler(.success(result))
            case .failure:
                handler(.failure(.apiError))
            }
        }
    }
    
    func loadImage(url: String, then handler: @escaping (Result<UIImage, RemoteAPIError>) -> Void) {
        remoteAPI.loadImage(url: url) { (result: Result<UIImage, RemoteAPIError>) in
            switch result {
            case .success(let result):
                handler(.success(result))
            case .failure:
                handler(.failure(.apiError))
            }
        }
    }
}
