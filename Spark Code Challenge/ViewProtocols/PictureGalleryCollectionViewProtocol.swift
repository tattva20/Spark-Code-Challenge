//
//  PictureGalleryCollectionViewProtocol.swift
//  Spark Code Challenge
//
//  Created by Octavio Rojas on 04/07/21.
//

import UIKit

protocol PictureGalleryCollectionViewProtocol: AnyObject {

    func reloadCollectionViewData()
    func loadCollectionViewData()
    func navigateToDetailsViewController(indexPath: IndexPath)
    func showAlert()
    func showActivityIndicator()
    func hideActivityIndicator()

}
