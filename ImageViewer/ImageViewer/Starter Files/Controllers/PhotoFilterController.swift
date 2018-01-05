//
//  PhotoFilterController.swift
//  ImageViewer
//
//  Created by James Rochabrun on 1/3/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation

import UIKit

class PhotoFilterController: UIViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var filtersCollectionView: UICollectionView! {
        didSet {
            filtersCollectionView.dataSource = self
        }
    }
    
    var context: CIContext!
    var photo: UIImage?

    private lazy var filteredImages: [CGImage] = {
        guard let image = self.photo else { return [] }
        let filteredImageBuilder = FilteredImageBuilder(image: image, context: self.context)
        return filteredImageBuilder.imageWithDefaultFilters()
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoImageView.image = photo
    }
}

extension PhotoFilterController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilteredImageCell.reuseID, for: indexPath) as? FilteredImageCell else { return UICollectionViewCell() }
        let cgImage = filteredImages[indexPath.row]
        cell.imageView.image = UIImage(cgImage: cgImage)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredImages.count
    }
}




