//
//  StreamViewController.swift
//  Surround-iOS
//
//  Created by Calvin on 7/4/15.
//  Copyright (c) 2015 Calvin. All rights reserved.
//

import Foundation
import UIKit

class StreamView : UIView, VLCMediaPlayerDelegate
{
    //VLC Media player object this runs all the streams
    var mediaPlayer : VLCMediaPlayer!
    //the title string for now just set to the url of the stream
    var title : String!
    
    
    //var button : UIButton!
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    
    init(frame : CGRect, url : NSURL, tag : Int)
    {
        super.init(frame: frame)
        self.userInteractionEnabled = false
        self.tag = tag
        self.title = url.absoluteString
        createStream(url)
        
        //for some reason I can't get labels to add to the custom view, probably some subviewing problem. You can just add stuff on the view controller which works, but is way more cluncky
        //addTitle()
        //createButton(frame)
        
        
    }
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //creates the stream
    private func createStream(url : NSURL)
    {
        mediaPlayer = VLCMediaPlayer()
        self.mediaPlayer.delegate = self
        
        //VERY IMPORTANT STEP THIS ACTUALLY ADDS THE VIDEO TO THE VIEW, VLCVIDEOVIEW DOES NOT EXIST
        self.mediaPlayer.drawable = self
        self.mediaPlayer.media = VLCMedia(URL: url)
        self.mediaPlayer.play()
        println("playing")
    }
    
//    
//    func addTitle()
//    {
//        var titleLabel = UILabel(frame: CGRectMake(frame.midX, frame.minY, frame.width/4, frame.height/8))
//        titleLabel.text = title
//        self.addSubview(titleLabel)
//    }
//    
    
//    func createButton(frame : CGRect)
//    {
//        println("creating button")
//        button = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
//        button.setTitle("", forState: UIControlState.Normal)
//        button.userInteractionEnabled = true
//        button.addTarget(self, action:  "buttonPress:", forControlEvents: UIControlEvents.TouchUpInside)
//        button.backgroundColor = UIColor.purpleColor()
//        button.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)
//        println(button.frame)
//        self.addSubview(button)
//        println("added \(button)")
//    
//    }
//
    
    
    
}
