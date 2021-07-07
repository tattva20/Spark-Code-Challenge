//
//  PictureDetailsVIewModelTests.swift
//  Spark Code ChallengeTests
//
//  Created by Octavio Rojas on 06/07/21.
//

import XCTest
@testable import Spark_Code_Challenge

class PictureDetailsVIewModelTests: XCTestCase {

    private var viewModel: PictureGalleryDetailsViewModel!
    private var remoteAPI: RemoteAPIMock!
    private var dataStore: PictureDataStore!
    private var pictureRepository: PictureRepositoryMock!

    override func setUp() {
        let pictureData = PictureData(albumId: 1,
                                      id: 1,
                                      title: "test title",
                                      url: "test url",
                                      thumbnailUrl: "test thumbniailurl")
        remoteAPI = RemoteAPIMock()
        dataStore = PictureDataStoreMock()
        pictureRepository = PictureRepositoryMock(dataStore: dataStore, remoteAPI: remoteAPI)
        viewModel = PictureGalleryDetailsViewModel(pictureRepository: pictureRepository, pictureData: pictureData)
    }

    func testViewModelLoadImage_shouldReturnValidImage() {
        // Setup
        let url = "test"
        let expectation = self.expectation(description: "Load image should be executed.")

        // Test
        viewModel.loadImage(url: url) { image in

            // Verify
            expectation.fulfill()
            XCTAssertNotNil(image, "Returned image shouldn't be nil")
        }

        waitForExpectations(timeout: 1)

    }

}
