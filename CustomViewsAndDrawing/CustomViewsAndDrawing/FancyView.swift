//
//  FancyView.swift
//  CustomViewsAndDrawing
//
//  Created by Jon Manning on 20/11/2014.
//  Copyright (c) 2014 Secret Lab. All rights reserved.
//

import UIKit

@IBDesignable class FancyView: UIView {

    @IBInspectable var color : UIColor = UIColor.greenColor()
    @IBInspectable var cornerRadius : CGFloat = 10.0
    
    override func drawRect(rect: CGRect) {
        
#if TARGET_INTERFACE_BUILDER
    // this code only runs in IB
#else
    // this code only runs in the real app
#endif
        
        let rectangle = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius)
        
        color.setFill()
        
        rectangle.fill()
        
    }



}
