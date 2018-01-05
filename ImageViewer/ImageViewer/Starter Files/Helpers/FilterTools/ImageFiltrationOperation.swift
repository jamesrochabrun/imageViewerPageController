//
//  ImageFiltrationOperation.swift
//  ImageViewer
//
//  Created by James Rochabrun on 1/4/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation
import UIKit
import CoreImage

enum ImageFilterstate {
    case filtered
    case notFilterApplied
}

class FiltrationImage {
    var image: UIImage
    var filterState: ImageFilterstate = .notFilterApplied
    
    init(image: UIImage) {
        self.image = image
    }
}

class imageFiltrationOperation: Operation {
    
    let filtrationImage: FiltrationImage
    let filter: CIFilter
    
    init(image: FiltrationImage, filter: CIFilter) {
        self.filter = filter
        self.filtrationImage = image
    }
    
    override func main() {
        // check first if operation has not been canceled or filtered
        if self.isCancelled { return }
        if self.filtrationImage.filterState == .filtered { return }
        if let filteredImage = applyFilter(filter, image: filtrationImage.image) {
            filtrationImage.image = filteredImage
            filtrationImage.filterState = .filtered
        }
    }
    
    private func applyFilter(_ filter: CIFilter, image: UIImage) -> UIImage? {
        
        //we are creating a new context for new operation for efficiency
        let context = CIContext()
        let filteredImageBuilder = FilteredImageBuilder(image: image, context: context)
        if let filteredImage = filteredImageBuilder.applyFilter(filter) {
            return UIImage(cgImage: filteredImage)
        } else {
            return nil
        }
    }
}














