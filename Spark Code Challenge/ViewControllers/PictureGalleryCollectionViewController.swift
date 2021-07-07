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
    private let orientation = UIApplication.shared.statusBarOrientation

    private lazy var collectionView: UICollectionView = {
        let layout = PictureGalleryCollectionViewLayout()
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PictureGalleryCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()

    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
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

    override func viewWillLayoutSubviews() {
        if orientation == .landscapeLeft || orientation == .landscapeRight {
            self.collectionView.collectionViewLayout.invalidateLayout()
            self.collectionView.collectionViewLayout = PictureGalleryCollectionViewLayout()
        } else {
            self.collectionView.collectionViewLayout.invalidateLayout()
            self.collectionView.collectionViewLayout = PictureGalleryCollectionViewLayout()
        }
    }

    private func setupCollectionViews() {
        viewModel.setView(view: self)
        view.backgroundColor = UIColor.white
        view.addSubview(collectionView)
        setupConstraintsForCollectionView()
    }

    private func setupConstraintsForCollectionView() {
        let constraints = [
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]

        constraints.forEach { $0.isActive = true }
    }

    private func setUpActivityIndicator() {
        activityIndicatorView.center = self.view.center
        view.addSubview(activityIndicatorView)
        view.addSubview(activityIndicatorLabel)
        setupConstraintsForActivityIndicatorView()
    }

    private func setupConstraintsForActivityIndicatorView() {
        let constraints = [
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicatorLabel.centerYAnchor.constraint(equalTo: activityIndicatorView.centerYAnchor, constant: 60),
            activityIndicatorLabel.centerXAnchor.constraint(equalTo: activityIndicatorView.centerXAnchor)
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
            self.collectionView.reloadData()
        }
    }

    func navigateToDetailsViewController(indexPath: IndexPath) {
        let detailsViewModel = viewModel.detailsViewModel(for: indexPath)
        let pictureData = viewModel.pictureData(for: indexPath)
        let detailsViewController = PictureGalleryDetailsViewController(pictureData: pictureData, viewModel: detailsViewModel)
        navigationController?.pushViewController(detailsViewController, animated: true)
    }

    func showAlert() {
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
            self.activityIndicatorLabel.isHidden = true
            let alert = UIAlertController(title: "Error",
                                          message: "There was an error while retrieving the image, please be sure you are connected to the internet and then click OK to retry",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
                self?.viewModel.loadData()
            }))
            self.present(alert, animated: true)
        }
    }

    func showActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicatorView.startAnimating()
            self.setupConstraintsForActivityIndicatorView()
            self.activityIndicatorView.isHidden = false
            self.activityIndicatorLabel.isHidden = false
        }
    }

    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
            self.activityIndicatorLabel.isHidden = true
        }
    }

}
