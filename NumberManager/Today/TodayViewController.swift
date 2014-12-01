//
//  TodayViewController.swift
//  Today
//
//  Created by Jonathon Manning on 21/11/2014.
//  Copyright (c) 2014 Jonathon Manning. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    var defaultsDidChangeObserver : AnyObject?
    
    let defaults = NSUserDefaults(suiteName: "group.NumberManager")
    
    @IBAction func stepperValueChanged(sender: AnyObject) {
        defaults?.setInteger(NSInteger(self.stepper.value), forKey: "number")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        
        self.updateInterface()
        
        defaultsDidChangeObserver = NSNotificationCenter.defaultCenter().addObserverForName(NSUserDefaultsDidChangeNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (notification) -> Void in
            
            self.updateInterface()
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        
        self.updateInterface()

        completionHandler(NCUpdateResult.NewData)
    }
    
    func updateInterface() {
        
        if let number : Int = defaults?.integerForKey("number") {
            self.stepper.value = Double(number)
            self.numberLabel.text = "\(number)"
        }
        
    }
    
}
