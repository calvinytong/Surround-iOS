////
////  ControlView.swift
////  Surround-iOS
////
////  Created by Calvin on 7/10/15.
////  Copyright (c) 2015 Calvin. All rights reserved.
////

//  TODO- MAKE COLORED BUTTONS INTO A CUSTOM VIEW SO WE CAN MAKE IT LOOK COOLER
//
//import Foundation
//import UIKit
//
//class ControlView : UIView
//{
//    var redbutton : UIButton
//    var bluebutton : UIButton
//    var greenbutton : UIButton
//    
//    required init(coder aDecoder: NSCoder)
//    {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override init(frame: CGRect)
//    {
//        super.init(frame: frame)
//        
//
//    }
//    
//    
//    func drawButton()
//    {
//        
//    }
//    
//    private func drawButtons()
//    {
//        let middlebuttonx : CGFloat = self.bounds.width / 2 - circlebuttonsize / 2
//        let circlebuttony : CGFloat = (self.bounds.height / 4) * 3 + circlebuttonsize / 4
//        
//        makeColoredButton(redbutton, action: "redButtonPressed", color: UIColor.redColor(), xcoor:  middlebuttonx - 2 * circlebuttonsize, ycoor: circlebuttony)
//        makeColoredButton(bluebutton, action: "blueButtonPressed", color: UIColor.blueColor(), xcoor: middlebuttonx, ycoor: circlebuttony)
//        makeColoredButton(greenbutton, action: "greenButtonPressed", color: UIColor.greenColor(), xcoor: middlebuttonx + 2 * circlebuttonsize, ycoor: circlebuttony)
//        
//    }
//    
//    //draws a colored circular button at pos xcoor, ycoor
//    private func makeColoredButton(button : UIButton, action : Selector, color : UIColor, xcoor : CGFloat, ycoor : CGFloat)
//    {
//        
//        button.frame = CGRectMake(xcoor, ycoor, circlebuttonsize, circlebuttonsize)
//        button.layer.cornerRadius = 0.5 * button.bounds.size.width
//        button.backgroundColor = color
//        button.addTarget(self, action: action, forControlEvents: UIControlEvents.TouchUpInside)
//        self.addSubview(button)
//        
//        //only blurs in the square frame can't seem to get it to blur a circle
//        //        let blur = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Light))
//        //        blur.frame = button.frame
//        //        blur.layer.cornerRadius = 0.5 * button.bounds.size.width
//        //        self.view.addSubview(blur)
//        
//    }
//    
//}
