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
    
    func reloadCollectionViewData() {
        didReloadCollectionView = true
    }
    
    func loadCollectionViewData() {
        didLoadCollectionView = true
    }
    
    
}

