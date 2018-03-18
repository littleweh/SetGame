//
//  ViewController.swift
//  SetGame
//
//  Created by 典萱 高 on 2018/3/17.
//  Copyright © 2018年 LostRfounds. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var deck = CardDeck()

    @IBAction func cardButtonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected == true {
            sender.layer.borderColor = UIColor.yellow.cgColor
            sender.layer.borderWidth = 3.0
        } else {
            sender.layer.borderColor = UIColor.clear.cgColor
            sender.layer.borderWidth = 0.0
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // check card

        var cardFeatureCheckSum: [Int] = Array(repeating: 0, count: CardFeatureItem.all.count)
        for _ in 1...3 {
            if let card = deck.draw(){
                for item in CardFeatureItem.all {
                    let index = item.rawValue
                    cardFeatureCheckSum[index] += card.features[index].rawValue
                    print("\(item.description): \(card.features[index].rawValue)")
                }
            }
        }

        // check set match
        for i in 0..<CardFeatureItem.all.count {
            if cardFeatureCheckSum[i] % 3 != 0 {
                print("cardFeatureCheckSum \(i)")
                print("not a set")
                break
            }
        }
        print("end")
    }



}

