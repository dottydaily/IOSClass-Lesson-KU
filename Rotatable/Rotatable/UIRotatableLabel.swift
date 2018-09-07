//
//  UIRotatableLabel.swift
//  Rotatable
//
//  Created by iOS Dev on 8/30/2561 BE.
//  Copyright © 2561 iOS Dev. All rights reserved.
//

import UIKit

@IBDesignable
class UIRotatableLabel: UILabel {

    @IBInspectable
    public var rotate : Float = 0.0 {
        didSet{
            self.transform = CGAffineTransform(rotationAngle: CGFloat(self.rotate * .pi/180))
        }
    }
    
}
