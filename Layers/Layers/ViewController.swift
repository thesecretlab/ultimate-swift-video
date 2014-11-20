//
//  ViewController.swift
//  Layers
//
//  Created by Jon Manning on 20/11/2014.
//  Copyright (c) 2014 Secret Lab. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var keyframeAnimatedImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // BORDER COLOR
        self.imageView.layer.borderColor = UIColor.redColor().CGColor
        self.imageView.layer.borderWidth = 1.0
        
        // SHADOW
        self.imageView.layer.shadowColor = UIColor.blackColor().CGColor
        self.imageView.layer.shadowOffset = CGSize(width: 10, height: 10)
        self.imageView.layer.shadowOpacity = 0.5
        
        // DON'T CLIP SHADOW
        self.imageView.clipsToBounds = false
        
        
        // SHAPE LAYER
        let circleLayer = CAShapeLayer()
        
        let path = UIBezierPath(ovalInRect: CGRect(x: 20, y: 20, width: 100, height: 100))
        
        circleLayer.path = path.CGPath
        
        self.view.layer.addSublayer(circleLayer)
        
        // ROTATE THE LAYER
        
        // Rotate 90° (PI/2 radians) around Z axis,
        // which faces the user
        let angle = CGFloat(M_PI / 2.0)
        var rotation = CATransform3DMakeRotation(angle, 0.0, 1.0, 0.0)
        rotation.m34 = 1.0 / 500.0
        
        self.imageView.layer.transform = rotation
        
        // ANIMATING THE ROTATION
        
        let destinationTransform = CATransform3DIdentity
        
        let animation = CABasicAnimation(keyPath: "transform")
        
        animation.fromValue = NSValue(CATransform3D: rotation)
        animation.toValue = NSValue(CATransform3D: destinationTransform)
        
        animation.duration = 1.0
        animation.autoreverses = true
        animation.repeatCount = HUGE
        
        self.imageView.layer.addAnimation(animation, forKey: "rotating")
        
        
        // ADD KEYFRAME ANIMATION
        
        let keyframeAnimation = CAKeyframeAnimation(keyPath: "position")
        
        keyframeAnimation.values = [
            NSValue(CGPoint: CGPoint(x: 50, y: 50)),
            NSValue(CGPoint: CGPoint(x: 150, y: 50)),
            NSValue(CGPoint: CGPoint(x: 150, y: 150)),
            NSValue(CGPoint: CGPoint(x: 50, y: 150)),
            NSValue(CGPoint: CGPoint(x: 50, y: 50))
            
        ]
        
        keyframeAnimation.keyTimes = [
            0.0, 0.5, 0.75, 0.9, 1.0
        ]
        
        keyframeAnimation.duration = 1.0
        keyframeAnimation.repeatCount = HUGE
        
        keyframeAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        self.keyframeAnimatedImageView.layer.addAnimation(keyframeAnimation, forKey: "move")
        
    }
    
    override func viewDidLayoutSubviews() {
        
        // MASK WITH CIRCLE
        
        let shapeLayer = CAShapeLayer()
        
        let path = UIBezierPath(ovalInRect: self.imageView.bounds)
        
        shapeLayer.path = path.CGPath
        
        self.imageView.layer.mask = shapeLayer
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

