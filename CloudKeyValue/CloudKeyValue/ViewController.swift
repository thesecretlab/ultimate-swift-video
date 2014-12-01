//
//  ViewController.swift
//  CloudKeyValue
//
//  Created by Jon Manning on 1/12/2014.
//  Copyright (c) 2014 Secret Lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var keyValueStoreChangedObserver : AnyObject?
    
    // stored as a constant to prevent bugs
    let selectedIndexKey = "selectedIndex"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Ensure that we've got iCloud access
        
        if NSFileManager.defaultManager().ubiquityIdentityToken != nil {
            
            self.segmentedControl.enabled = true
            
        } else {
            
            self.segmentedControl.enabled = false
            
        }
        
        // Get notified when it changes remotely
        self.keyValueStoreChangedObserver = NSNotificationCenter.defaultCenter().addObserverForName(NSUbiquitousKeyValueStoreDidChangeExternallyNotification, object: nil, queue: NSOperationQueue.mainQueue(), usingBlock: { (notification) -> Void in
            
            self.updateSelectedSegment()
        })
        
        // Update the view right away
        self.updateSelectedSegment()
        
        
    }
    
    func updateSelectedSegment () {
        if let selectedIndex = NSUbiquitousKeyValueStore.defaultStore().objectForKey(selectedIndexKey) as? Int {
        
            self.segmentedControl.selectedSegmentIndex = selectedIndex
        } else {
            
            self.segmentedControl.selectedSegmentIndex = -1
            
        }
    }

    @IBAction func valueChanged(sender: UISegmentedControl) {
        
        NSUbiquitousKeyValueStore.defaultStore().setObject(self.segmentedControl.selectedSegmentIndex, forKey: selectedIndexKey)
        
        // forces a sync immediately, not strictly necessary but speeds things up
        NSUbiquitousKeyValueStore.defaultStore().synchronize()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

