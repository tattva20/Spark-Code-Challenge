//
//  PictureGalleryCollectionViewMock.swift
//  Spark Code ChallengeTests
//
//  Created by Octavio Rojas on 06/07/21.
//

import Foundation
@testable import Spark_Code_Challenge

class PictureGalleryCollectionViewMock: PictureGalleryCollectionViewProtocol {

    var didReloadCollectionView = false
    var didLoadCollectionView = false
    var didNavigateToDetailsView = false
    var didShowAlert = false
    var didShowActivityIndicator = false
    var didHideActivityIndicator = false

    
    func reloadCollectionViewData() {
        didReloadCollectionView = true
    }
    
    func loadCollectionViewData() {
        didLoadCollectionView = true
    }
    
    func navigateToDetailsViewController(indexPath: IndexPath) {
        didNavigateToDetailsView = true
    }
    
    func showAlert() {
        didShowAlert = true
    }

    func showActivityIndicator() {
        didShowActivityIndicator = true
    }

    func hideActivityIndicator() {
        didHideActivityIndicator = true
    }

}

