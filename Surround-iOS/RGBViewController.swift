//
//  RGBViewController.swift
//  Surround-iOS
//
//  Created by Calvin on 7/9/15.
//  Copyright (c) 2015 Calvin. All rights reserved.
//

import Foundation
import UIKit
import Socket_IO_Client_Swift

class RGBViewController : UIViewController
{
    var streamview : StreamView!
    private var streamviewframe : CGRect!
    var button1 : UIButton = UIButton()
    
    var redbutton : UIButton = UIButton()
    var bluebutton : UIButton = UIButton()
    var greenbutton : UIButton = UIButton()
    
    var cv : ControlView!
    
    var buttonsDisplayed : Bool = true
    
    var sc = SocketClient()
    
    private var testURL : NSURL!
    
    var circlebuttonsize : CGFloat! //= (self.view.bounds.height / 4 - 10) * (2/3) as CGFloat can't assign up here even though I would like to
    
    //viewDidLoad method to do initial screen setup
    override func viewDidLoad()
    {
        //        sc.connect({(success: Bool!, error: NSError!) -> Void in
        //        if success == true
        //        {
        //            self.testURL = NSURL(string: self.sc.url)
        
        
        self.testURL = NSURL(string: "rtsp://184.72.239.149/vod/mp4:BigBuckBunny_175k.mov")
        self.sizeView()
        self.startStream()
        buttonsDisplayed = true
        self.button1.tag = 1
        cv = ControlView(frame: self.view.bounds)
        self.view.addSubview(cv)
        //listens to the device orientation, runs orientationChanged when the device is flipped
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "orientationChanged", name: UIDeviceOrientationDidChangeNotification, object: nil)
        
        //listens to watchNotifications, runs watchNotification when the device is flipped
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "watchNotification:", name: "watchNotification", object: nil)
        //
        //            }
        //        })
    }
    
    
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
    
    //remove the observers when the view disappears
    override func viewDidDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //creates the sizes for each of the aspects of the view so the device can be flipped
    private func sizeView()
    {
        streamviewframe = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height)
    }
    
    //starts the stream by creating a streamview and drawing a button behind it
    private func startStream()
    {
        streamview = StreamView(frame: streamviewframe, url: testURL, tag: 5)
        makeButton(button1, frame: streamview.frame)
        self.view.addSubview(streamview)
    }
    
    //draws an invisible button with size frame
    private func makeButton(button : UIButton, frame : CGRect)
    {
        button.frame = frame
        button.userInteractionEnabled = true
        button.addTarget(self, action:  "buttonPress:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
        //println("button created \(button)")
    }
    
    //the button pressed method, called when one of the buttons is pressed, preforms a segue to a detailed view and passes it the view that was pressed
    func buttonPress(sender : UIButton)
    {
        println("pressed")
        showHideControlView()
        //the button and view tags both live in the same namespace so 5,6,7,8 for tags on the views
        //        var view : StreamView = self.view.viewWithTag(sender.tag + 4) as! StreamView
        //        performSegueWithIdentifier("showDetailedView", sender: view)
    }


    
    //function called when the device changes orientation
    func orientationChanged()
    {
        if(UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation))
        {
            redrawView()
        }
        
        if(UIDeviceOrientationIsPortrait(UIDevice.currentDevice().orientation))
        {
            redrawView()
        }
        
    }
    
    //redraws the view when the orientation changes
    private func redrawView()
    {
        sizeView()
        streamview.frame = streamviewframe
    }
    
    private func showHideControlView()
    {
        if buttonsDisplayed
        {
            cv.removeFromSuperview()
            buttonsDisplayed = false
        }
        else
        {
            self.view.addSubview(cv)
            buttonsDisplayed = true
        }
    }
    
    
    
    //prepares the view for a segue, handles passing the pressed view to the new view controller
    //    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    //        if (segue.identifier == "showDetailedView")
    //        {
    //            var vc : DetailedViewController = segue.destinationViewController as! DetailedViewController
    //            vc.detailedView = sender as! StreamView
    //            println(vc.detailedView)
    //        }
    //    }
    
    //prepares for the unwind from the detailed view to the normal view. Redraws the view in the correct frame depending on the tag of the view that was passed back
    //    @IBAction func prepareForUnwind(segue : UIStoryboardSegue)
    //    {
    //        if segue.identifier == "unwindToNormalView"
    //        {
    //            var vc = segue.sourceViewController as! DetailedViewController
    //            var view : StreamView = vc.detailedView as StreamView
    //            view.frame = streamviewframe
    //            self.view.addSubview(view)
    //            drawButtons()
    //        }
    //    }

    
}