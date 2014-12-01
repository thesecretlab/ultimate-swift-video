//
//  ViewController.swift
//  Undo
//
//  Created by Jon Manning on 21/11/2014.
//  Copyright (c) 2014 Secret Lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var draggableView: UIView!
    
    @IBAction func undo(sender: AnyObject) {
        self.undoManager?.undo()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func moveToPosition(position : NSValue) {
        draggableView.center = position.CGPointValue()
    }
    
    @IBAction func dragged(sender: UIPanGestureRecognizer) {
        
        if sender.state == .Began {
            self.undoManager?.registerUndoWithTarget(self, selector: "moveToPosition:", object: NSValue(CGPoint: self.draggableView.center))
            
        } else if sender.state == .Changed {
            var oldPosition = self.draggableView.center
            var newPosition = sender.translationInView(sender.view!)
            
            newPosition.x += oldPosition.x
            newPosition.y += oldPosition.y
            
            self.draggableView.center = newPosition
            
            sender.setTranslation(CGPoint.zeroPoint, inView: sender.view)
        }
        
    }

}

