//
//  AppDelegate.swift
//  Windows
//
//  Created by Jon Manning on 18/11/2014.
//  Copyright (c) 2014 Secret Lab. All rights reserved.
//

import Cocoa

class SecondWindow : NSWindowController {
    
    @IBAction func alert(sender: AnyObject) {
        NSLog("Woop");
    }
    
}

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    
    var anotherWindow : NSWindowController!

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        
        anotherWindow = SecondWindow(windowNibName: "SecondWindow")
        anotherWindow.window?.orderFront(nil)
    }

}

