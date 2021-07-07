//
//  PictureGalleryDetailsViewController.swift
//  Spark Code Challenge
//
//  Created by Octavio Rojas on 04/07/21.
//

import UIKit

class PictureGalleryDetailsViewController: NiblessViewController {

    // MARK: - Properties

    private let pictureData: PictureData
    private let viewModel: PictureGalleryDetailsViewModel
    private let screenWidth = UIScreen.main.bounds.width
    private let screenHeight = UIScreen.main.bounds.width
    private let orientation = UIApplication.shared.statusBarOrientation
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
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
        viewModel.setView(view: self)
        imageView.center = self.view.center
        view.addSubview(imageView)
        viewModel.loadImage(url: pictureData.url) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            case .failure:
                self?.viewModel.showAlert()
            }
        }
    }

    override func viewDidLayoutSubviews() {
        if orientation == .landscapeLeft || orientation == .landscapeRight {
            setupConstraintsForImageViewLandscape()
        } else {
            setupConstraintsForImageViewPortrait()
        }
    }

    func setupConstraintsForImageViewPortrait() {
        let constraints = [
            imageView.heightAnchor.constraint(equalToConstant: screenHeight / 1.5),
            imageView.widthAnchor.constraint(equalToConstant: screenHeight / 1.5),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]

        constraints.forEach { $0.isActive = true }
    }

    func setupConstraintsForImageViewLandscape() {
        let constraints = [
            imageView.heightAnchor.constraint(equalToConstant: screenHeight / 3),
            imageView.widthAnchor.constraint(equalToConstant: screenHeight / 3),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]

        constraints.forEach { $0.isActive = true }
    }

}

extension PictureGalleryDetailsViewController : PictureGalleryDetailsViewProtocol {

    func showAlert() {
        let alert = UIAlertController(title: "Error", message: "There was an error while retriving the image, press OK to return to main window", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true) {
            self.dismiss(animated: true)
        }
    }
}
