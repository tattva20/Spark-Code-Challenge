//
//  PictureGalleryCollectionViewLayout.swift
//  Spark Code Challenge
//
//  Created by Octavio Rojas on 04/07/21.
//

import UIKit

public class PictureGalleryCollectionViewLayout: UICollectionViewFlowLayout {

    override init() {
        super.init()

        let screenWidth = UIScreen.main.bounds.width
        let widthHeightConstant = UIScreen.main.bounds.width / 2.2
        self.itemSize = CGSize(width: widthHeightConstant,
                               height: widthHeightConstant)
        let numberOfCellsInRow = floor(screenWidth / widthHeightConstant)
        let inset = (screenWidth - (numberOfCellsInRow * widthHeightConstant)) / (numberOfCellsInRow + 1)
        self.sectionInset = .init(top: inset,
                                  left: inset,
                                  bottom: inset,
                                  right: inset)
        self.minimumInteritemSpacing = inset
        self.minimumLineSpacing = inset
        self.scrollDirection = .vertical
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
