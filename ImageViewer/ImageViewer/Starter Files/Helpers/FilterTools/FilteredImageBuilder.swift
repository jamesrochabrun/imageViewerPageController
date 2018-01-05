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
    private let context: CIContext
    
    init(image: UIImage, context: CIContext) {
        self.image = image
        self.context = context
    }
    
    func applyFilter(_ filter: CIFilter) -> CGImage? {
        guard let inputImage = image.ciImage ?? CIImage(image: self.image) else { return nil }
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        guard let outputImage = filter.outputImage else { return nil }
        
        // when applying a filter in to an image it can change its dimensions like adding a border etc, so this method will make
        // the outputimage match the bounds of the inputimage extent
        return context.createCGImage(outputImage, from: inputImage.extent)
    }
    
    func image(withFilters filters: [CIFilter]) -> [CGImage] {
        return filters.flatMap { applyFilter($0) }
    }
    
    func imageWithDefaultFilters() -> [CGImage] {
        return image(withFilters: PhotoFilter.defaultFilters)
    }
}







