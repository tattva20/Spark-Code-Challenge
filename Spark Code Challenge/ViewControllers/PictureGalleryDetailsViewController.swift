//
//  PictureGalleryDetailsViewController.swift
//  Spark Technical Challenge
//
//  Created by Octavio Rojas on 04/07/21.
//

import UIKit

class PictureGalleryDetailsViewController: NiblessViewController {

    // MARK: - Properties

    private let pictureData: PictureData
    private let viewModel: PictureGalleryDetailsViewModel
    private let screenWidth = UIScreen.main.bounds.width
    
    private lazy var imageView: UIImageView = {
        let frame = CGRect(x: 0, y: 0,
                           width: screenWidth / 1.2,
                           height: screenWidth / 1.2)
        let imageView = UIImageView(frame: frame)
        return imageView
        
    }()
  
    init(pictureData: PictureData,
         viewModel: PictureGalleryDetailsViewModel) {
        self.pictureData = pictureData
        self.viewModel = viewModel
        super.init()
        navigationItem.title = "Picture Details"
        view.backgroundColor = UIColor.white
    }

    // MARK: - Methods

    override func viewDidLoad() {
        imageView.center = self.view.center
        view.addSubview(imageView)
        viewModel.loadImage(url: pictureData.url) { image in
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }

}
