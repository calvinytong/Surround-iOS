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
    
    var redbutton = UIButton()
    var bluebutton = UIButton()
    var greenbutton = UIButton()
    
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
            self.drawButtons()
            self.button1.tag = 1
            
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
        var orientation = UIDevice.currentDevice().orientation
        
        if orientation == UIDeviceOrientation.LandscapeLeft || orientation == UIDeviceOrientation.LandscapeRight
        {
            circlebuttonsize = (self.view.bounds.height / 4) * (2/3) as CGFloat
        }
        else
        {
            circlebuttonsize = (self.view.bounds.width / 4) * (2/3) as CGFloat
        }
        
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
        
        //color for debug
        //button.backgroundColor = UIColor.purpleColor()
        
        self.view.addSubview(button)
        //println("button created \(button)")
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
    
    //draws a colored circular button at pos xcoor, ycoor
    private func makeColoredButton(button : UIButton, action : Selector, color : UIColor, xcoor : CGFloat, ycoor : CGFloat)
    {
        
        button.frame = CGRectMake(xcoor, ycoor, circlebuttonsize, circlebuttonsize)
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.backgroundColor = color
        button.addTarget(self, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
        
        //only blurs in the square frame can't seem to get it to blur a circle
//        let blur = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Light))
//        blur.frame = button.frame
//        blur.layer.cornerRadius = 0.5 * button.bounds.size.width
//        self.view.addSubview(blur)
        
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
            view.frame = streamviewframe
            self.view.addSubview(view)
            drawButtons()
        }
    }
    
    //draws the circular buttons at the bottom of the screen
    private func drawButtons()
    {
        let middlebuttonx : CGFloat = self.view.bounds.width / 2 - circlebuttonsize / 2
        let circlebuttony : CGFloat = (self.view.bounds.height / 4) * 3 + circlebuttonsize / 4
        
        makeColoredButton(redbutton, action: "redButtonPressed", color: UIColor.redColor(), xcoor:  middlebuttonx - 2 * circlebuttonsize, ycoor: circlebuttony)
        makeColoredButton(bluebutton, action: "blueButtonPressed", color: UIColor.blueColor(), xcoor: middlebuttonx, ycoor: circlebuttony)
        makeColoredButton(greenbutton, action: "greenButtonPressed", color: UIColor.greenColor(), xcoor: middlebuttonx + 2 * circlebuttonsize, ycoor: circlebuttony)

    }
    
    //function called when the red button is pressed
    func redButtonPressed()
    {
        //add code for red button here
        println("red pressed")
//        sc.socket.emit("change color", 1.0, 0.0, 0.0)
    }
    
    //function called when the blue button is pressed
    func blueButtonPressed()
    {
        //add code for blue button here
        println("blue pressed")
//        sc.socket.emit("change color", 0.0, 0.0, 1.0)
    }
    
    //function called when the green button is pressed
    func greenButtonPressed()
    {
        //add code for green button here
        println("green pressed")
//        sc.socket.emit("change color", 0.0, 1.0, 0.0)
    }
    
    //function for handling the notification from the watch. unpacks the sent message and then runs a switch to determine which method to run
    func watchNotification(notification : NSNotification)
    {
        //println("hi from instide the notification")
        var color = notification.object as! String
        switch(color)
        {
            case "red":
                redButtonPressed()
            case "blue":
                blueButtonPressed()
            case "green":
                greenButtonPressed()
            default:
                return
            //shouldn't happen but who knows
        }
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
        drawButtons()
    }

}