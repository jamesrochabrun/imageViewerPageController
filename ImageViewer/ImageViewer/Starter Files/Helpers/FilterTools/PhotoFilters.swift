//
//  PhotoFilters.swift
//  ImageViewer
//
//  Created by James Rochabrun on 1/3/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation
import CoreImage

struct PhotoFilter {
    
    private struct Filters {
        static let colorClamp = "CIColorClamp"
        static let colorControls = "CIColorControls"
        static let instantPhoto = "CIPhotoEffectInstant"
        static let effectPhoto = "CIPhotoEffectProcess"
        static let noirPhoto = "CIPhotoEffectNoir"
        static let sepia = "CISepiaTone"
    }
    
    private struct Constants {
        static let inputMinComponents = "inputMinComponents"
        static let inputMAxComponents = "inputMaxComponents"
        static let inputSaturation = kCIInputSaturationKey
        static let inputIntensity = kCIInputIntensityKey
    }
    
    private static var colorClamp: CIFilter? {
        guard let colorCLampFilter = CIFilter(name: Filters.colorClamp) else { return nil }
        /// CIVector initializer x,y,z,w is just RGB and alpha
        let minVector = CIVector(x: 0.2, y: 0.2, z: 0.2, w: 0.2)
        colorCLampFilter.setValue(minVector, forKey: Constants.inputMinComponents)
        let maxVector = CIVector(x: 0.9, y: 0.9, z: 0.9, w: 0.9)
        colorCLampFilter.setValue(maxVector, forKey: Constants.inputMAxComponents)
        return colorCLampFilter
    }
    
    /// MARK: Color sat, bright etc
    private static var colorControls: CIFilter? {
        guard let colorControlsFilter = CIFilter(name: Filters.colorControls) else { return nil }
        colorControlsFilter.setValue(0.1, forKey: Constants.inputSaturation)
        return colorControlsFilter
    }
    
    /// MARK: Color effect
    private static var instantPhoto: CIFilter? {
        return CIFilter(name: Filters.instantPhoto) ?? nil
    }
    
    private static var effectPhoto: CIFilter? {
        return CIFilter(name: Filters.effectPhoto) ?? nil
    }
    
    private static var noirPhoto: CIFilter? {
        return CIFilter(name: Filters.noirPhoto) ?? nil
    }
    
    private static var sepia: CIFilter? {
        guard let sepiaFilter = CIFilter(name: Filters.sepia) else { return nil }
        sepiaFilter.setValue(0.7, forKey: Constants.inputIntensity)
        return sepiaFilter
    }
    
    static var defaultFilters: [CIFilter] {
        return [colorClamp, colorControls, instantPhoto, effectPhoto, noirPhoto, sepia].flatMap { return $0 }
    }
}















