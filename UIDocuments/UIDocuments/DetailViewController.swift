//
//  DetailViewController.swift
//  UIDocuments
//
//  Created by Jon Manning on 21/11/2014.
//  Copyright (c) 2014 Secret Lab. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    var documentURL : NSURL?
    
    @IBOutlet weak var detailDescriptionLabel: UILabel!

    @IBOutlet weak var stepper: UIStepper!

    var document: FancyDocument? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        if let label = self.detailDescriptionLabel {
            label.text = "\(document?.number ?? 0)"
        }
        
        if let stepper = self.stepper {
            stepper.value = Double(document?.number ?? 0)
        }
    
    }

    @IBAction func stepperChangedValue(sender: AnyObject) {
        
        if let stepper = self.stepper {
            let number = Int(stepper.value)
            
            document?.number = number
            
            document?.updateChangeCount(UIDocumentChangeKind.Done)
            
            configureView()
        }
    
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let url = self.documentURL {
            document = FancyDocument(fileURL: url)
            
            document?.openWithCompletionHandler() { (success) -> Void in
                
                self.configureView()
                
            }
        }
       
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

