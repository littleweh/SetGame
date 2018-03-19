//
//  CardFeatures.swift
//  SetGame
//
//  Created by 典萱 高 on 2018/3/17.
//  Copyright © 2018年 LostRfounds. All rights reserved.
//

import Foundation

enum CardFeatureItem: Int, CustomStringConvertible {

    var description: String {
        switch self {
        case .color: return "color"
        case .number: return "number"
        case .symbol: return "symbol"
        case .shading: return "shading"
        }
    }

    case color = 0
    case number = 1
    case symbol = 2
    case shading = 3

    static var all = [CardFeatureItem.color, .number, .symbol, .shading]
}

enum CardFeature: Int {
    case one = 0, two, three
    static var all = [CardFeature.one, .two, .three]
}


