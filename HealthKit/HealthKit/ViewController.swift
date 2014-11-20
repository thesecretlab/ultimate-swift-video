//
//  ViewController.swift
//  HealthKit
//
//  Created by Jon Manning on 20/11/2014.
//  Copyright (c) 2014 Secret Lab. All rights reserved.
//

import UIKit
import HealthKit

class ViewController: UIViewController {

    lazy var healthStore = HKHealthStore()
    
    let energyConsumedType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryEnergyConsumed)
    
    @IBOutlet weak var caloriesConsumedLabel: UILabel!
    
    func queryEnergyConsumed( completionHandler: Double -> Void ) {
        
        let now = NSDate()
        let fourHoursAgo = NSDate(timeIntervalSinceNow: -60 * 4)
        
        let predicate = HKQuery.predicateForSamplesWithStartDate(fourHoursAgo,
            endDate: now, options: .StrictStartDate)
        
        let query = HKStatisticsQuery(quantityType: energyConsumedType,
            quantitySamplePredicate: predicate,
            options: .CumulativeSum) { query, result, error in
                
                if error != nil {
                    completionHandler(0)
                }
                
                if result == nil {
                    completionHandler(0)
                    return
                }
                
                var totalCalories = 0.0
                
                if let quantity = result.sumQuantity() {
                    let unit = HKUnit.kilocalorieUnit()
                    totalCalories = quantity.doubleValueForUnit(unit)
                }
                
                completionHandler(totalCalories)
        }
        
        healthStore.executeQuery(query)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if HKHealthStore.isHealthDataAvailable() {
            
            if healthStore.authorizationStatusForType(energyConsumedType) == HKAuthorizationStatus.NotDetermined {
                
                let typesToShare = NSSet(object: energyConsumedType)
                let typesToRead = NSSet(object: energyConsumedType)
                
                healthStore.requestAuthorizationToShareTypes(typesToShare, readTypes: typesToRead) { (success, error) -> Void in
                    
                    NSLog("Success: \(success)")
                    
                }
            }
            
            self.updateLabel()
            
        } else {
            self.caloriesConsumedLabel.text = "No health data available!"
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func updateLabel() {
        self.queryEnergyConsumed() { (calories) in
            
            NSOperationQueue.mainQueue().addOperationWithBlock() { () -> Void in
                self.caloriesConsumedLabel.text = "I've eaten \(calories) kcal in the last 4 hours!"
            }
            
            
            
        }
    }

    @IBAction func logNewData(sender: AnyObject) {
        
        let caloriesPerApple = 95.0
        
        let quantity = HKQuantity(unit: HKUnit.kilocalorieUnit(), doubleValue: caloriesPerApple)
        
        let now = NSDate()
        let newData = HKQuantitySample(type: self.energyConsumedType, quantity: quantity, startDate: now, endDate: now)
        
        self.healthStore.saveObject(newData) { (success, error) -> Void in
            
            NSLog("Save success: \(success)")
            
            self.updateLabel()
            
        }
        
    }
    

}

