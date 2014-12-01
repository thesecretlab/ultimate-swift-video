//
//  AppDelegate.swift
//  UIAppearance
//
//  Created by Jon Manning on 21/11/2014.
//  Copyright (c) 2014 Secret Lab. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var primaryColor : UIColor {
        get {
            
            return UIColor(hue: 0.11, saturation:0.66, brightness:0.95, alpha:1.0)
        }
    }
    
    var secondaryColor : UIColor {
        get {
            
            return UIColor(hue:0.04, saturation:0.78, brightness:0.85, alpha:1.0)
        }
    }


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        self.applyTheming()
        
        return true
    }

    
    func applyTheming() {
        UINavigationBar.appearance().tintColor = self.secondaryColor
        UINavigationBar.appearance().barTintColor = self.primaryColor
        
        UIBarButtonItem.appearance().tintColor = self.secondaryColor
        UIBarButtonItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: self.secondaryColor], forState: UIControlState.Normal)
        
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: self.secondaryColor]
        
        
        UIButton.appearance().tintColor = self.secondaryColor;
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}
