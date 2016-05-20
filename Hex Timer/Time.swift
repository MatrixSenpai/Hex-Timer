//
//  Time.swift
//  Hex Timer
//
//  Created by Mason Phillips on 200516.
//  Copyright © 2016 Matrix Studios. All rights reserved.
//

import UIKit
import AFDateHelper

class Time: NSObject {
    let currentTime: NSDate
    
    let hour: Int
    let minute: Int
    let second: Int
    
    override init() {
        currentTime = NSDate()
        
        hour = currentTime.hour()
        minute = currentTime.minute()
        second = currentTime.seconds()
        
        super.init()
    }
    
    func hourHex() -> String {
        return String(format: "0x%01X", hour)
    }
    
    func minuteHex() -> String {
        return String(format: "0x%01X", minute)
    }
    
    func secondHex() -> String {
        return String(format: "0x%01X", currentTime.seconds())
    }
}

extension String {
    func pad(length: Int) -> String {
        let diff = length - self.characters.count
        if diff > 0 {
            var padded = self
            for _ in 0..<diff {
                padded = "0" + padded
            }
            return padded
        } else {
            return self
        }
    }
}