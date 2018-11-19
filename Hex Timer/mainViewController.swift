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
import AFDateHelper

class mainViewController: UIViewController, UITabBarDelegate {
    
    let titleLabel: SystemLabel
    
    let hourLabel: SystemLabel
    let hourBack : SystemLabel
    
    let minLabel : SystemLabel
    let minBack  : SystemLabel
    
    let secLabel : SystemLabel
    let secBack  : SystemLabel
    
    var globalTimer: Timer!
    
    let timeTypeSettings: UITabBar
    
    init() {
        let backColor: UIColor = UIColor.flatRedDark.withAlphaComponent(0.3)
        titleLabel = SystemLabel(.center, size: 12, color: .flatGrayDark)
        titleLabel.font = UIFont.italicSystemFont(ofSize: 12)
        
        hourLabel = SystemLabel(.right)
        hourBack  = SystemLabel(.right, backColor)
        
        minLabel   = SystemLabel(.center)
        minBack    = SystemLabel(.center, backColor)
        
        secLabel   = SystemLabel(.left)
        secBack    = SystemLabel(.left, backColor)
        
        // Tab bar
        let normal = UIImage.fontAwesomeIcon(name: .clock, style: .regular, textColor: .flatWhite, size: CGSize(width: 20, height: 20))
        let select = UIImage.fontAwesomeIcon(name: .circle, style: .regular, textColor: .flatBlack, size: CGSize(width: 20, height: 20))
        
        let bin = UITabBarItem(title: "b2", image: normal, selectedImage: select)
        let oct = UITabBarItem(title: "b8", image: normal, selectedImage: select)
        let dec = UITabBarItem(title: "b10", image: normal, selectedImage: select)
        let hex = UITabBarItem(title: "b16", image: normal, selectedImage: select)
        
        timeTypeSettings = UITabBar()
        timeTypeSettings.items = [bin, oct, dec, hex]
        timeTypeSettings.selectedItem = hex
        
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .flatBlackDark
        
        view.addSubview(titleLabel)
        view.addSubview(hourBack)
        view.addSubview(minBack)
        view.addSubview(secBack)
        
        view.addSubview(hourLabel)
        view.addSubview(minLabel)
        view.addSubview(secLabel)
        
        timeTypeSettings.delegate = self
        view.addSubview(timeTypeSettings)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Init clock
        switchClock(.hexadecimal)
    }

    override func viewWillLayoutSubviews() {
        let width: CGFloat = 140
        let height: CGFloat = 40
        
        view.groupInCenter(group: .horizontal, views: [hourBack,  minBack,  secBack ], padding: 3, width: width, height: height)
        view.groupInCenter(group: .horizontal, views: [hourLabel, minLabel, secLabel], padding: 3, width: width, height: height)
        
        titleLabel.alignAndFillWidth(align: .underCentered, relativeTo: minLabel, padding: 10, height: 14)
        
        timeTypeSettings.anchorAndFillEdge(.bottom, xPad: 0, yPad: 0, otherSize: ((UIDevice.current.orientation == .portrait) ? 75 : timeTypeSettings.intrinsicContentSize.height))
    }
    
    func updateClock(type t: TimeType) -> Void {
        let base = t.rawValue
        let pad = t.padValue()
        
        let time = Date()

        let seconds = time.component(.second)!
        let minutes = time.component(.minute)!
        let hours   = time.component(.hour)!
        
        secLabel.update(with: seconds, duration: 0.2, pad: pad, radix: base)
        minLabel.update(with: minutes, duration: 0.2, pad: pad, radix: base)
        hourLabel.update(with: hours, duration: 0.2, pad: pad, radix: base)
        
        let bString = "0".pad(pad)
        secBack.text = bString
        minBack.text = bString
        hourBack.text = bString
    }
    
    func switchClock(_ type: TimeType) {
        titleLabel.text = type.typeName
        
        updateClock(type: type)

        guard let _ = globalTimer else {
            globalTimer = Timer.every(1.0.seconds, { 
                self.updateClock(type: type)
            })
            return
        }
        
        globalTimer.invalidate()
        globalTimer = Timer.every(1.0.seconds, { 
            self.updateClock(type: type)
        })
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let type = TimeType.typeForBaseNotation(notation: item.title!)
        switchClock(type)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
