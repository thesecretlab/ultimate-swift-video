//
//  AppDelegate.swift
//  VideoPlayback
//
//  Created by Jon Manning on 20/11/2014.
//  Copyright (c) 2014 Secret Lab. All rights reserved.
//

import Cocoa
import AVKit
import AVFoundation

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    @IBOutlet weak var videoPlayerView: AVPlayerView!

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        
        let contentURL = NSBundle.mainBundle().URLForResource("TestVideo", withExtension: "m4v")
        
        let player = AVPlayer(URL: contentURL)
        
        self.videoPlayerView.player = player
        
        
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

