//
//  CardDeck.swift
//  SetGame
//
//  Created by 典萱 高 on 2018/3/17.
//  Copyright © 2018年 LostRfounds. All rights reserved.
//

import Foundation

struct CardDeck {
    private(set) var cards = [Card]()
    private var features = [CardFeature]()

    init() {
        // need to use recursive or other method?
        for feature1 in CardFeature.all{
            for feature2 in CardFeature.all {
                for feature3 in CardFeature.all {
                    for feature4 in CardFeature.all {
                        cards.append(
                            Card(features: [feature1, feature2, feature3, feature4])
                        )
                    }
                }
            }
        }

    }

    mutating func draw() -> Card? {
        if cards.count > 0 {
            print(cards.count)
            return cards.remove(at: cards.count.arc4random)
        } else {
            return nil
        }
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(self)))
        } else {
            return 0
        }
    }
}
