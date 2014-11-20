//
//  ViewController.swift
//  MusicPlayer
//
//  Created by Jon Manning on 20/11/2014.
//  Copyright (c) 2014 Secret Lab. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController {
    
    let player = MPMusicPlayerController.iPodMusicPlayer()
    
    var nowPlayingItemDidChangeObserver : AnyObject?

    @IBOutlet weak var nowPlayingTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        player.beginGeneratingPlaybackNotifications()
        
        self.nowPlayingItemDidChangeObserver = NSNotificationCenter.defaultCenter().addObserverForName(
            MPMusicPlayerControllerNowPlayingItemDidChangeNotification,
            object: nil,
            queue: NSOperationQueue.mainQueue()) { (notification) -> Void in
            self.updateNowPlayingItem()
        }
        
    }
    
    func updateNowPlayingItem() {
        let nowPlayingItem = player.nowPlayingItem
        
        let nowPlayingTitle = nowPlayingItem.title
        
        self.nowPlayingTitleLabel.text = nowPlayingTitle
    }

    @IBAction func goBack(sender: AnyObject) {
        player.skipToNextItem()
    }
    
    @IBAction func goForward(sender: AnyObject) {
        player.skipToNextItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

