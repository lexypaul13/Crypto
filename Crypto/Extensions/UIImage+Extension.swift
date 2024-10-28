//
//  UIImage+Extension.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import UIKit

extension UIImage {
    func parseQRCode() -> String? {
        guard let image = CIImage(image: self) else { return nil }

        let detector = CIDetector(ofType: CIDetectorTypeQRCode,
                                  context: nil,
                                  options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])

        let features = detector?.features(in: image) ?? []

        return features.compactMap{ ($0 as? CIQRCodeFeature)?.messageString }.first
    }
}
