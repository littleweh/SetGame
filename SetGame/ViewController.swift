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

    var cards = [Card]() {
        didSet {
            updateCardsDealed()
        }
    }

    @IBOutlet var cardButtons: [UIButton]!
    @IBAction func dealThreeCardsButtonTapped(_ sender: UIButton) {
        if cards.count + 3 <= cardButtons.count {
            addThreeCards()
        } else {
            let alert = UIAlertController(title: "cards number limits", message: "Due to screen limit, cards can not be added", preferredStyle: UIAlertControllerStyle.alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                self.dismiss(animated: true, completion: nil)
            })
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }

    @IBAction func cardButtonTapped(_ sender: UIButton) {

        sender.reversesTitleShadowWhenHighlighted = false
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
//        for _ in 1...12 {
//            if let card = deck.draw(){
//                for item in CardFeatureItem.all {
//                    let index = item.rawValue
////                    cardFeatureCheckSum[index] += card.features[index].rawValue
//                    print("\(item.description): \(card.features[index].rawValue)")
//                }
//            }
//        }

        // check set match
//        for i in 0..<CardFeatureItem.all.count {
//            if cardFeatureCheckSum[i] % 3 != 0 {
//                print("cardFeatureCheckSum \(i)")
//                print("not a set")
//                break
//            }
//        }


        gameStart()

        print("end")
    }

    func addThreeCards() {
        for _ in 0..<3 {
            if let card = deck.draw() {
                cards.append(card)
            }
        }
    }

    func gameStart() {
        for _ in 0..<12 {
            if let card = deck.draw() {
                cards.append(card)
            }
        }
    }

    func updateCardsDealed() {
        for cardIndex in cardButtons.indices {
            if Int(cardIndex) < cards.endIndex {
                cardButtons[cardIndex].backgroundColor = .white
                let card = cards[cardIndex]
                let title = getCardPip(with: card)
                cardButtons[cardIndex].setAttributedTitle(title, for: .normal)
                cardButtons[cardIndex].setAttributedTitle(title, for: .selected)
            } else {
                cardButtons[cardIndex].backgroundColor = .clear
            }
        }

    }

    func getCardPip(with card: Card) -> NSAttributedString? {
        let symbolIndex = CardFeatureItem.symbol.rawValue
        let colorIndex = CardFeatureItem.color.rawValue
        let numberIndex = CardFeatureItem.number.rawValue
        let shadingIndex = CardFeatureItem.shading.rawValue

        guard
            let symbol = SetSymbol(rawValue: card.features[symbolIndex].rawValue),
            let number = SetNumber(rawValue: card.features[numberIndex].rawValue),
            let color = SetColor(rawValue: card.features[colorIndex].rawValue),
            let shading = SetShading(rawValue: card.features[shadingIndex].rawValue)
        else {
            print("invalid card")
            return nil
        }

        print("symbol: " + symbol.description)
        print("color: \(color.uiColor)")
        print("number: " + number.description)
        print("shading: " + shading.description)

        let title = String(repeating: symbol.description, count: Int(number.description)!)

        let attribute = NSAttributedString(
            string: title,
            attributes: [
                NSAttributedStringKey.strokeColor : color.uiColor,
                NSAttributedStringKey.strokeWidth : -8,
                NSAttributedStringKey.foregroundColor : color.uiColor.withAlphaComponent(shading.alpha)
            ]
        )

        return attribute

    }



}

