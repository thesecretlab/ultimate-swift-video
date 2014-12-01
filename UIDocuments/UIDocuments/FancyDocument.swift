//
//  FancyDocument.swift
//  UIDocuments
//
//  Created by Jon Manning on 21/11/2014.
//  Copyright (c) 2014 Secret Lab. All rights reserved.
//

import UIKit

class FancyDocument: UIDocument {
    
    var number : Int = 0
   
    override func loadFromContents(contents: AnyObject, ofType typeName: String, error outError: NSErrorPointer) -> Bool {
        
        let dataToLoad = contents as NSData
        
        let loadedString = NSString(data: dataToLoad, encoding: NSUTF8StringEncoding)
        
        number = loadedString?.integerValue ?? 0
        
        return true
        
    }
    
    override func contentsForType(typeName: String, error outError: NSErrorPointer) -> AnyObject? {
        
        let numberAsString = "\(number)"
        let data = numberAsString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        
        return data
        
    }
    
}
