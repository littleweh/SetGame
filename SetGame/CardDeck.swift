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

    init() {
        for color in SetColor.all {
            for symbol in SetSymbol.all {
                for shading in SetShading.all {
                    for number in SetNumber.all {
                        cards.append(
                            Card(
                                number: number,
                                symbol: symbol,
                                shading: shading,
                                color: color
                            )
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
