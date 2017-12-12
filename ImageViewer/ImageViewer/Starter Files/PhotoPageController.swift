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
    let pageControllerDataSource = PhotoPageControllerDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = pageControllerDataSource
        configureControllers()
    }
    
    private func configureControllers() {
        
        guard let storyboard = storyboard, let photoViewerController = storyboard.instantiateViewController(withIdentifier: "PhotoViewerController") as? PhotoViewerController else { return }
        photoViewerController.photo = photos[indexOfCurrentPhoto]
        setViewControllers([photoViewerController], direction: .forward, animated: false)
    }
}

class PhotoPageControllerDataSource: NSObject, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nil
    }
}
















