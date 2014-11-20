//
//  ViewController.swift
//  ScrollViews
//
//  Created by Jon Manning on 20/11/2014.
//  Copyright (c) 2014 Secret Lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Make a label that's way off-screen
        let labelFrame = CGRect(x: 20, y: 1000, width: 300, height: 50)
        let label = UILabel(frame: labelFrame)
        label.text = "Hello!"
        
        // Add the label
        self.scrollView.addSubview(label)
        
        // Set the content size
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.width, height: self.scrollView.frame.height * 4)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

