//
//  FilteredImageBuilder.swift
//  ImageViewer
//
//  Created by James Rochabrun on 1/3/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation
import CoreImage
import UIKit

class FilteredImageBuilder {
    
    private let image: UIImage
    
    init(image: UIImage) {
        self.image = image
    }
    
    func applyFilter(_ filter: CIFilter) -> UIImage? {
        guard let inputImage = image.ciImage ?? CIImage(image: self.image) else { return nil }
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        guard let outputImage = filter.outputImage else { return nil }
        return UIImage(ciImage: outputImage)
    }
    
    func image(withFilters filters: [CIFilter]) -> [UIImage] {
        return filters.flatMap { applyFilter($0) }
    }
    
    func imageWithDefaultFilters() -> [UIImage] {
        return image(withFilters: PhotoFilter.defaultFilters)
    }
}
