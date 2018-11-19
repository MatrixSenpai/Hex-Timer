//
//  UIKit.swift
//  Hex Timer
//
//  Created by Mason Phillips on 11/19/18.
//  Copyright © 2018 Matrix Studios. All rights reserved.
//

import UIKit
import FontAwesome_swift

class SystemLabel: UILabel {
    
    var topInset   : CGFloat = 0.0
    var bottomInset: CGFloat = 0.0
    var leftInset  : CGFloat = 0.0
    var rightInset : CGFloat = 0.0
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
    
    init(_ position: NSTextAlignment = .left, size: CGFloat? = nil, color: UIColor = .flatGrayDark) {
        super.init(frame: CGRect())
        
        textColor = color
        textAlignment = position
        font = .systemFont(ofSize: size ?? UIFont.systemFontSize)
    }
    
    convenience init(_ position: NSTextAlignment = .center, _ color: UIColor = .flatGrayDark) {
        self.init(position, size: 30, color: color)
        font = UIFont(name: "alarmclock", size: 30)
        
        text = "00"
    }
    
    func update(with u: String, duration d: Double?, pad: Int = 0) {
        if text == u { return }
        
        fadeTransition(d ?? 0.4)
        text = u
    }
    
    func update(with i: Int, duration d: Double = 0.4, pad: Int = 0, radix: Int = 10) {
        let f: String = String(i, radix: radix).pad(pad)
        self.update(with: f, duration: d)
    }
    
    func fadeTransition(_ duration: CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.type = .fade
        
        animation.duration = duration
        
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
