//
//  mainViewController.swift
//  Hex Timer
//
//  Created by Mason Phillips on 200516.
//  Copyright © 2016 Matrix Studios. All rights reserved.
//

import UIKit
import Neon
import SwiftyTimer
import ChameleonFramework
import FontAwesome_swift
import DKChainableAnimationKit

class mainViewController: UIViewController, UITabBarDelegate {
    
    let titleLabel: UILabel = UILabel()
    
    var hourLabel: UILabel!
    var hourBack: UILabel!
    
    var minLabel: UILabel!
    var minBack: UILabel!
    
    var secLabel: UILabel!
    var secBack: UILabel!
    
    var globalTimer: NSTimer!
    
    var timeTypeSettings: UITabBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.font = UIFont.systemFontOfSize(40)
        titleLabel.textAlignment = .Center
        titleLabel.textColor = FlatGray()
        view.addSubview(titleLabel)

        // Hour Setup
        hourLabel = initLabelWithData()
        view.addSubview(hourLabel)
        hourBack = initBackupLabelWithData()
        view.insertSubview(hourBack, belowSubview: hourLabel)

        // Minute Setup
        minLabel = initLabelWithData()
        view.addSubview(minLabel)
        minBack = initBackupLabelWithData()
        view.insertSubview(minBack, belowSubview: minLabel)
        
        // Second Setup
        secLabel = initLabelWithData()
        view.addSubview(secLabel)
        secBack = initBackupLabelWithData()
        view.insertSubview(secBack, belowSubview: secLabel)
        
        // Other view parts
        view.backgroundColor = FlatBlackDark()
        
        // Tab bar
        let normal = UIImage.fontAwesomeIconWithName(.ClockO, textColor: .blackColor(), size: CGSizeMake(20, 20))
        let select = UIImage.fontAwesomeIconWithName(.CircleO, textColor: .blackColor(), size: CGSizeMake(20, 20))
        
        let bin = UITabBarItem(title: "b2", image: normal, selectedImage: select)
        let oct = UITabBarItem(title: "b8", image: normal, selectedImage: select)
        let dec = UITabBarItem(title: "b10", image: normal, selectedImage: select)
        let hex = UITabBarItem(title: "b16", image: normal, selectedImage: select)

        timeTypeSettings = UITabBar()
        timeTypeSettings.items = [bin, oct, dec, hex]
        timeTypeSettings.delegate = self
        timeTypeSettings.selectedItem = hex
        view.addSubview(timeTypeSettings)
        
        // Add tap-to-hide functionality to tab bar
//        let tg = UITapGestureRecognizer(target: self, action: #selector(mainViewController.toggleTabBar))
//        view.addGestureRecognizer(tg)
        
        // Init clock
        switchClock(.Hexadecimal)
    }
    
    func initLabelWithData() -> UILabel {
        // Initial label setup
        let lbl = UILabel()
        lbl.backgroundColor = .clearColor()
        lbl.textColor = FlatGrayDark()
        lbl.textAlignment = .Center

        return lbl
    }
    
    func initBackupLabelWithData() -> UILabel {
        // Initial backup label setup
        let bl = UILabel()
        
        bl.backgroundColor = .clearColor()
        bl.textAlignment = .Center
        bl.textColor = UIColor(colorLiteralRed: 153/255, green: 0, blue: 0, alpha: 0.7)
        
        return bl
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        let isRot = (UIDevice.currentDevice().orientation == .Portrait)
        let width: CGFloat = ((isRot) ? 100 : 150)
        let height: CGFloat = ((isRot) ? 100 : 90)
        
        minBack.anchorInCenter(width: width, height: height)
        hourBack.align(.ToTheLeftCentered, relativeTo: minLabel, padding: 5, width: width, height: height)
        secBack.align(.ToTheRightCentered, relativeTo: minLabel, padding: 5, width: width, height: height)
        
        minLabel.anchorInCenter(width: width, height: height)
        hourLabel.align(.ToTheLeftCentered, relativeTo: minLabel, padding: 5, width: width, height: height)
        secLabel.align(.ToTheRightCentered, relativeTo: minLabel, padding: 5, width: width, height: height)

        titleLabel.alignAndFillWidth(align: .AboveCentered, relativeTo: minLabel, padding: 10, height: 60)
        
        timeTypeSettings.anchorAndFillEdge(.Bottom, xPad: 0, yPad: 0, otherSize: 50)
    }
    
    func updateClock(type t: TimeType) -> Void {
        let time = NSDate()

        switch t {
        case .Binary:
            secLabel.text = String(time.seconds(), radix: 2).pad(6)
            minLabel.text = String(time.minute(), radix: 2).pad(6)
            hourLabel.text = String(time.hour(), radix: 2).pad(4)
            hourBack.text = "0000"
            minBack.text = "000000"
            secBack.text = "000000"
            break
        case .Octal:
            secLabel.text = String(format: "%02Ob8", time.seconds())
            minLabel.text = String(format: "%02Ob8", time.minute())
            hourLabel.text = String(format: "%02Ob8", time.hour())
            hourBack.text = "00b8"
            minBack.text = "00b8"
            secBack.text = "00b8"
            break
        case .Decimal:
            secLabel.text = String(format: "%02d", time.seconds())
            minLabel.text = String(format: "%02d", time.minute())
            hourLabel.text = String(format: "%02d", time.hour())
            hourBack.text = "00"
            minBack.text = "00"
            secBack.text = "00"
            break
        case .Hexadecimal: fallthrough
        default:
            secLabel.text = String(format: "0x%02X", time.seconds())
            minLabel.text = String(format: "0x%02X", time.minute())
            hourLabel.text = String(format: "0x%02X", time.hour())
            hourBack.text = "0x00"
            minBack.text = "0x00"
            secBack.text = "0x00"
            break
        }
    }
    
    func switchClock(type: TimeType) {
        titleLabel.text = "Current Time (\(type.typeName))"
        
        secLabel.font = UIFont(name: "alarmclock", size: type.fontSize)
        secBack.font = UIFont(name: "alarmclock", size: type.fontSize)
        
        minLabel.font = UIFont(name: "alarmclock", size: type.fontSize)
        minBack.font = UIFont(name: "alarmclock", size: type.fontSize)
        
        hourLabel.font = UIFont(name: "alarmclock", size: type.fontSize)
        hourBack.font = UIFont(name: "alarmclock", size: type.fontSize)
        
        updateClock(type: type)

        guard let _ = globalTimer else {
            globalTimer = NSTimer.every(1.0.seconds, { 
                self.updateClock(type: type)
            })
            return
        }
        
        globalTimer.invalidate()
        globalTimer = NSTimer.every(1.0.seconds, { 
            self.updateClock(type: type)
        })
    }
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {

        let type = TimeType.typeForBaseNotation(notation: item.title!)
        switchClock(type)
    }
    
    func toggleTabBar() {
        if timeTypeSettings.hidden {
            timeTypeSettings.animation.moveY(-timeTypeSettings.height).animateWithCompletion(0.5, { (_) in
                self.timeTypeSettings.hidden = false
            })
        } else {
            timeTypeSettings.animation.moveY(timeTypeSettings.height).animateWithCompletion(0.5, { (_) in
                self.timeTypeSettings.hidden = true
            })
        }
    }
}

enum TimeType: Int {
    case Binary = 2
    case Octal = 8
    case Decimal = 10
    case Hexadecimal = 16
    
    var typeName: String {
        switch rawValue {
        case 2:
            return "Bin"
        case 8:
            return "Oct"
        case 10:
            return "Dec"
        case 16: fallthrough
        default:
            return "Hex"
        }
    }
    
    var fontSize: CGFloat {
        switch rawValue {
        case 2:
            return 25
        case 8:
            return 30
        case 10: fallthrough
        case 16: fallthrough
        default:
            return 40
        }
    }
    
    static func typeForBaseNotation(notation n: String) -> TimeType {
        switch n {
        case "b2":
            return .Binary
        case "b8":
            return .Octal
        case "b10":
            return .Decimal
        case "b16": fallthrough
        default:
            return .Hexadecimal
        }
    }
}
