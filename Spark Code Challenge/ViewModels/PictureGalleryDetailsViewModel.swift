//
//  PictureGalleryDetailsViewModel.swift
//  Spark Code Challenge
//
//  Created by Octavio Rojas on 05/07/21.
//

import UIKit

class PictureGalleryDetailsViewModel {

    // MARK: - Properties

    private let pictureRepository: PictureRepository
    private weak var view: PictureGalleryDetailsViewProtocol?
    private var pictureData: PictureData

    init(pictureRepository: PictureRepository, pictureData: PictureData) {
        self.pictureRepository = pictureRepository
        self.pictureData = pictureData
    }

    func setView(view: PictureGalleryDetailsViewProtocol) {
        self.view = view
    }

    // MARK: - Methods

    func loadImage(url: String, then handler: @escaping (Result<UIImage, RemoteAPIError>) -> Void) {
        pictureRepository.loadImage(url: url) { result in
            switch result {
            case .success(let result):
                handler(.success(result))
            case .failure:
                handler(.failure(.apiError))
            }
        }
    }

    func showAlert() {
        view?.showAlert()
    }

}
