//
//  ExtensionDelegate.swift
//  Hex Watch Timer Extension
//
//  Created by Mason Phillips on 200516.
//  Copyright © 2016 Matrix Studios. All rights reserved.
//

import WatchKit
import Pods_Hex_Watch_Timer

class ExtensionDelegate: NSObject, WKExtensionDelegate {

    func applicationDidFinishLaunching() {
        // Perform any final initialization of your application.
        let time = NSDate()
        
    }

    func applicationDidBecomeActive() {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillResignActive() {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, etc.
    }

}
