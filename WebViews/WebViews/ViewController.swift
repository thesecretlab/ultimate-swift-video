//
//  ViewController.swift
//  WebViews
//
//  Created by Jon Manning on 20/11/2014.
//  Copyright (c) 2014 Secret Lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    
    
    @IBAction func goBack(sender: AnyObject) {
        self.webView.goBack()
    }
    
    @IBAction func goForward(sender: AnyObject) {
        self.webView.goBack()
    }
    
    @IBAction func reload(sender: AnyObject) {
        self.webView.reload()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let url = NSURL(string: "http://www.oreilly.com") {
            
            let request = NSURLRequest(URL: url)
            
            self.webView.loadRequest(request)
        }
        
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        
        self.backButton.enabled = self.webView.canGoBack
        self.forwardButton.enabled = self.webView.canGoForward
        
    }
    
    @IBAction func runJavaScript(sender: AnyObject) {
        self.webView.stringByEvaluatingJavaScriptFromString("alert('Hello!')");
        
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        if navigationType == UIWebViewNavigationType.LinkClicked {
            
            UIApplication.sharedApplication().openURL(request.URL)
            
            return false
            
        }
        
        return true
        
    }
    


}

