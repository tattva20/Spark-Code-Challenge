//
//  PictureGalleryDependencyContainer.swift
//  Spark Code Challenge
//
//  Created by Octavio Rojas on 04/07/21.
//

import UIKit

class PictureGalleryDependencyContainer {

    // MARK: - Methods

    func makePictureRepository() -> PictureRepository {
        let dataStore = makePictureDataStore()
        let remoteAPI = makeRemoteAPI()
        return PictureRepositoryConcrete(dataStore: dataStore, remoteAPI: remoteAPI)
    }

    func makePictureDataStore() -> PictureDataStore {
        return PictureDataStoreConcrete()
    }

    func makeRemoteAPI() -> RemoteAPI {
        return RemoteAPIConcrete()
    }

    //Picture Gallery
    // Factories needed to create a PictureGalleryViewController.
    
    func makerootNavigationController() -> NiblessNavigationController {
        return NiblessNavigationController()
    }

    func makePictureGalleryCollectionViewController() -> PictureGalleryCollectionViewController {
        let viewModel = makePictureGalleryCollectionViewModel()
        return PictureGalleryCollectionViewController(viewModel: viewModel)
    }

    func makePictureGalleryCollectionViewModel() -> PictureGalleryCollectionViewModel {
        let pictureRepository = makePictureRepository()
        return PictureGalleryCollectionViewModel(pictureRepository: pictureRepository)
    }

}
