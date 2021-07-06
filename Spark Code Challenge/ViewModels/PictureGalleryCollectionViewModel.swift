//
//  PictureGalleryCollectionViewModel.swift
//  Spark Code Challenge
//
//  Created by Octavio Rojas on 04/07/21.
//

import UIKit

class PictureGalleryCollectionViewModel {

    // MARK: - Properties

    private let pictureRepository: PictureRepository
    private weak var view: PictureGalleryCollectionViewProtocol?
    var pictureData = [PictureData]()

    init(pictureRepository: PictureRepository) {
        self.pictureRepository = pictureRepository
    }

    // MARK: - Methods
    
    func configure(_ cell: PictureGalleryCollectionViewCell, at indexPath: IndexPath) {
        let url = pictureData[indexPath.item].thumbnailUrl
        loadImage(url: url, indexPath: indexPath) { image in
            DispatchQueue.main.async {
                cell.imageView.image = image
            }
        }
    }

    func setView(view: PictureGalleryCollectionViewProtocol?) {
        self.view = view
    }

    func loadData() {
        pictureRepository.load { pictureData in
            self.pictureData = pictureData
            self.view?.loadCollectionViewData()
        }
    }

    func reloadData() {
        pictureRepository.load { pictureData in
            self.pictureData = pictureData
            self.view?.reloadCollectionViewData()
        }
    }

    func loadImage(url: String, indexPath: IndexPath, then handler: @escaping (UIImage) -> Void)  {
        pictureRepository.loadImage(url: url, indexPath: indexPath) { image in
            handler(image)
        }
    }

    func NavigateToDetailsViewController(indexPath: IndexPath, navigationController: UINavigationController) {
        let detailsPicture = pictureData[indexPath.item]
        let detailsViewModel = PictureGalleryDetailsViewModel(pictureRepository: pictureRepository, pictureData: detailsPicture)
        let detailsViewController = PictureGalleryDetailsViewController(pictureData: detailsPicture, viewModel: detailsViewModel)
        detailsViewController.modalPresentationStyle = .fullScreen
        navigationController.pushViewController(detailsViewController, animated: true)
    }

}
