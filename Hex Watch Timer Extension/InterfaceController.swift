//
//  InterfaceController.swift
//  Hex Watch Timer Extension
//
//  Created by Mason Phillips on 200516.
//  Copyright © 2016 Matrix Studios. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {

    @IBOutlet var titleLabel: WKInterfaceLabel!
    @IBOutlet var hourLabel: WKInterfaceLabel!
    @IBOutlet var minuteLabel: WKInterfaceLabel!
    @IBOutlet var secondLabel: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        titleLabel.setText("Time (Hex)")
        
        let time = NSDate()
//        let h = String(format: "0x%02X", time.hour())
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
