//
//  PhotoPageController.swift
//  ImageViewer
//
//  Created by James Rochabrun on 12/11/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import UIKit

class PhotoPageController: UIPageViewController {
    
    var photos: [Photo] = []
    var indexOfCurrentPhoto: Int!
    lazy var pageControllerDataSource: PhotoPageControllerDataSource = {
        return PhotoPageControllerDataSource(photoPageController: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = pageControllerDataSource
        configureControllers()
    }
    
    private func configureControllers() {
        
        if let photoViewerController = photoViewerController(with: photos[indexOfCurrentPhoto]) {
            setViewControllers([photoViewerController], direction: .forward, animated: false)
        }
    }
    
    func photoViewerController(with photo: Photo) -> PhotoViewerController? {
        guard let storyboard = storyboard, let photoViewerController = storyboard.instantiateViewController(withIdentifier: "PhotoViewerController") as? PhotoViewerController else { return nil }
        photoViewerController.photo = photo
        return photoViewerController
    }
}

class PhotoPageControllerDataSource: NSObject, UIPageViewControllerDataSource {
    
    private var photoPageController: PhotoPageController?
    
    init(photoPageController: PhotoPageController) {
        self.photoPageController = photoPageController
        super.init()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        /// 1 get photo and check index
        guard let photoVC = viewController as? PhotoViewerController,
            let index = photoPageController?.photos.index(of: photoVC.photo) else { return nil }
        
        ///2 compare indexes and return nil if they match
        if index == photoPageController?.photos.startIndex {
            return nil
        } else{
            guard let indexBefore = photoPageController?.photos.index(before: index),
                let photo = photoPageController?.photos[indexBefore] else { return nil }
            return photoPageController?.photoViewerController(with: photo)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
       
        /// 1 get photo and check index
        guard let photoVC = viewController as? PhotoViewerController,
            let index = photoPageController?.photos.index(of: photoVC.photo) else { return nil }
        
        
        ///2 compare indexes and return nil if they match
        if index == (photoPageController?.photos.index(before: (photoPageController?.photos.endIndex)!))! {
            return nil
        } else{
            guard let indexAfter = photoPageController?.photos.index(after: index),
                let photo = photoPageController?.photos[indexAfter] else { return nil }
            return photoPageController?.photoViewerController(with: photo)
        }
    }
}

























