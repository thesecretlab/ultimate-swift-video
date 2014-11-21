//
//  ViewController.swift
//  NumberManager
//
//  Created by Jonathon Manning on 21/11/2014.
//  Copyright (c) 2014 Jonathon Manning. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var stepper: UIStepper!
    
    let defaults = NSUserDefaults(suiteName: "group.NumberManager")
    
    @IBAction func stepperValueChanged(sender: AnyObject) {
        
        // This will cause the interface to update
        
        defaults?.setInteger(NSInteger(self.stepper.value), forKey: "number")
        
    }
    
    var defaultsDidChangeObserver : AnyObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.updateInterface()
        
        defaultsDidChangeObserver = NSNotificationCenter.defaultCenter().addObserverForName(NSUserDefaultsDidChangeNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (notification) -> Void in
            
            self.updateInterface()
            
        }
    }
    
    func updateInterface() {
        
        if let number : Int = defaults?.integerForKey("number") {
            self.stepper.value = Double(number)
            self.numberLabel.text = "\(number)"
        }
        
    }


}

