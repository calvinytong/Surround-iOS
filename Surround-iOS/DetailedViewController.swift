//
//  DetailedViewController.swift
//  Surround-iOS
//
//  Created by Calvin on 7/7/15.
//  Copyright (c) 2015 Calvin. All rights reserved.
//

import Foundation
import UIKit

class DetailedViewController : UIViewController
{
    //the view passed from the streamview
    var detailedView : StreamView!
    var backButton : UIBarButtonItem!
    
    //inits the back button and the title
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "back")
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.title = detailedView.title
    }
    
    //sets up the view
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //changes the frame of the view to be full screen and redraws it
    func setupView()
    {
        detailedView.frame = self.view.bounds
        self.view.addSubview(detailedView)
    }
    
    //performs the unwind when the back button is pressed
    func back()
    {
        self.performSegueWithIdentifier("unwindToNormalView", sender: self)
    }
}