//
//  PhotoZoomController.swift
//  ImageViewer
//
//  Created by James Rochabrun on 12/11/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import UIKit

class PhotoZoomController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.delegate = self
        }
    }
    @IBOutlet weak var photoImageView: UIImageView!
    var photo: Photo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoImageView.image = photo.image
        /// define content size of scrolview by...
        photoImageView.sizeToFit()
        scrollView.contentSize = photoImageView.bounds.size
        ///updating scale
        updateZoomScale()
    }
    
    func updateZoomScale() {
        let viewSize = view.bounds.size
        let widthScale = viewSize.width / photoImageView.bounds.width
        let heightScale = viewSize.height / photoImageView.bounds.height
        let minScale = min(widthScale, heightScale)
        scrollView.minimumZoomScale = minScale
        scrollView.zoomScale = minScale
    }
}

extension PhotoZoomController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoImageView
    }
    
    
}





