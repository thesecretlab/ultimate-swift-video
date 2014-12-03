//
//  ViewController.swift
//  CloudDocuments
//
//  Created by Jon Manning on 1/12/2014.
//  Copyright (c) 2014 Secret Lab. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    lazy var metadataQuery : NSMetadataQuery = {
        let query = NSMetadataQuery()
        
        query.searchScopes = [NSMetadataQueryUbiquitousDocumentsScope]
        
        let filePattern = "*.jpg"
        query.predicate = NSPredicate(format: "%K LIKE %@", NSMetadataItemFSNameKey, filePattern)
        
        return query
    }()
    
    var containerURL : NSURL?

    func checkiCloudAvailability( completion: Bool -> Void) {
        NSOperationQueue().addOperationWithBlock { () -> Void in
            self.containerURL = NSFileManager.defaultManager().URLForUbiquityContainerIdentifier(nil)
            
            if self.containerURL == nil {
                NSOperationQueue.mainQueue().addOperationWithBlock{ () -> Void in
                    completion(false)
                }
            } else {
                NSOperationQueue.mainQueue().addOperationWithBlock{ () -> Void in
                    completion(true)
                }
                
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add,
            target: self,
            action: "addPhoto:")
        
        self.navigationItem.rightBarButtonItem = addButton

        self.checkiCloudAvailability() { (completion) in
            
            if completion == false {
                addButton.enabled = false
            } else {
                self.metadataQuery.startQuery()
            }
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshFileList:", name: NSMetadataQueryDidUpdateNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshFileList:", name: NSMetadataQueryDidFinishGatheringNotification, object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func refreshFileList(notification : NSNotification) {
        
        // List through all discovered files, and begin downloading any that are not yet here
        
        self.metadataQuery.enumerateResultsUsingBlock { (item : AnyObject!, index : Int, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
            
            let metadataItem : NSMetadataItem = item as NSMetadataItem
            
            if self.isMetadataItemDownloaded(metadataItem) == false {
                
                let url = metadataItem.valueForAttribute(NSMetadataItemURLKey) as NSURL
                
                var error : NSError?
                
                NSFileManager.defaultManager().startDownloadingUbiquitousItemAtURL(url, error: &error)
                
                if let theError = error {
                    NSLog("Error downloading file at \(url): \(error)")
                }
            }
            
        }
        
        self.tableView.reloadData()
        
    }
    
    func isMetadataItemDownloaded(item : NSMetadataItem) -> Bool {
        if item.valueForAttribute(NSMetadataUbiquitousItemDownloadingStatusKey) as? NSString == NSMetadataUbiquitousItemDownloadingStatusCurrent {
            return true
        } else {
            return false
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.metadataQuery.resultCount
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        let result : NSMetadataItem = self.metadataQuery.resultAtIndex(indexPath.row) as NSMetadataItem
        
        // Mark the cell
        if self.isMetadataItemDownloaded(result) {
            cell.textLabel.textColor = UIColor.blackColor()
        } else {
            cell.textLabel.textColor = UIColor.lightGrayColor()
        }
        
        if let url = result.valueForAttribute(NSMetadataItemURLKey) as? NSURL {
            cell.textLabel.text = url.lastPathComponent
        } else {
            cell.textLabel.text = "Error finding file"
        }
        
        return cell
        
    }
    
    func addPhoto(sender : UIBarButtonItem) {
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        }
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as UIImage
        
        let fileName = "Image \(NSDate().timeIntervalSinceReferenceDate).jpg"
        
        // store in a temporary directory
        let temporaryURL =  NSURL(fileURLWithPath: NSTemporaryDirectory())?
            .URLByAppendingPathComponent(fileName)
        
        let imageData = UIImageJPEGRepresentation(image, 0.8)
        
        imageData.writeToURL(temporaryURL!, atomically: true)
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        NSOperationQueue().addOperationWithBlock { () -> Void in
            
            let destinationURL = self.containerURL?
                .URLByAppendingPathComponent("Documents")
                .URLByAppendingPathComponent(fileName)
            
            var error : NSError?
            
            NSFileManager.defaultManager().setUbiquitous(true, itemAtURL: temporaryURL!, destinationURL: destinationURL!, error: &error)
            
            if let theError = error {
                NSLog("Failed to make \(temporaryURL) ubiquitous: \(theError)")
            }
            
        }
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

