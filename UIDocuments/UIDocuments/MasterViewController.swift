//
//  MasterViewController.swift
//  UIDocuments
//
//  Created by Jon Manning on 21/11/2014.
//  Copyright (c) 2014 Secret Lab. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var documents: [NSURL] = []
    
    var documentsFolderURL : NSURL? {
        get {
            return NSFileManager.defaultManager().URLsForDirectory(
                NSSearchPathDirectory.DocumentDirectory,
                inDomains: NSSearchPathDomainMask.UserDomainMask).first as? NSURL
        }
    }


    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    func refreshFileList() {
        var error : NSError?
        self.documents = NSFileManager.defaultManager().contentsOfDirectoryAtURL(self.documentsFolderURL!, includingPropertiesForKeys: [NSURLNameKey], options: NSDirectoryEnumerationOptions.SkipsHiddenFiles, error: &error) as [NSURL]
        self.tableView.reloadData()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        refreshFileList()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject) {
        
        let fileName = "New Document \(Int(NSDate.timeIntervalSinceReferenceDate())).fancyDocument"
        
        if let fileURL = self.documentsFolderURL?.URLByAppendingPathComponent(fileName) {
            let newDocument = FancyDocument(fileURL: fileURL)
            
            newDocument.saveToURL(fileURL, forSaveOperation: UIDocumentSaveOperation.ForCreating, completionHandler: { (success) -> Void in
                self.refreshFileList()
                
            })
        }
        
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let URL = documents[indexPath.row] as NSURL
                
                
            (segue.destinationViewController as DetailViewController).documentURL = URL
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documents.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        let object = documents[indexPath.row] as NSURL
        cell.textLabel.text = object.lastPathComponent
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            let url = documents[indexPath.row]
            
            NSFileManager.defaultManager().removeItemAtURL(url, error: nil)
            
            self.refreshFileList()
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

