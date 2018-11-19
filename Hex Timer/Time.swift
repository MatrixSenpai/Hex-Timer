//
//  Time.swift
//  Hex Timer
//
//  Created by Mason Phillips on 200516.
//  Copyright © 2016 Matrix Studios. All rights reserved.
//

import UIKit

extension String {
    func pad(_ length: Int, _ side: Bool = true) -> String {
        let diff = length - self.count
        if diff > 0 {
            var padded = self
            for _ in 0..<diff {
                padded = (side) ? "0" + padded : padded + "0"
            }
            return padded
        } else {
            return self
        }
    }
}

enum TimeType: Int {
    case binary      = 2
    case octal       = 8
    case decimal     = 10
    case hexadecimal = 16
    
    var typeName: String {
        switch self {
        case .binary     : return "Binary"
        case .octal      : return "Octal"
        case .decimal    : return "Decimal"
        case .hexadecimal: return "Hexadecimal"
        }
    }

    func padValue() -> Int {
        switch self {
        case .binary     : return 6
        case .octal      : return 6
        case .decimal    : return 2
        case .hexadecimal: return 2
        }
    }
    
    static func typeForBaseNotation(notation n: String) -> TimeType {
        switch n {
        case "b2" : return .binary
        case "b8" : return .octal
        case "b10": return .decimal
        case "b16": return .hexadecimal
        default   : return .hexadecimal
        }
    }
}
