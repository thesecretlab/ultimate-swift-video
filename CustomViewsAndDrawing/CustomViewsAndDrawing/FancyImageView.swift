//
//  FancyImageView.swift
//  CustomViewsAndDrawing
//
//  Created by Jon Manning on 20/11/2014.
//  Copyright (c) 2014 Secret Lab. All rights reserved.
//

import UIKit

@IBDesignable class FancyImageView: UIView {

    
    override func drawRect(rect: CGRect) {
        
        // We can't use UIImage(named:) here if we're displaying it in Interface Builder - we need
        // to be more specific about WHERE to find it. In this case, we specify which bundle the image can be found in.
        // We do this by asking for the NSBundle that this class is contained in.
        // 'traitCollection' contains info like size class, whether we're an iPhone/iPad, etc
        
        let image = UIImage(named: "Photo 1", inBundle: NSBundle(forClass: FancyImageView.self), compatibleWithTraitCollection: self.traitCollection)
        
        image?.drawAtPoint(CGPoint(x: 0, y: 0))
        
        // The image will be drawn as 'scale to fit' - you'll need to do
        // your own rect math to make it work
        image?.drawInRect(CGRect(x: 10, y: 10, width: 50, height: 25))
        
    }
    

}
