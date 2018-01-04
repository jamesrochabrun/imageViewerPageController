//
//  PhotoPickerManager.swift
//  ImageViewer
//
//  Created by James Rochabrun on 12/11/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import UIKit
import MobileCoreServices

protocol PhotoPickerManagerDelegate: class {
    func manager(_ manager: PhotoPickerManager, didPickImage image: UIImage)
}

class PhotoPickerManager: NSObject {
    
    private let imagePickerController = UIImagePickerController()
    private let presentingController: UIViewController
    weak var delegate: PhotoPickerManagerDelegate?
 
    init(presentingController: UIViewController) {
        self.presentingController = presentingController
        super.init()
        configure()
    }
    
    /// presenting picker
    func presentPhotoPicker(animated: Bool) {
        presentingController.present(imagePickerController, animated: animated, completion: nil)
    }
    
    /// dismissing picker
    func dismissPhotoPicker(animated: Bool, completion: (() -> Void)?) {
        imagePickerController.dismiss(animated: animated, completion: completion)
    }
    
    /// configure picker
    private func configure() {
        if UIImagePickerController.isSourceTypeAvailable(.camera)  {
            imagePickerController.sourceType = .camera
            imagePickerController.cameraDevice = .front
        } else {
            imagePickerController.sourceType = .photoLibrary
        }
        /// only camera photo no videos
        imagePickerController.mediaTypes = [kUTTypeImage as String]
        imagePickerController.delegate = self
    }
}

extension PhotoPickerManager: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        /// getting original image
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        self.delegate?.manager(self, didPickImage: image)        
     }
}






















