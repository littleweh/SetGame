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

    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 1...5 {
            let card = deck.draw()
            print(card?.color)
            print(card?.number)
            print(card?.shading)
            print(card?.symbol)
        }
    }


}

