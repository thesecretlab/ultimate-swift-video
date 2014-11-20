//
//  ViewController.swift
//  TouchesAndGestures
//
//  Created by Jon Manning on 18/11/2014.
//  Copyright (c) 2014 Secret Lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Creating a tap gesture recognizer in code
        let tapGesture = UITapGestureRecognizer(target: self, action: "tapped:")
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func tapped(recognizer: UITapGestureRecognizer) {
        if (recognizer.state == UIGestureRecognizerState.Ended) {
            NSLog("Tapped!")
        }
    }

    @IBAction func pinched(sender: UIPinchGestureRecognizer) {
        
        if sender.state == UIGestureRecognizerState.Changed {
            
            NSLog("Pinch changed: \(sender.scale)")
            
        }
        
    }
    
    @IBAction func swiped(sender: UISwipeGestureRecognizer) {
        
        
        if sender.state == UIGestureRecognizerState.Ended {
            NSLog("Swiped right")
        }
        
    }
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        NSLog("\(touches.count) touches began")
    }
    
    override func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!) {
        NSLog("\(touches.count) touches cancelled")
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        NSLog("\(touches.count) touches ended")
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        for touch in touches.allObjects as [UITouch] {
            
            NSLog("Touch moved from \(touch.previousLocationInView(self.view)) to \(touch.locationInView(self.view))")
            
        }
    }

}

