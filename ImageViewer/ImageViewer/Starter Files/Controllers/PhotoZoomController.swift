//
//  PhotoZoomController.swift
//  ImageViewer
//
//  Created by James Rochabrun on 12/11/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import UIKit


///here is how to create a zoom view

class PhotoZoomController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.delegate = self
        }
    }
    var photo: Photo!
    
    var minZoomScale: CGFloat {
        let viewSize = view.bounds.size
        let widthScale = viewSize.width / photoImageView.bounds.width
        let heightScale = viewSize.height / photoImageView.bounds.height
        return min(widthScale, heightScale)
    }
    
    @IBOutlet weak var imageViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewtopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoImageView.image = photo.image
        /// define content size of scrolview by...
        photoImageView.sizeToFit()
        scrollView.contentSize = photoImageView.bounds.size
        ///updating scale
        updateZoomScale()
        updateConstraintsForSize(view.bounds.size)
        view.backgroundColor = .black
    }
    
    private func updateZoomScale() {
        scrollView.minimumZoomScale = minZoomScale
        scrollView.zoomScale = minZoomScale
    }
    
    // when called on viewdidload it will center the imageview in the center of the scrollview
    // when called on the delegate method it will fix the extra spaces and will clip the imageview to the screen
    private func updateConstraintsForSize(_ size: CGSize) {
        
        let verticalSpace = size.height - photoImageView.frame.height
        let yOffset = max(0, verticalSpace / 2)
        
        imageViewtopConstraint.constant = yOffset
        imageViewtopConstraint.constant = yOffset
        
        let xOffset = max(0, (size.width - photoImageView.frame.width) / 2)
        imageViewLeadingConstraint.constant = xOffset
        imageViewTrailingConstraint.constant = xOffset
    }
}

extension PhotoZoomController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoImageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        // fixing extra space
        updateConstraintsForSize(view.bounds.size)
        // dismissing the view when imageview gets lower in size by pinching
        dismissController()
    }
    
    private func dismissController() {
        if scrollView.zoomScale < minZoomScale {
            dismiss(animated: true, completion: nil)
        }
    }
}





