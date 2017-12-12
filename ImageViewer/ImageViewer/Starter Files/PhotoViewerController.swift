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
}
