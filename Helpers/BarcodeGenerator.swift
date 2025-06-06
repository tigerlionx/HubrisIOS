//
//  BarcodeGenerator.swift
//  Hubris 2
//
//  Created by Emmanuel Leveille on 6/2/25.
//

import UIKit
import CoreImage.CIFilterBuiltins

struct BarcodeGenerator {
    static func generateBarcode(from string: String) -> UIImage? {
        let data = Data(string.utf8)
        let filter = CIFilter.code128BarcodeGenerator()
        filter.message = data
        if let outputImage = filter.outputImage {
            let scaled = outputImage.transformed(by: CGAffineTransform(scaleX: 3, y: 3))
            return UIImage(ciImage: scaled)
        }
        return nil
    }
}
