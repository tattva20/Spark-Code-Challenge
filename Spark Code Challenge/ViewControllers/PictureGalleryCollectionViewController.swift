//
//  PictureGalleryCollectionViewController.swift
//  Spark Code Challenge
//
//  Created by Octavio Rojas on 04/07/21.
//

import UIKit

class PictureGalleryCollectionViewController: NiblessViewController {

    // MARK: - Properties

    private let viewModel: PictureGalleryCollectionViewModel
    private let refreshControl = UIRefreshControl()

    private lazy var collectionView: UICollectionView = {
        let layout = PictureGalleryCollectionViewLayout()
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PictureGalleryCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()

    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.transform = CGAffineTransform(scaleX: 3, y: 3)
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()

    private lazy var activityIndicatorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Loading..."
        label.textColor = UIColor.black
        return label
    }()

    init(viewModel: PictureGalleryCollectionViewModel) {
        self.viewModel = viewModel
        super.init()
        navigationItem.title = "Picture Gallery"
    }

    // MARK: - Methods

    override func viewDidLoad() {
        setupCollectionViews()
        setUpActivityIndicator()
        setupRefreshControl()
        viewModel.loadData()
    }

    private func setupCollectionViews() {
        viewModel.setView(view: self)
        view.backgroundColor = UIColor.white
        view.addSubview(collectionView)
    }

    private func setUpActivityIndicator() {
        activityIndicatorView.center = self.view.center
        view.addSubview(activityIndicatorView)
        view.addSubview(activityIndicatorLabel)
        setupConstraintsForActivityIndicatorLabel()
        activityIndicatorView.startAnimating()
    }

    private func setupConstraintsForActivityIndicatorLabel() {
        let constraints = [
            activityIndicatorLabel.topAnchor.constraint(equalTo: activityIndicatorView.bottomAnchor, constant: 40),
            activityIndicatorLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ]
        
        constraints.forEach { $0.isActive = true }
    }

    private func setupRefreshControl() {
        let font = UIFont.systemFont(ofSize: 16)
        let attributes = [NSAttributedString.Key.font: font,
                          .foregroundColor: UIColor.black]
        refreshControl.attributedTitle = NSMutableAttributedString(string: "Fetching pictures...", attributes: attributes)
        
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }

    @objc private func refreshData(_ sender: Any) {
        viewModel.reloadData()
    }

}

extension PictureGalleryCollectionViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.pictureData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? PictureGalleryCollectionViewCell else {
            return UICollectionViewCell()
        }

        return cell
    }
    
}

extension PictureGalleryCollectionViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? PictureGalleryCollectionViewCell else { return }
        viewModel.configure(cell, at: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.navigateToDetailsViewController(indexPath: indexPath)
    }

}

extension PictureGalleryCollectionViewController: PictureGalleryCollectionViewProtocol {

    func reloadCollectionViewData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.collectionView.refreshControl?.endRefreshing()
        }
    }
    
    func loadCollectionViewData() {
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
            self.activityIndicatorLabel.isHidden = true
            self.collectionView.reloadData()
        }
    }
    
    func navigateToDetailsViewController(indexPath: IndexPath) {
        let detailsViewModel = viewModel.detailsViewModel(for: indexPath)
        let pictureData = viewModel.pictureData(for: indexPath)
        let detailsViewController = PictureGalleryDetailsViewController(pictureData: pictureData, viewModel: detailsViewModel)
        navigationController?.pushViewController(detailsViewController, animated: true)
    }

}
