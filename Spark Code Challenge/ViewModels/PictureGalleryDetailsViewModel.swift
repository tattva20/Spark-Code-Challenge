//
//  PictureGalleryDetailsViewModel.swift
//  Spark Technical Challenge
//
//  Created by Octavio Rojas on 05/07/21.
//

import UIKit

class PictureGalleryDetailsViewModel {

    // MARK: - Properties

    private let pictureRepository: PictureRepository
    private var pictureData: PictureData

    init(pictureRepository: PictureRepository, pictureData: PictureData) {
        self.pictureRepository = pictureRepository
        self.pictureData = pictureData
    }

    // MARK: - Methods
    
    func loadImage(url: String, then handler: @escaping (UIImage) -> Void) {
        pictureRepository.loadImage(url: url) { image in
            handler(image)
        }
    }

}
