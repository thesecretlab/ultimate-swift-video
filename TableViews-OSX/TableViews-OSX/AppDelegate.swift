//
//  AppDelegate.swift
//  TableViews-OSX
//
//  Created by Jon Manning on 18/11/2014.
//  Copyright (c) 2014 Secret Lab. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSTableViewDataSource, NSTableViewDelegate {

    @IBOutlet weak var window: NSWindow!
    
    let tableData = [
         ("Gaeta's Lament", 289),
         ("The Signal", 309),
         ("Resurrection Hub", 221),
         ("The Cult of Baltar", 342)
    ]

    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        var textView = tableView.makeViewWithIdentifier(tableColumn!.identifier, owner: self) as NSTableCellView
        
        let song = tableData[row]
        
        switch (tableColumn!.identifier) {
            case "Title":
                textView.textField?.stringValue = song.0
            
            case "Duration":
                textView.textField?.stringValue = NSString(format: "%i:%02i", song.1 / 60, song.1 % 60)
            
            default:
                textView.textField?.stringValue = ""
        }
        
        return textView
    }

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

