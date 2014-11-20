//
//  FancyBezierView.swift
//  CustomViewsAndDrawing
//
//  Created by Jon Manning on 20/11/2014.
//  Copyright (c) 2014 Secret Lab. All rights reserved.
//

import UIKit

@IBDesignable class FancyBezierView: UIView {

    @IBInspectable var fillColor = UIColor.greenColor()
    @IBInspectable var strokeColor = UIColor.blackColor()
    @IBInspectable var lineWidth : CGFloat = 3.0
    
    @IBInspectable var quadCurveControlPoint : CGPoint = CGPoint(x: 100, y: 50)
    
    @IBInspectable var curveControlPoint1 : CGPoint  = CGPoint(x: 150, y: 25)
    @IBInspectable var curveControlPoint2 : CGPoint  = CGPoint(x: 50, y: 75)
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        
        // Setting colors to use
        self.fillColor.setFill()
        self.strokeColor.setStroke()
        
        
        // Simple circle by creating an oval inside a square
        let circle = UIBezierPath(ovalInRect: CGRect(x: 5, y: 5, width: 40, height: 40))
        circle.lineWidth = self.lineWidth
        
        circle.fill()
        circle.stroke()
        
        // Drawing a straight line
        let line = UIBezierPath()
        
        line.lineWidth = self.lineWidth
        
        line.moveToPoint(CGPoint(x: 0, y: 0))
        line.addLineToPoint(CGPoint(x: 50, y: 50))
        
        line.stroke()
        
        // Drawing a quadratic curve line (not available on OS X)
        let quadCurve = UIBezierPath()
        quadCurve.lineWidth = self.lineWidth
        quadCurve.moveToPoint(CGPoint(x: 50, y: 0))
        
        // Quad curves have a single control point
        quadCurve.addQuadCurveToPoint(
            CGPoint(x: 50, y: 100),
            controlPoint: self.quadCurveControlPoint
        )
        
        quadCurve.stroke()
        
        // Drawing a curve (available on both iOS and OSX)
        let curve = UIBezierPath()
        
        curve.lineWidth = self.lineWidth
        curve.moveToPoint(CGPoint(x: 100, y: 0))
        
        curve.addCurveToPoint(
            CGPoint(x: 100, y: 100),
            controlPoint1: self.curveControlPoint1,
            controlPoint2: self.curveControlPoint2
        )
        curve.stroke()
        
    }
}
