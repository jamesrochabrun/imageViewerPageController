//
//  PhotoViewerController.swift
//  ImageViewer
//
//  Created by James Rochabrun on 12/11/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import UIKit

class PhotoViewerController: UIViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    var photo: Photo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoImageView.image = photo.image
    }
    
    
    @IBAction func launchPhotoZoomController(_ sender: UITapGestureRecognizer) {
        guard let storyboard = storyboard,
            let zoomController = storyboard.instantiateViewController(withIdentifier: "PhotoZoomController") as? PhotoZoomController  else { return }
        zoomController.photo = photo
        navigationController?.present(zoomController, animated: true)
    }
}
