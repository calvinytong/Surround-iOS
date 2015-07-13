//
//  ControlView.swift
//  Surround-iOS
//
//  Created by Calvin on 7/10/15.
//  Copyright (c) 2015 Calvin. All rights reserved.
//

//  TODO- MAKE COLORED BUTTONS INTO A CUSTOM VIEW SO WE CAN MAKE IT LOOK COOLER

import Foundation
import UIKit
import Socket_IO_Client_Swift
class ControlView : UIView
{
    var redbutton : UIButton!
    var bluebutton : UIButton!
    var greenbutton : UIButton!
    
    var circlebuttonsize : CGFloat! //= (self.view.bounds.height / 4 - 10) * (2/3) as CGFloat can't assign up here even though I would like to

    var sc = SocketClient()

    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        sizeView()
        self.redbutton = UIButton()
        self.bluebutton = UIButton()
        self.greenbutton = UIButton()
        drawButtons()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "orientationChanged", name: UIDeviceOrientationDidChangeNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "watchNotification:", name: "watchNotification", object: nil)
    }
    
    override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
        for subview in subviews as! [UIView] {
            if !subview.hidden && subview.alpha > 0 && subview.userInteractionEnabled && subview.pointInside(convertPoint(point, toView: subview), withEvent: event) {
                return true
            }
        }
        return false
    }
    
    func redrawView()
    {
        sizeView()
        drawButtons()
    }
    
    
    private func drawButtons()
    {
        let middlebuttonx : CGFloat = UIScreen.mainScreen().bounds.size.width / 2 - circlebuttonsize / 2
        let circlebuttony : CGFloat = (UIScreen.mainScreen().bounds.size.height / 4) * 3 + circlebuttonsize / 4
        
        makeColoredButton(redbutton, action: "redButtonPressed", color: UIColor.redColor(), xcoor:  middlebuttonx - 2 * circlebuttonsize, ycoor: circlebuttony)
        makeColoredButton(bluebutton, action: "blueButtonPressed", color: UIColor.blueColor(), xcoor: middlebuttonx, ycoor: circlebuttony)
        makeColoredButton(greenbutton, action: "greenButtonPressed", color: UIColor.greenColor(), xcoor: middlebuttonx + 2 * circlebuttonsize, ycoor: circlebuttony)
        
    }
    
    //draws a colored circular button at pos xcoor, ycoor
    private func makeColoredButton(button : UIButton, action : Selector, color : UIColor, xcoor : CGFloat, ycoor : CGFloat)
    {
        
        button.frame = CGRectMake(xcoor, ycoor, circlebuttonsize, circlebuttonsize)
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.backgroundColor = color
        button.addTarget(self, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(button)
        
        //only blurs in the square frame can't seem to get it to blur a circle
        //        let blur = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Light))
        //        blur.frame = button.frame
        //        blur.layer.cornerRadius = 0.5 * button.bounds.size.width
        //        self.view.addSubview(blur)
        
    }
    
    //function called when the red button is pressed
    func redButtonPressed()
    {
        //add code for red button here
        println("red pressed")
        sc.socket.emit("change color", 1.0, 0.0, 0.0)
    }
    
    //function called when the blue button is pressed
    func blueButtonPressed()
    {
        //add code for blue button here
        println("blue pressed")
        sc.socket.emit("change color", 0.0, 0.0, 1.0)
    }
    
    //function called when the green button is pressed
    func greenButtonPressed()
    {
        //add code for green button here
        println("green pressed")
        sc.socket.emit("change color", 0.0, 1.0, 0.0)
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
    
    private func sizeView()
    {
        println("sizing view")
        var orientation = UIDevice.currentDevice().orientation
        var bounds = UIScreen.mainScreen().bounds
        var width = bounds.size.width
        var height = bounds.size.height
        if orientation == UIDeviceOrientation.LandscapeLeft || orientation == UIDeviceOrientation.LandscapeRight
        {
            circlebuttonsize = (height / 4) * (2/3) as CGFloat
        }
        else
        {
            circlebuttonsize = (width / 4) * (2/3) as CGFloat
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
    
    
    

    
}
