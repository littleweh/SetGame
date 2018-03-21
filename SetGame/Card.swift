//
//  Card.swift
//  SetGame
//
//  Created by 典萱 高 on 2018/3/17.
//  Copyright © 2018年 LostRfounds. All rights reserved.
//

import Foundation

struct Card: Equatable {
    static func ==(lhs: Card, rhs: Card) -> Bool {
        if lhs.features.isEmpty || rhs.features.isEmpty || lhs.features.count != CardFeatureItem.all.count || rhs.features.count != CardFeatureItem.all.count {
            return false
        }
        for featureItem in CardFeatureItem.all {
            if lhs.features[featureItem.rawValue] != rhs.features[featureItem.rawValue] {
                return false
            }
        }
        return true
    }

    var features = [CardFeature]()
    var isSelected:Bool = false

    init(features: [CardFeature]) {
        self.features = features
    }


}
