//
//  FancyBlendingView.swift
//  CustomViewsAndDrawing
//
//  Created by Jon Manning on 20/11/2014.
//  Copyright (c) 2014 Secret Lab. All rights reserved.
//

import UIKit

@IBDesignable class FancyBlendingView: UIView {

    @IBInspectable var color1 : UIColor = UIColor.yellowColor()
    @IBInspectable var color2 : UIColor = UIColor.blueColor()
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        let rectangle1 = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 50, height: 50))
        let rectangle2 = UIBezierPath(rect: CGRect(x: 25, y: 25, width: 50, height: 50))
        
        color1.setFill()
        rectangle1.fill()
        
        color2.setFill()
        rectangle2.fillWithBlendMode(kCGBlendModeMultiply, alpha: 1.0)
        
        
    }
    

}
