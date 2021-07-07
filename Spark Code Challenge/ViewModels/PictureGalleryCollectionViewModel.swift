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
    private var dataSource = [PictureData]()
    
    var pictureData: [PictureData] {
        return dataSource
    }

    init(pictureRepository: PictureRepository) {
        self.pictureRepository = pictureRepository
    }
    
    // MARK: - Methods
    
    func configure(_ cell: PictureGalleryCollectionViewCell, at indexPath: IndexPath) {
        let url = dataSource[indexPath.item].thumbnailUrl
        loadImage(url: url, indexPath: indexPath) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    cell.imageView.image = image
                }
            case .failure:
                break
            }
        }
    }

    func setView(view: PictureGalleryCollectionViewProtocol?) {
        self.view = view
    }
    
    func loadData() {
        view?.showActivityIndicator()
        pictureRepository.load { [weak self] result in
            switch result {
            case.success(let pictureData):
                self?.dataSource = pictureData
                self?.view?.hideActivityIndicator()
                self?.view?.loadCollectionViewData()
            case .failure:
                self?.view?.hideActivityIndicator()
                self?.showAlert()
            }
     
        }
    }

    func reloadData() {
        pictureRepository.load { [weak self] result in
            switch result {
            case .success(let pictureData):
                self?.dataSource = pictureData
                self?.view?.reloadCollectionViewData()
            case .failure:
                self?.showAlert()
            }
        }
    }
    
    func retryDataLoad() {
        pictureRepository.load { [weak self] result in
            switch result {
            case .success(let pictureData):
                self?.dataSource = pictureData
            case .failure:
                self?.view?.showAlert()
            }
        }
    }

    func loadImage(url: String, indexPath: IndexPath, then handler: @escaping (Result<UIImage, RemoteAPIError>) -> Void) {
        pictureRepository.loadImage(url: url, indexPath: indexPath) { result in
            switch result {
            case .success(let result):
                handler(.success(result))
            case .failure:
                self.showAlert()
            }
        }
    }
    
    func pictureData(for indexPath: IndexPath) -> PictureData {
        return dataSource[indexPath.item]
    }
    
    func detailsViewModel(for indexPath: IndexPath) -> PictureGalleryDetailsViewModel {
        let detailsPicture = pictureData(for: indexPath)
        return PictureGalleryDetailsViewModel(pictureRepository: pictureRepository, pictureData: detailsPicture)
    }

    func navigateToDetailsViewController(indexPath: IndexPath) {
        view?.navigateToDetailsViewController(indexPath: indexPath)
    }
    
    func showAlert() {
        view?.showAlert()
    }

}
