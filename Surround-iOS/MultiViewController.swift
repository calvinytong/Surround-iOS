//
//  MultiViewController.swift
//  Surround-iOS
//
//  Created by Calvin on 7/2/15.
//  Copyright (c) 2015 Calvin. All rights reserved.
//

import UIKit

class MultiViewController: UIViewController {
    
    @IBOutlet weak var StartStreamButton: UIButton!
    
    //var button : UIButton!
    
    //actual xiaoyiurls
    private let XiaoYiURL = NSURL(string : "rtsp://10.0.100.50/live")!
    private let XiaoYiURL2 = NSURL(string: "rtsp://10.0.100.51/live")!
    private let XiaoYiURL3 = NSURL(string: "rtsp://10.0.100.52/live")!
    
    var button1 : UIButton = UIButton()
    var button2 : UIButton = UIButton()
    var button3 : UIButton = UIButton()
    var button4 : UIButton = UIButton()
    
    var vc1 : StreamView!
    var vc2 : StreamView!
    var vc3 : StreamView!
    var vc4 : StreamView!
    
    var vc1frame : CGRect!
    var vc2frame : CGRect!
    var vc3frame : CGRect!
    var vc4frame : CGRect!
    
    //test url from the interwebs just a bunny vid
    let testURL = NSURL(string : "rtsp://184.72.239.149/vod/mp4:BigBuckBunny_175k.mov")!
    
    var mediaPlayer : VLCMediaPlayer!
    
    //make the navigation controller bar translucent
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
    }
    
    //make the navigation controller bar reappear
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = nil
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set bounds on the custom views
        vc1frame = CGRectMake(0, 0, self.view.bounds.width / 2, self.view.bounds.height / 2)
        vc2frame = CGRectMake(self.view.bounds.width / 2, 0, self.view.bounds.width / 2, self.view.bounds.height / 2)
        vc3frame = CGRectMake(0, self.view.bounds.height / 2, self.view.bounds.width / 2, self.view.bounds.height / 2)
        vc4frame = CGRectMake(self.view.bounds.width / 2, self.view.bounds.height / 2, self.view.bounds.width / 2, self.view.bounds.height / 2)
        
        //start stream by initializing the custom views and drawing the buttons behind them
        StartStream()
        
        //create button tags to help better reference them later
        button1.tag = 1
        button2.tag = 2
        button3.tag = 3
        button4.tag = 4
        
        //println(self.view.bounds)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //set up 4 different stream views and then add them to the subview
    private func StartStream()
    {
        var vc1 = StreamView(frame: vc1frame, url: testURL, tag: 5)
        makeButton(button1, frame: vc1frame)
        
        var vc2 = StreamView(frame: vc2frame, url: testURL, tag: 6)
        makeButton(button2, frame: vc2frame)
        
        var vc3 = StreamView(frame: vc3frame, url: testURL, tag: 7)
        makeButton(button3, frame: vc3frame)
        
        var vc4 = StreamView(frame: vc4frame, url : testURL, tag: 8)
        makeButton(button4, frame: vc4frame)
        
        self.view.addSubview(vc1)
        self.view.addSubview(vc2)
        self.view.addSubview(vc3)
        self.view.addSubview(vc4)
    }
    
    //the button pressed method, called when one of the buttons is pressed, preforms a segue to a detailed view and passes it the view that was pressed
    func buttonPress(sender : UIButton)
    {
        //the button and view tags both live in the same namespace so 5,6,7,8 for tags on the views
        var view : StreamView = self.view.viewWithTag(sender.tag + 4) as! StreamView
        //println("buttonPressed \(sender.tag)")
        //println(view)
        performSegueWithIdentifier("showDetailedView", sender: view)
    }
    
    //draws an invisible button at the frame that is passed in. to-do make the buttons draw in view to make this cleaner
    private func makeButton(button : UIButton, frame : CGRect)
    {
        button.frame = frame
        button.userInteractionEnabled = true
        button.addTarget(self, action:  "buttonPress:", forControlEvents: UIControlEvents.TouchUpInside)
        
        //color for debug
        //button.backgroundColor = UIColor.purpleColor()
        
        self.view.addSubview(button)
        //println("button created \(button)")
    }
    
    //prepares the view for a segue, handles passing the pressed view to the new view controller
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showDetailedView")
        {
            var vc : DetailedViewController = segue.destinationViewController as! DetailedViewController
            vc.detailedView = sender as! StreamView
            println(vc.detailedView)
        }
    }
    
    //prepares for the unwind from the detailed view to the normal view. Redraws the view in the correct frame depending on the tag of the view that was passed back
    @IBAction func prepareForUnwind(segue : UIStoryboardSegue)
    {
        if segue.identifier == "unwindToNormalView"
        {
            var vc = segue.sourceViewController as! DetailedViewController
            var view : StreamView = vc.detailedView as StreamView
            switch(view.tag)
            {
            case 5:
                view.frame = vc1frame
            case 6:
                view.frame = vc2frame
            case 7:
                view.frame = vc3frame
            case 8:
                view.frame = vc4frame
            default:
                //should never happen
                return
            }
            self.view.addSubview(view)
        }
    }
    
    
}

