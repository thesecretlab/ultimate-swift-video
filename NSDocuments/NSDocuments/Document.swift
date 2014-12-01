//
//  Document.swift
//  NSDocuments
//
//  Created by Jon Manning on 21/11/2014.
//  Copyright (c) 2014 Secret Lab. All rights reserved.
//

import Cocoa

class Document: NSDocument {
    
    @IBOutlet weak var textField: NSTextField!
    
    @IBOutlet weak var checkbox: NSButton!
    
    var text = ""
    var checked = false

    override init() {
        super.init()
    }

    override func windowControllerDidLoadNib(aController: NSWindowController) {
        super.windowControllerDidLoadNib(aController)
        // Add any code here that needs to be executed once the windowController has loaded the document's window.
        
        self.textField.stringValue = self.text
        self.checkbox.integerValue = Int(self.checked)
    }

    override class func autosavesInPlace() -> Bool {
        return true
    }

    override var windowNibName: String? {
        return "Document"
    }

    override func dataOfType(typeName: String, error outError: NSErrorPointer) -> NSData? {
        self.text = self.textField.stringValue
        self.checked = Bool(self.checkbox.integerValue)
        
        let dictionary = ["checked": self.checked,
            "text": self.text]
        
        var error : NSError? = nil
        
        let serializedData = NSJSONSerialization.dataWithJSONObject(dictionary,
            options: NSJSONWritingOptions.PrettyPrinted, error: &error)
        
        if serializedData == nil || error != nil {
            
            outError.memory = error
            
            return nil;
        } else {
            return serializedData
        }
    }

    override func readFromData(data: NSData, ofType typeName: String, error outError: NSErrorPointer) -> Bool {
        var error : NSError? = nil
        
        let data = NSJSONSerialization.JSONObjectWithData(data,
            options: NSJSONReadingOptions(), error: &error) as? NSDictionary
        
        if data == nil || error != nil {
            outError.memory = error
            return false
        }
        
        if let text = data!["text"] as? String {
            self.text = text
        }
        
        if let checked = data!["checked"] as? Bool {
            self.checked = checked
        }
        
        return true
    }


}

