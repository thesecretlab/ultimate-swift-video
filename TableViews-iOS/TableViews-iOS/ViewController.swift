//
//  ViewController.swift
//  TableViews-iOS
//
//  Created by Jon Manning on 18/11/2014.
//  Copyright (c) 2014 Secret Lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var numbers : [Int] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for i in 1...200 {
            numbers.append(i)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numbers.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("NumberCell") as UITableViewCell!
        
        let numberToShow = numbers[indexPath.row]
        
        cell.textLabel.text = String(numberToShow)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let numberToShow = numbers[indexPath.row]
        
        
        NSLog("Selected \(numberToShow)")
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }


}

