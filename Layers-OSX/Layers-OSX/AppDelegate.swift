//
//  AppDelegate.swift
//  Layers-OSX
//
//  Created by Jon Manning on 20/11/2014.
//  Copyright (c) 2014 Secret Lab. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    @IBOutlet weak var animatableView: FancyMacView!

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        
        let animation = CABasicAnimation(keyPath: "position")
        
        animation.byValue = NSValue(point: NSPoint(x: 0, y: -50))
        animation.autoreverses = true
        animation.duration = 1.0
        animation.repeatCount = HUGE
        
        self.animatableView.layer?.addAnimation(animation, forKey: "move")
        
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

