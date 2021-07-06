//
//  PictureGalleryViewModelTests.swift
//  Spark Code ChallengeTests
//
//  Created by Octavio Rojas on 06/07/21.
//

import XCTest
import UIKit
@testable import Spark_Code_Challenge

class PictureGalleryViewModelTests: XCTestCase {

    private var view: PictureGalleryCollectionViewMock!
    private var remoteAPI: RemoteAPIMock!
    private var dataStore: PictureDataStore!
    private var viewModel: PictureGalleryCollectionViewModel!
    private var pictureRepository: PictureRepositoryMock!

    override func setUp() {
        view = PictureGalleryCollectionViewMock()
        remoteAPI = RemoteAPIMock()
        dataStore = PictureDataStoreMock()
        pictureRepository = PictureRepositoryMock(dataStore: dataStore, remoteAPI: remoteAPI)
        viewModel = PictureGalleryCollectionViewModel(pictureRepository: pictureRepository)
    }

    func testViewModelLoadData_shouldLoadDataIntoCollectionView() {
        // Setup
        viewModel.setView(view: view)

        // Test
        viewModel.loadData()

        // Verify
        XCTAssertTrue(view.didLoadCollectionView)

    }

    func testViewModelReloadData_shouldReloadDataIntoCollectionView() {
        // Setup
        viewModel.setView(view: view)

        // Test
        viewModel.reloadData()

        // Verify
        XCTAssertTrue(view.didReloadCollectionView)

    }
        
    func testViewModelNavigateToDetailsViewController_shouldNavigateToDetailsViewController() {
        // Setup
        let indexPath = IndexPath(item: 0, section: 0)
        viewModel.setView(view: view)
                
        // Test
        viewModel.navigateToDetailsViewController(indexPath: indexPath)
        
        // Verify
        XCTAssertTrue(view.didNavigateToDetailsView)
    }

    func testViewModelLoadImage_shouldReturnValidImage() {
        // Setup
        let url = "test"
        let indexPath = IndexPath(item: 0, section: 0)
        let expectation = self.expectation(description: "Load image should be executed.")

        // Test
        viewModel.loadImage(url: url, indexPath: indexPath) { image in

            // Verify
            expectation.fulfill()
            XCTAssertNotNil(image)
        }

        waitForExpectations(timeout: 1)

    }
}
