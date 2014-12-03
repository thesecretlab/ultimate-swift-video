//
//  ViewController.swift
//  ToDo
//
//  Created by Jon Manning on 21/11/2014.
//  Copyright (c) 2014 Secret Lab. All rights reserved.
//

import UIKit
import CloudKit

class ViewController: UITableViewController {
    
    lazy var database : CKDatabase = {
        return CKContainer.defaultContainer().publicCloudDatabase
    }()
    
    let allTodoItemsQuery = CKQuery(recordType: "ToDoItem", predicate: NSPredicate(format: "TRUEPREDICATE"))
    
    var fetchedRecords : [CKRecord] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let queryOperation = CKQueryOperation(query: self.allTodoItemsQuery)
        
        fetchedRecords = []
        
        queryOperation.recordFetchedBlock = { (record) in
            
            
            
        }
        
        
    }
    
    func refreshRecords() {
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetchedRecords.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        
        let record = self.fetchedRecords[indexPath.row]
        
        cell.textLabel.text = record.objectForKey("Text") as? String
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

