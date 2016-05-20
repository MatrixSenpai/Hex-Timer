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

class mainViewController: UIViewController, UITabBarDelegate {
    
    let titleLabel: UILabel = UILabel()
    
    let hourLabel: UILabel = UILabel()
    let minLabel: UILabel = UILabel()
    let secLabel: UILabel = UILabel()
    
    var globalTimer: NSTimer!
    
    var timeTypeSettings: UITabBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.font = UIFont.systemFontOfSize(30)
        titleLabel.textAlignment = .Center
        titleLabel.backgroundColor = FlatGray()
        view.addSubview(titleLabel)

        hourLabel.font = UIFont.systemFontOfSize(40)
        hourLabel.backgroundColor = FlatGrayDark()
        hourLabel.textAlignment = .Center
        view.addSubview(hourLabel)
        
        minLabel.font = UIFont.systemFontOfSize(40)
        minLabel.backgroundColor = FlatGrayDark()
        minLabel.textAlignment = .Center
        view.addSubview(minLabel)
        
        secLabel.font = UIFont.systemFontOfSize(40)
        secLabel.backgroundColor = FlatGrayDark()
        secLabel.textAlignment = .Center
        view.addSubview(secLabel)
                
        view.backgroundColor = FlatGray()
        
        let normal = UIImage.fontAwesomeIconWithName(.ClockO, textColor: .blackColor(), size: CGSizeMake(20, 20))
        let select = UIImage.fontAwesomeIconWithName(.CircleO, textColor: .blackColor(), size: CGSizeMake(20, 20))
        
        let bin = UITabBarItem(title: "b2", image: normal, selectedImage: select)
        let oct = UITabBarItem(title: "b8", image: normal, selectedImage: select)
        let dec = UITabBarItem(title: "b10", image: normal, selectedImage: select)
        let hex = UITabBarItem(title: "b16", image: normal, selectedImage: select)

        timeTypeSettings = UITabBar()
        timeTypeSettings.items = [bin, oct, dec, hex]
        timeTypeSettings.selectedItem = hex
        timeTypeSettings.delegate = self
        view.addSubview(timeTypeSettings)
        
        updateClock(type: .Hexadecimal)
        globalTimer = NSTimer.every(1.0.seconds) {
            self.updateClock(type: .Hexadecimal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        let isRot = (UIDevice.currentDevice().orientation == .Portrait)
        let width: CGFloat = ((isRot) ? 100 : 150)
        let height: CGFloat = ((isRot) ? 100 : 90)
        
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
            secLabel.text = String(time.seconds(), radix: 2).pad(4)
            minLabel.text = String(time.minute(), radix: 2).pad(6)
            hourLabel.text = String(time.hour(), radix: 2).pad(6)
            break
        case .Octal:
            secLabel.text = String(format: "%02Ob8", time.seconds())
            minLabel.text = String(format: "%02Ob8", time.minute())
            hourLabel.text = String(format: "%02Ob8", time.hour())
            break
        case .Decimal:
            secLabel.text = String(format: "%02d", time.seconds())
            minLabel.text = String(format: "%02d", time.minute())
            hourLabel.text = String(format: "%02d", time.hour())
            break
        case .Hexadecimal: fallthrough
        default:
            secLabel.text = String(format: "0x%02X", time.seconds())
            minLabel.text = String(format: "0x%02X", time.minute())
            hourLabel.text = String(format: "0x%02X", time.hour())
            break
        }
    }
    
    func switchClock(type: TimeType) {
        globalTimer.invalidate()
        
        let size: CGFloat
        let t: String
        
        switch type {
        case .Binary:
            size = 25
            t = "Bin"
            break
        case .Octal:
            size = 30
            t = "Oct"
            break
        case .Decimal:
            size = 40
            t = "Dec"
        case .Hexadecimal: fallthrough
        default:
            size = 40
            t = "Hex"
            break
        }
        
        titleLabel.text = "Current Time (\(t))"
        secLabel.font = UIFont.systemFontOfSize(size)
        minLabel.font = UIFont.systemFontOfSize(size)
        hourLabel.font = UIFont.systemFontOfSize(size)
        
        updateClock(type: type)
        
        globalTimer = NSTimer.every(1.0.seconds, {
            self.updateClock(type: type)
        })
    }
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        
        let chars = item.title!.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet)
        let char = Int(chars.joinWithSeparator(""))
        
        let type = TimeType(rawValue: char!)
        switchClock(type!)
    }
}

enum TimeType: Int {
    case Binary = 2
    case Octal = 8
    case Decimal = 10
    case Hexadecimal = 16
}
