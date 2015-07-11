//
//  InterfaceController.swift
//  Surround-iOS WatchKit Extension
//
//  Created by Calvin on 7/9/15.
//  Copyright (c) 2015 Calvin. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var redbutton: WKInterfaceButton!
    @IBOutlet weak var greenbutton: WKInterfaceButton!
    @IBOutlet weak var bluebutton: WKInterfaceButton!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    //sends blue to the parent app
    @IBAction func blueButtonPressed()
    {
        openParentApp("blue")
    }
    
    //sends green to the parent app
    @IBAction func greenButtonPressed()
    {
        openParentApp("green")
    }
    
    //sends red to the parent app
    @IBAction func redButtonPressed()
    {
        openParentApp("red")
    }
    
    //sends the data to the parent app. sent data is a dict [NSObject : AnyObject], the reply is in the same form
    private func openParentApp(color : String)
    {
        WKInterfaceController.openParentApplication(["color" : color], reply: nil)
    }
}
