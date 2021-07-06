//
//  PictureRepositoryConcrete.swift
//  Spark Technical Challenge
//
//  Created by Octavio Rojas on 04/07/21.
//

import UIKit

class PictureRepositoryConcrete: PictureRepository {
 
    // MARK: - Properties

    private let cache = NSCache<NSNumber, UIImage>()
    private let dataStore: PictureDataStore
    private let remoteAPI: RemoteAPI
    private let url = URL(string: "https://jsonplaceholder.typicode.com/photos")
    
    init(dataStore: PictureDataStore, remoteAPI: RemoteAPI) {
        self.dataStore = dataStore
        self.remoteAPI = remoteAPI
    }

    // MARK: - Methods
    
    func save(pictureData: [PictureData]) {
        dataStore.save(pictureData: pictureData)
    }

    func load(then handler: @escaping ([PictureData]) -> Void) {
        let pictureData = dataStore.load()
        
        if pictureData.isEmpty {
            remoteAPI.fetchPictureGalleryDataModel(url: url) { (result: Result<[PictureData], RemoteAPIError>) in
                switch result {
                case .success(let model):
                    self.dataStore.save(pictureData: model)
                    handler(model)
                case .failure:
                    break
                }
            }
        } else {
            self.dataStore.save(pictureData: pictureData)
            handler(pictureData)
        }
    }

    func loadImage(url: String, indexPath: IndexPath, then handler: @escaping (UIImage) -> Void) {
        let itemNumber = NSNumber(value: indexPath.row)
        if let cachedImage = self.cache.object(forKey: itemNumber) {
            print("Using a cached image for item: \(itemNumber)")
            handler(cachedImage)
        } else {
            remoteAPI.loadImage(url: url) { (result: Result<UIImage, RemoteAPIError>) in
                switch result {
                case .success(let image):
                    self.cache.setObject(image, forKey: itemNumber)
                    handler(image)
                case .failure:
                    break
                }
            }
            
        }
        return
    }

    func loadImage(url: String, then handler: @escaping(UIImage) -> Void) {
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
