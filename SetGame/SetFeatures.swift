//
//  SetFeatures.swift
//  SetGame
//
//  Created by 典萱 高 on 2018/3/19.
//  Copyright © 2018年 LostRfounds. All rights reserved.
//

import Foundation
import UIKit

enum SetNumber: Int, CustomStringConvertible {
    var description: String {
        return "\(self.rawValue + 1)"
    }

    case one = 0, two, three
    static var all = [SetNumber.one, .two, .three]
}


enum SetSymbol: Int, CustomStringConvertible {
    var description: String {
        switch self {
        case .diamond: return "▲"
        case .squiggle: return "◼︎"
        case .oval: return "●"
        }
    }

    case diamond = 0, squiggle, oval
    static var all = [SetSymbol.diamond, .squiggle, .oval]

}

enum SetShading: Int, CustomStringConvertible {
    var description: String {
        switch self {
        case .solid: return "solid"
        case .striped: return "striped"
        case .open: return "open"
        }
    }

    var alpha: CGFloat {
        switch self {
        case .solid: return 1.0
        case .striped: return 0.15
        case .open: return 0.0
        }
    }
    case solid = 0, striped, open
    static var all = [SetShading.solid, .striped, .open]
}

enum SetColor: Int {
    case red = 0, green, blue
    var uiColor: UIColor {
        switch self {
        case .red: return UIColor(red: 223/255.0, green: 4/255.0, blue: 4/255.0, alpha: 1.0)
        case .green: return UIColor(red: 4/255.0, green: 223/255.0, blue: 4/255.0, alpha: 1.0)
        case .blue: return UIColor(red: 78/255.0, green: 14/255.0, blue: 216/255.0, alpha: 1.0)
        }
    }
    static var all = [SetColor.red, .green, .blue]
}
