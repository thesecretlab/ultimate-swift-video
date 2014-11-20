//
//  AppDelegate.swift
//  Notifications-OSX
//
//  Created by Jon Manning on 20/11/2014.
//  Copyright (c) 2014 Secret Lab. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSUserNotificationCenterDelegate {

    @IBOutlet weak var window: NSWindow!


    @IBAction func showNotification(sender: AnyObject) {
        
        let notificationCenter = NSUserNotificationCenter.defaultUserNotificationCenter()
        
        let notification = NSUserNotification()

        notification.title = "Hello"
        notification.informativeText = "This is your scheduled wake-up call!"
        
        // requires that NSUserNotificationAlertStyle = "alert" in info.plist
        notification.hasActionButton = true
        notification.actionButtonTitle = "Wake Up"
        
        notification.deliveryDate = NSDate(timeIntervalSinceNow: 1.0)
        
        notificationCenter.scheduleNotification(notification)
    }
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let notificationCenter = NSUserNotificationCenter.defaultUserNotificationCenter()
        
        notificationCenter.delegate = self
    }
    
    func userNotificationCenter(center: NSUserNotificationCenter, didActivateNotification notification: NSUserNotification) {
        
        switch notification.activationType {
        case .ActionButtonClicked:
            NSLog("User clicked Wake Up!")
        case .ContentsClicked:
            NSLog("User clicked the notification!")
        default:
            NSLog("Something else happened!")
        }
    }
}

