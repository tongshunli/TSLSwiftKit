//
//  TSLSlider.swift
//  MyEngineeringCollection
//
//  Created by 佟顺利 on 2025/7/25.
//

import UIKit

class TSLSlider: UISlider {
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.trackRect(forBounds: bounds)
        rect.size.height = 1.5
        return rect
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
