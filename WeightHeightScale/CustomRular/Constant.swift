//
//  Constant.swift
//  WeightHeightScale
//
//  Created by Hareram on 25/10/26.
//

import UIKit

let kDefaultScrollViewSideOffset = 30.0 as CGFloat
let kDefaultPointerLayerSideOffset = 1.0 as CGFloat
let kDefaultSegmentControlTitleFont = UIFont.systemFont(ofSize: 14.0, weight: .semibold)

let kDefaultMarkerTypeFont: UIFont = UIFont.systemFont(ofSize: 12.0, weight: .semibold)
let kDefaultTextFieldFont: UIFont = UIFont.systemFont(ofSize: 14.0, weight: .bold)
let kScrollAnimationSpeed: CGFloat = 300.0
let kRangeLayerMaximumWidth: Float = 70000.0 //7000.0
let kRangeLayerMaximumHeight: Float = 70000.0


//MARK: ----------------- EXTENSION FOR UIIMAGE
extension UIImage {
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
