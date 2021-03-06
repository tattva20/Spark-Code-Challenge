//
//  PictureGalleryRemoteAPITests.swift
//  Spark Code ChallengeTests
//
//  Created by Octavio Rojas on 05/07/21.
//

import XCTest
@testable import Spark_Code_Challenge

class PictureGalleryRemoteAPITests: XCTestCase {

    func testFetchPictureGalleryDataModel_withSuccess_shouldReturnPictureData() {
        // Setup
        let url = URL(string: "test")
        var remoteAPIMock = RemoteAPIMock()
        let pictureData = PictureData(albumId: 1,
                                      id: 1,
                                      title: "test title",
                                      url: "test url",
                                      thumbnailUrl: "test thumbniailurl")
        remoteAPIMock.dataModel = pictureData
        let expectation = self.expectation(description: "FetchPictureGallery be executed.")

        // Test
        remoteAPIMock.fetchPictureGalleryDataModel(url: url) { (result: Result<[PictureData], RemoteAPIError>) in
            switch result {
            case .success(let model):
                // Verify
                XCTAssertNotNil(model)
                expectation.fulfill()
                model.forEach { pictureData in
                    XCTAssertEqual(pictureData.albumId, 1, "AlbumId should be 1")
                    XCTAssertEqual(pictureData.id, 1, "Id should be 1")
                    XCTAssertEqual(pictureData.title, "test title", "title should be 'test title'")
                    XCTAssertEqual(pictureData.url, "test url", "url should be 'test url'")
                    XCTAssertEqual(pictureData.thumbnailUrl, "test thumbniailurl", "url should be 'thumbnailurl'")
                }
            case .failure:
                XCTFail("Unexpected behavior")
            }
        }

        waitForExpectations(timeout: 1)

    }

    func testFetchPictureGalleryDataModel_withError_shouldReturnError() {
        // Setup
        let url = URL(string: "test")
        var remoteAPIMock = RemoteAPIMock()
        remoteAPIMock.error = .apiError
        let expectation = self.expectation(description: "FetchPictureGallery be executed.")

        // Test
        remoteAPIMock.fetchPictureGalleryDataModel(url: url) { (result: Result<[PictureData], RemoteAPIError>) in
            switch result {
            case .success:
                XCTFail("Unexpected behavior")
            case .failure(let error):

                // Verify
                expectation.fulfill()
                XCTAssertNotNil(error)
            }
        }

        waitForExpectations(timeout: 1)

    }

    func testLoadImage_withSuccess_shouldReturnImage() {
        // Setup
        let url = "test"
        let remoteAPIMock = RemoteAPIMock()
        let expectation = self.expectation(description: "Load image should be executed.")

        // Test
        remoteAPIMock.loadImage(url: url) { (result: Result<UIImage, RemoteAPIError>) in
            switch result {
            case .success(let image):

                // Verify
                expectation.fulfill()
                XCTAssertNotNil(image)
            case .failure:
                XCTFail("Unexpected behavior")
            }
        }

        waitForExpectations(timeout: 1)

    }

    func testLoadImage_withError_shouldReturnError() {
        // Setup
        let url = "test"
        var remoteAPIMock = RemoteAPIMock()
        remoteAPIMock.error = .apiError
        let expectation = self.expectation(description: "Load image should be executed.")

        // Test
        remoteAPIMock.loadImage(url: url) { (result: Result<UIImage, RemoteAPIError>) in
            switch result {
            case .success:
                XCTFail("Unexpected behavior")
            case .failure(let error):

                // Verify
                expectation.fulfill()
                XCTAssertNotNil(error)
            }
        }

        waitForExpectations(timeout: 1)

    }
}
