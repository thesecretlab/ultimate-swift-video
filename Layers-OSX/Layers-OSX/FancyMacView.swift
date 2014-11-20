//
//  FancyMacView.swift
//  Layers-OSX
//
//  Created by Jon Manning on 20/11/2014.
//  Copyright (c) 2014 Secret Lab. All rights reserved.
//

import Cocoa

@IBDesignable class FancyMacView: NSView {
    
    @IBInspectable var color : NSColor = NSColor.greenColor()
    
    override func drawRect(dirtyRect: NSRect) {
        
        let rect = NSInsetRect(self.bounds, 20, 20)
        
        let path = NSBezierPath(roundedRect: rect, xRadius: 10.0, yRadius: 10.0)
        
        color.setFill()
        
        path.fill()
        
    }
    
   
}
