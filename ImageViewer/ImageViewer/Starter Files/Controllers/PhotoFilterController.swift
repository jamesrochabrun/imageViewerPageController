//
//  PhotoFilterController.swift
//  ImageViewer
//
//  Created by James Rochabrun on 1/3/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation

import UIKit


/// MARK REVIEW
// a Core image represents a drawing destination, a recepie
// CIImage immediately applies a filter, or any other image processing operations to save processing overhead? false
// A Core Image context is immutable and can be reused across different processes. True

class PhotoFilterController: UIViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var filtersCollectionView: UICollectionView! {
        didSet {
            filtersCollectionView.dataSource = self
        }
    }
    
    var context: CIContext!
    let filtrationQueue = OperationQueue()
    // its better to have a dictionary to keep track of the operation, check the implementation
    // of itunes search app
    var filtrationsInProgress = Set<IndexPath>()
    var photo: UIImage?
    
    // DATASOURCE ARRAYS
    let filters = PhotoFilter.defaultFilters
    
    // we need to have the same amount to filtrationimages as we have filters , the FiltrationImage is just a tracker
    lazy var filtrationImages: [FiltrationImage] = {
        guard let image = self.photo else { return [] }
        // scaling down image
        let imageWidth = image.size.width
        let imageHeight = image.size.height
        
        let scaledWidth: CGFloat = 100
        let scaledRatio = scaledWidth/imageWidth
        let scaledHeight = scaledRatio * imageHeight
        
        let rect = CGRect(x: 0, y: 0, width: scaledWidth, height: scaledHeight)
        UIGraphicsBeginImageContext(rect.size) // inidcating to write this in a off scren buffer (a region of memory usde sto store fisical data) // "off screen"
        image.draw(in: rect)
        guard let scaledimage = UIGraphicsGetImageFromCurrentImageContext() else {
            return  []
        }
        // context no needed now end context
        UIGraphicsEndImageContext()
        // we dont use the $0 because we just need to match the count
        return self.filters.map { _ in return FiltrationImage(image: scaledimage)}
    }()
    ///////////////////////////////////////

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
        
        let filtrationImage = filtrationImages[indexPath.row]
        if filtrationImage.filterState == .filtered {
            cell.imageView.image = filtrationImage.image
        } else {
            cell.imageView.image = nil //placeholder image is better
        }
        let filter = filters[indexPath.row]
        switch filtrationImage.filterState {
        case .notFilterApplied:
            startFiltrationOperationForImage(filtrationImage, withFilter: filter, at: indexPath)
        case .filtered: break
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filtrationImages.count
    }
    
    /// Operations
    func startFiltrationOperationForImage(_ image: FiltrationImage, withFilter filter: CIFilter, at indexPath: IndexPath) {
        
        /// we need to keep track the filter applied to an image thats why we pass a FiltrationImage
        // 1 check first if theres an operation for the current indexpatj
        if filtrationsInProgress.contains(indexPath) { return }
        // 2 if not operation exists lets create one
        let operation = ImageFiltrationOperation(image: image, filter: filter)
        
        // 3 perform action
        operation.completionBlock = {
            // check always if operation is canceled
            if operation.isCancelled { return }
            
            DispatchQueue.main.async {
                self.filtrationsInProgress.remove(indexPath)
                self.filtersCollectionView.reloadItems(at: [indexPath])
            }
        }
        // 4 keep track of operation and indexpath
        filtrationsInProgress.insert(indexPath)
        filtrationQueue.addOperation(operation)
    }
}
















